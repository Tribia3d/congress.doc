<style>img {float:right;margin:1rem;}
h1, h2, h3, h4, h5, h6 { clear:both;}
</style>
# Congress : Propriétés des objets 3D
Toutes les propriétés réglées via l'outil maxscript sont stockées dans chaque objet en JSON. Cela permet à l'appli web de les trier et de les traiter différemment (clic, orientation, matériaux, etc.)

## 1. Types d'objets
![](images/props-types.png)

- [billboard](#billboard)
- [booth](#booth)
- [booth_camera](#booth_camera)
- [booth_model](#booth_model)
- [booth_silhouette](#booth_silhouette)
- [camera](#camera)
- [camera_position](#camera_position)
- [conference](#conference)
- [envmap](#envmap)
- [goto_booth](#goto_booth)
- [goto_position](#goto_position)
- [goto_zone](#goto_zone)
- [ground](#ground)
- [lab](#lab)
- [lightmap](#lightmap)
- [product](#product)
- [product_standalone](#product_standalone)
- [autres](#autres)

### billboard
A utiliser avec une plane qui sera orientée en permanence vers la caméra. Ex: les panneaux au dessus du démonstrateur.
```warning
Le pivot de l'objet doit être centré et orienté avec l'axe Y rentrant dans l'objet.
```

### booth
![](images/props-booth.png)
L'objet sera traité comme un Booth par l'appli web, il sera cliquable (si l'uuid existe) et les éléments qui le composent seront eux aussi traités de manière particulière.

Il est nécessaire de remplir le champ `UUID` pour pouvoir interagir avec le stand durant la visite. Cette donnée est à récupérer depuis la base de donnée.

Si le champ `boothModel` est spécifié, cet objet sera remplacé au runtime par l'objet 3d de type [booth_model](#booth_model) dont le champ `boothModel` est identique.

Voir [3. Mise en place d'un stand](#3-mise-en-place-dun-stand) pour plus d'informations.

### booth_camera
Une ou plusieurs caméras peuvent être définies pour un stand (en cas de points de vue multiples, des sprites permettant de passer de l'une à l'autre seront affichées).

Ces caméras doivent être parentées à un objet de type [booth](#booth) ou [booth_model](#booth_model).

```warning
Si aucune caméra n'est définie pour un stand, il sera impossible d'y accéder.
```

### booth_model
![](images/props-booth_model.png)
L'objet sera cloné/instancié sur les objets du type [booth](#booth) selon la correspondance des champs `boothModel`.

Il y aura normalement une lightmap bakée pour ce stand, donc il est intéressant de l'indiquer dans le champ `useLightmap` de cet objet.

Afin d'afficher le tooltip Kinoba d'information sur le stand, on peut cocher la case `booth_tooltip` dans *divers* en bas.

Voir [3. Mise en place d'un stand](#3-mise-en-place-dun-stand) pour plus d'informations.

### booth_silhouette
Cet objet sera remplacé au runtime par un billboard représentant une silhouette (si un exposant est disponible). On utilisera un objet Point/Dummy positionné au niveau du sol et aux emplacements où l'on souhaite voir apparaître une silhouette.

Il peut y en avoir plusieurs par stand.

### camera
C'est la caméra utilisée comme point de vue de départ lors de l'arrivée dans une Zone.

```warning
Elle est unique, et INDISPENSABLE au bon chargement de la Zone !
```

### camera_position
### conference
### envmap
### goto_booth
### goto_position
### goto_zone
### ground
### lab
### lightmap
### product
### product_standalone
### autres
- elevator
- elevator_camera
- product_animated









## 2. Mise en place d'un stand

### 2.1 Fonctionnement
En général, la mise en place d'un stand se déroule en deux temps. On crée un *modèle de stand* auquel sont parentés tous les éléments de ce stand (meshes, caméras, etc.). Ensuite on positionne les stands sous forme de Points aux positions réelles où doivent se trouver les stands dans la zone. Au runtime les points seront remplacés par les modèles. Cela permet de réduire la taille du fichier 3d exporté, l'instanciation est réalisée par l'appli web.

Pour les stands particuliers (stands premium personnalisés) il n'est pas nécessaire d'utiliser de "modèle de stand" puisqu'ils seront uniques.

```note
L'utilisation des [booth_model](#booth_model) n'est pas du tout obligatoire.

Mais lorsqu'il y a beaucoup de stands identiques, en plus de réduire le poids des fichiers exportés, cela permet de n'effectuer qu'une seule fois les modifications, le baking et les réglages des objets enfants.
```
Pour illustrer les 2 cas de figure :

#### 2.1.1 Sans modèle
![](images/props-booth-without-model.png)

Dans le cas où on n'utilise **pas** de modèle, le parent (Point) est directement défini comme [booth](#booth) et son `UUID` est spécifié. `useLightmap` contient le nom de la lightmap à appliquer sur les objets enfants, et `booth_tooltip` est coché tout en bas, ce qui permettra d'afficher le tooltip Kinoba avec la description et le bouton pour "accéder" au stand.

#### 2.1.2 Avec modèle
![](images/props-booth-with-model.png)

Dans le cas où on utilise un modèle de stand, on trouve à gauche les propriétés du modèle (type [booth_model](#booth_model)), et à droite les propriétés du stand (type [booth](#booth)) sur lequel on va instancier le modèle. On voit tout de suite (en vert) que la propriété `boothModel` est identique.

En ce qui concerne le **modèle** :
- <span class="color-box" style="background-color: #0055c8"/> Type [booth_model](#booth_model)
- <span class="color-box" style="background-color: #00881a"/> Nom du modèle dans `boothModel`
- On ne spécifie **pas** d'`UUID` puisque ce modèle sera instancié sur plusieurs **stands** qui auront des `UUID` différents.
- <span class="color-box" style="background-color: #570288"/> Si une [lightmap](#lightmap) a été baké pour ce stand indiquer son nom dans le champ `useLightmap` (une liste déroulante indique les noms des lightmaps présentes dans la scène max)
- <span class="color-box" style="background-color: #570288"/> On coche `booth_tooltip` afin d'ouvrir le tooltip Kinoba. On aurait pu le cocher au niveau du stand lui même, mais il faudrait alors le cocher pous tous les stands, c'est plus simple ici)

Et pour le **stand** :
- <span class="color-box" style="background-color: #c87a00"/> Type [booth](#booth)
- <span class="color-box" style="background-color: #c87a00"/> UUID du stand
- <span class="color-box" style="background-color: #00881a"/> Nom du modèle dans `boothModel`









