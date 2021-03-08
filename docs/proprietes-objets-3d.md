<style>img {float:right;}
h1, h2, h3, h4, h5, h6 { clear:both;}
</style>
# Congress : Propriétés des objets 3D


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

Si le champ `boothModel` est spécifié, cet objet sera remplacé au runtime par l'objet 3d ayant le type [`booth_model`](#booth_model) et le même "nom" spécifié dans `boothModel` si il existe.


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


