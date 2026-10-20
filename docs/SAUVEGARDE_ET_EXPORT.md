# Sauvegarde, export et import

Toute la progression est dans un seul fichier, `iqura_user.db`, rangé dans
le dossier privé de l'application. Le contenu pédagogique
(`iqura_content.db`) est livré avec l'application et n'est jamais exporté.

## Sauvegardes locales automatiques

Paramètres › Sauvegarde et transfert › **Sauvegardes locales**.

- Une sauvegarde **automatique par jour**, au démarrage (une fois le profil
  créé).
- Une sauvegarde **avant chaque import** et **avant chaque restauration**.
- Bouton « Sauvegarder maintenant ».
- Les 15 sauvegardes les plus récentes sont gardées ; les plus anciennes
  sont effacées.
- Une sauvegarde peut être restaurée ou supprimée. Restaurer remplace la
  progression actuelle, qui est elle-même sauvegardée juste avant.

Ces sauvegardes restent sur l'appareil : elles disparaissent si
l'application est désinstallée. Pour garder une copie ailleurs, utilisez
l'export.

## Passer d'un appareil à l'autre

1. Sur l'appareil d'origine : Paramètres › **Exporter ma progression**.
   Choisissez où enregistrer le fichier `iqura-progression-AAAAMMJJ-HHMM.zip`.
2. Copiez ce fichier sur l'autre appareil (câble, clé USB, cloud, e-mail…).
3. Sur l'autre appareil : Paramètres › **Importer une progression** (ou,
   au premier lancement, « J'ai déjà une progression : l'importer »).
4. Vérifiez le résumé (profil, date, version), puis choisissez :
   - **Fusionner (recommandé)** : pour chaque élément modifiable (profil,
     réglages), la version la plus récente l'emporte ; les historiques
     (révisions, gains d'expérience) des deux appareils sont réunis, sans
     doublon. Fusionner deux fois la même archive ne change rien.
   - **Restauration complète** : la progression de cet appareil est
     entièrement remplacée par celle de l'archive.

Dans les deux cas, une sauvegarde locale est faite juste avant : en cas
d'erreur, restaurez-la depuis « Sauvegardes locales ».

## Format de l'archive (version 1)

Archive ZIP contenant :

```
manifest.json
tables/profile.json
tables/settings.json
tables/review_log.json
tables/xp_ledger.json
```

`manifest.json` :

```json
{
  "format": "iqura-export",
  "format_version": 1,
  "schema_version": 1,
  "app_version": "0.1.0",
  "created_at": "2026-10-20T12:00:00.000Z",
  "device_id": "<UUID v7 de l'appareil>",
  "files": [
    { "path": "tables/profile.json", "sha256": "<hex>", "size": 123, "rows": 1 }
  ]
}
```

Chaque `tables/<table>.json` :

```json
{ "table": "profile", "columns": ["id", "pseudo", "..."], "rows": [["main", "Amina", "..."]] }
```

### Règles de fusion

| Table | Type | Règle |
| --- | --- | --- |
| `profile` | Modifiable | Une seule ligne (`id = "main"`) ; la date HLC la plus récente gagne |
| `settings` | Modifiable | Une ligne par réglage ; la date HLC la plus récente gagne |
| `review_log` | Journal | Union par identifiant (UUID v7), rien n'est retiré |
| `xp_ledger` | Journal | Union par identifiant ; `unique_key` empêche de compter deux fois un même gain |

Les lignes modifiables portent `updated_hlc` (horloge logique hybride :
`millisecondes:compteur:appareil`) et `deleted` (une suppression est un
marqueur qui se propage). La table `local_meta` (identifiant de l'appareil,
horloge) n'est jamais exportée.

### Contrôles à l'import

L'archive est entièrement vérifiée **avant** toute modification :

- taille du fichier ≤ 100 Mo, taille déclarée de chaque fichier interne
  ≤ 200 Mo, total ≤ 400 Mo (la décompression ne dépasse jamais la taille
  déclarée) ;
- uniquement les fichiers attendus (liste blanche de noms exacts : aucun
  chemin, lien ou dossier) ;
- empreinte SHA-256 de chaque fichier égale à celle de l'en-tête ;
- version du format et du schéma non plus récentes que l'application ;
- colonnes connues, colonnes obligatoires présentes, type de chaque valeur,
  identifiants uniques et non vides, dates HLC et marqueurs valides.

L'import s'applique ensuite dans une seule transaction : en cas d'erreur,
rien n'est modifié.
