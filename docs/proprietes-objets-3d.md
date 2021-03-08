<style>img {float:right;margin:1rem;}
h1, h2, h3, h4, h5, h6 { clear:both;}
</style>
# Congress : Propriétés des objets 3D
## 1. Préambule
Toutes les propriétés réglées via l'outil maxscript sont stockées dans chaque objet en JSON. Cela permet à l'appli web de les trier et de les traiter différemment (clic, orientation, matériaux, etc.)

## 2. Types d'objets
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
- [gound](#gound)
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

Si le champ `boothModel` est spécifié, cet objet sera remplacé au runtime par l'objet 3d ayant le type [booth_model](#booth_model) et le même "nom" spécifié dans `boothModel` si il existe.


### booth_camera
### booth_model
### booth_silhouette
### camera
### camera_position
### conference
### envmap
### goto_booth
### goto_position
### goto_zone
### gound
### lab
### lightmap
### product
### product_standalone
### autres
- elevator
- elevator_camera
- product_animated









## 3. Mise en place d'un stand
En généra, la mise en place d'un stand se déroule en deux temps. On crée un "modèle de stand" auquel sont parentés tous les éléments de ce stand (meshes, caméras, etc.). Ensuite on positionne les stands sous forme de Points aux positions réelles où doivent se trouver les stands dans la zone. Au runtime les points seront remplacés par les modèles. Cela permet de réduire la taille du fichier 3d exporté, l'instanciation est réalisée par l'appli web.

Pour les stands particuliers (stands premium personnalisés) il n'est pas nécessaire d'utiliser de "modèle de stand".

```note
Ce qu'il faut bien comprendre c'est que le 
```

### Le modèle du stand
Le modèle de stand [booth_model](#booth_model) sera instancié par dessus les objets [booth](#booth) ayant référencé ce modèle.

### Le stand
Pour être reconnu en tant que stand, un objet doit être typé comme [booth](#booth).














