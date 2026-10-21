# Translittération

IQURA propose deux styles, au choix dans les paramètres :

- **savante (par défaut)** : norme *Arabica* ;
- **simplifiée** : sans signes diacritiques sous ou sur les consonnes.

Les deux sont produites par le moteur `lib/engines/transliteration/`, à partir du texte arabe vocalisé. Les tests vérifient chaque règle ci-dessous.

## Références

La norme *Arabica* est la translittération de la revue *Arabica* (Brill), dérivée de la norme DIN 31635. C'est la plus employée dans les publications scientifiques françaises.

- INALCO, *Système de translittération Arabica* : https://www.inalco.fr/sites/default/files/asset/document/translitteration_arabica.pdf
- Brill, *Arabica — Instructions for Authors*, qui demande ʾ (U+02BE) pour la hamza et ʿ (U+02BF) pour le ʿayn : https://brill.com/fileasset/downloads_products/Author_Instructions/ARAB.pdf
- Norme DIN 31635 (1982), *Umschrift des arabischen Alphabets*.

⚠️ Ces deux documents n'étaient pas accessibles depuis l'environnement de développement le 20 octobre 2026. La table ci-dessous a été établie à partir des descriptions publiques de la norme et doit être **recoupée avec le document de l'INALCO**. Statut : *rédigé par IA — non vérifié*.

## Consonnes

| Lettre | Nom | Savante (*Arabica*) | Simplifiée |
| --- | --- | --- | --- |
| ء (et أ إ ؤ ئ) | hamza | ʾ (non notée en début de mot) | ' (non notée en début de mot) |
| ب | bāʾ | b | b |
| ت | tāʾ | t | t |
| ث | ṯāʾ | ṯ | th |
| ج | ǧīm | ǧ | j |
| ح | ḥāʾ | ḥ | h |
| خ | ḫāʾ | ḫ | kh |
| د | dāl | d | d |
| ذ | ḏāl | ḏ | dh |
| ر | rāʾ | r | r |
| ز | zāy | z | z |
| س | sīn | s | s |
| ش | šīn | š | sh |
| ص | ṣād | ṣ | s |
| ض | ḍād | ḍ | d |
| ط | ṭāʾ | ṭ | t |
| ظ | ẓāʾ | ẓ | z |
| ع | ʿayn | ʿ | ` |
| غ | ġayn | ġ | gh |
| ف | fāʾ | f | f |
| ق | qāf | q | q |
| ك | kāf | k | k |
| ل | lām | l | l |
| م | mīm | m | m |
| ن | nūn | n | n |
| ه | hāʾ | h | h |
| و | wāw (consonne) | w | w |
| ي | yāʾ (consonne) | y | y |

## Voyelles et signes

| Signe | Savante | Simplifiée |
| --- | --- | --- |
| fatḥa ـَ | a | a |
| kasra ـِ | i | i |
| ḍamma ـُ | u | u |
| fatḥa + ا ou ى, alif suscrit ـٰ | ā | â |
| kasra + ي | ī | î |
| ḍamma + و | ū | û |
| fatḥa + وْ / يْ (diphtongues) | aw / ay | aw / ay |
| sukūn ـْ | (rien) | (rien) |
| shadda ـّ | consonne doublée | consonne doublée |
| tanwīn ـً ـٍ ـٌ | an, in, un (l'alif qui suit ـً n'est pas noté) | an, in, un |
| tāʾ marbūṭa ة | a en fin de mot ; at devant une voyelle | idem |
| alif maqṣūra ى | ā (après fatḥa) | â |

## Article

L'article s'écrit **al-** devant toutes les lettres, solaires comprises, sans assimilation ni redoublement : الشَّمْس → *al-šams*.

Après un mot terminé par une voyelle, la voyelle de l'article tombe (hamzat al-waṣl) : صَبَاحُ الْخَيْرِ → *ṣabāḥu l-ḫayri*.

## Limites

Le moteur traite l'arabe vocalisé courant (leçons, exemples construits, vocabulaire). Les signes propres à l'écriture du Mushaf (petits wāw et yāʾ, signes de pause, etc.) ne sont pas translittérés. Le texte coranique s'affiche toujours en écriture arabe.
