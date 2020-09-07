# Préparation Zone

## Outil Maxscript

Utiliser l'outil maxscript pour définir les propriétés, ou bien directement dans les `User Properties` de l'objet (clic droit => `Object Properties...` => `User Defined` => `babylonjs_tag={...}`)

[Téléchargement et indications pour utiliser l'outil.](outils-maxscript.md)

## Objets propres à la Zone
Tous les objets qui n'appartiennent pas à un Stand ou une Conférence, comme le sol des allées cliquable, et toutes les structures de l'espace. Il n'y pas de préparation particulière, à part pour le **sol** et la **caméra** de la Zone.
- Sol : `{"type":"ground"}`
- Caméra : `{"type":"camera"}` **Sans caméra pour la zone le chargement va planter**


## Stands
### 1. Instances

![base-zone-objects](images/base-zone-objects.png)

> Objets de base pour une zone : un ***sol*** (type `ground`), une ***caméra de zone*** (type `camera`), des ***modèles de stands*** en haut (type `booth_model` et `boothModel=nom_du_modèle`) avec des ***caméras de stand*** (type `booth_camera`), des ***Points*** placés à la position des stands à instancier (type `booth`, `id=uuid` et `boothModel=nom_du_modèle`).

#### Sources
Copier les différents modèle de stands dans un coin pour s'en servir comme source. On peut le parenter à un Dummy (ou Point), ou bien avoir un objet parent (comme dans le fichier implantation, dans lequel le sol du stand est le parent). Les propriétés du parent à régler sont :
```json
{"type":"booth_model","boothModel":"__source_name__"}
```
- `type = booth_model` Permet de savoir que cet objet est un modèle de Stand et qu'il faudra le copier sur des "cibles"
- `boothModel = __source_name__` Nom de ce modèle de Stand

#### Cibles
Les cibles (Dummy ou Point) doivent être positionnées et orientées à l'identique de l'implantation en respectant le point de pivot de la source (idéalement au centre en z = 0). Elles devront avoir les propriétés suivantes :
```json
{"type":"booth","id":"__uuid__","boothModel":"__source_name__"}
```
- `type = booth` Permet au viewer de savoir qu'il s'agit d'un Stand et qu'on peut interagir avec lui
- `id = __uuid__` Permet de savoir de quel Stand il s'agit (uuid stockés en base)
- `boothModel = __source_name__` Nom du modèle de Stand (source) à copier sur cette cible (sera "enfant" de cet objet)

### 2. Produits
Les produits / innovations se présenteront sous forme de Plane carré pour pouvoir gérer les formats portrait et paysages plus facilement (ça peut changer selon les problèmes techniques qui peuvent survenir). **Leur pivot doit être au centre, avec l'axe Y pointant vers l'arrière** (Z vers le haut, X vers la droite). Pour cette raison il ne faudra PAS faire de ~~`Reset XForm`~~ sur les produits, ça va reset l'orientation du pivot.

![orientation-pivot-product](images/orientation-pivot-product.png)

> Le pivot (en local) est orienté de telle façon que Y pointe vers l'arrière)

Leurs propriétés sont du type :
```json
{"type":"product","media_type":"texture","key_3d":"poster"}
```
- `type = product` Permet au viewer de savoir qu'il s'agit d'un produit / innovation
- `media_type = texture` Permet au viewer d'afficher la texture sur l'objet (il y a aussi `pdf` et `video`)
- `key_3d = poster` Clé générique qui permet au viewer de savoir quelle texture afficher (lien directement fourni par la bdd)

**Ne pas se focaliser là dessus pour l'instant, ça va changer avec les nouveaux `key_3d` introduits par Kinoba...**
