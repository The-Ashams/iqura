"""Nettoyage des fichiers produits par la synthèse vocale.

Les modèles autorégressifs comme Chatterbox ajoutent souvent, après le texte
demandé, une pause puis des sons parasites. On ne garde que la première prise
de parole :

1. découpage du signal en trames de 20 ms et mesure de l'énergie ;
2. une trame est « parlée » si son énergie dépasse une fraction de l'énergie
   maximale ;
3. les zones parlées séparées par moins de `max_gap` sont fusionnées (pauses
   normales entre les mots d'une phrase) ;
4. la fin de la première zone est prolongée tant que l'énergie reste au-dessus
   d'un seuil plus bas (`decay_threshold`) : la fin d'une voyelle longue
   s'éteint doucement et ne doit pas être coupée ;
5. on garde cette zone, avec une petite marge avant et après, et un fondu de
   fin pour éviter un clic.

`expected_min_duration` permet de détecter un résultat tronqué : l'appelant
régénère alors avec une autre graine.
"""

from __future__ import annotations

from dataclasses import dataclass

import numpy as np

FRAME = 0.02  # secondes


@dataclass
class TrimResult:
    audio: np.ndarray
    speech_start: float
    speech_end: float
    dropped_seconds: float  # durée de parole parasite retirée après la coupure

    @property
    def speech_duration(self) -> float:
        return self.speech_end - self.speech_start


def frame_energy(x: np.ndarray, sr: int) -> np.ndarray:
    fr = max(1, int(sr * FRAME))
    n = len(x) // fr
    return np.sqrt(np.mean(x[: n * fr].reshape(n, fr) ** 2, axis=1))


def voiced_regions(x: np.ndarray, sr: int, rel_threshold: float = 0.05,
                   max_gap: float = 0.25) -> list[tuple[float, float]]:
    """Zones parlées (début, fin) en secondes, pauses courtes fusionnées."""
    energy = frame_energy(x, sr)
    n = len(energy)
    if n == 0:
        return []
    peak = float(energy.max())
    if peak <= 0:
        return []
    voiced = energy > max(peak * rel_threshold, 1e-4)
    regions: list[list[int]] = []
    start = None
    for j, v in enumerate(voiced):
        if v and start is None:
            start = j
        elif not v and start is not None:
            regions.append([start, j])
            start = None
    if start is not None:
        regions.append([start, n])
    gap_frames = int(round(max_gap / FRAME))
    merged: list[list[int]] = []
    for r in regions:
        if merged and r[0] - merged[-1][1] <= gap_frames:
            merged[-1][1] = r[1]
        else:
            merged.append(r)
    return [(a * FRAME, b * FRAME) for a, b in merged]


def trim_first_utterance(x: np.ndarray, sr: int, *, rel_threshold: float = 0.05,
                         max_gap: float = 0.25, lead: float = 0.05,
                         tail: float = 0.12, fade: float = 0.03,
                         decay_threshold: float = 0.01,
                         max_decay: float = 0.3) -> TrimResult:
    if x.ndim > 1:
        x = x.mean(axis=1)
    regions = voiced_regions(x, sr, rel_threshold, max_gap)
    if not regions:
        raise ValueError("aucune parole détectée")
    start, end = regions[0]
    energy = frame_energy(x, sr)
    floor = float(energy.max()) * decay_threshold
    limit = regions[1][0] if len(regions) > 1 else len(x) / sr
    limit = min(limit, end + max_decay)
    j = int(round(end / FRAME))
    while j < len(energy) and (j + 1) * FRAME <= limit and energy[j] > floor:
        j += 1
    end = max(end, j * FRAME)
    dropped = sum(b - a for a, b in regions[1:])
    a = max(0, int((start - lead) * sr))
    b = min(len(x), int((end + tail) * sr))
    out = x[a:b].astype(np.float32).copy()
    nf = min(len(out), int(fade * sr))
    if nf > 0:
        out[-nf:] *= np.linspace(1.0, 0.0, nf, dtype=np.float32)
    return TrimResult(out, start, end, dropped)


def expected_min_duration(text: str) -> float:
    """Durée minimale plausible d'une lecture : 45 ms par lettre arabe
    (signes vocaliques exclus), au moins 0,12 s. Sert à repérer une coupure
    trop tôt ; volontairement large."""
    letters = sum(1 for c in text if "ء" <= c <= "ي")
    return max(0.12, 0.045 * letters)
