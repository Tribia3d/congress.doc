# Produits customisables

La version où cette fonctionnalité a été introduite dans l'outil maxscript est `1.0.26`.

## Modélisation
- Ce peut etre un objet unique ou bien une hiérarchie
- L'objet parent doit avoir le type `product_customizable` et un id dans `productCustomizableId` (uuid ou n'importe quoi d'autre tant que c'est unique)
- Son pivot doit être centré et l'axe Z orienté vers la caméra
- Les sous-objets modifiables doivent avoir la propriété `Product Customizable Element` cochée
- Pour les textures :
    - soit placer une objet par dessus et lui appliquer un matériau avec l'option Babylon `blend` et un png transparent
    - soit directement le matériau transparent sur l'objet, mais dans ce cas attention aux UVs et aux répétitions de la map

## Configuration
Cela se passe dans la partie `productCustomizables` et `customProps` du fichier de config `JSON`.

```json
...
"productCustomizables": [
    {
        "uuid": "438367a6-0286-4e7f-ad60-aa18f9666006", // uuid correspondant à celui indiqué dans 3ds
        "name": "casque audio", // le nom de l'objet affiché à l'écran
        "basePrice": 50, // le prix sans aucune option
        "customPropUuids":  [ // ajouter ici les uuid des couleurs/maps custom utilisables avec cet objet
            "70020266-e050-4e46-a135-61782e0deb15", // seconde couleur dans customProps
            "dfdc048d-9ea4-4043-b70a-044e6bce9603", // première map dans customProps
            "..." // autre customisation autorisée
        ]
    },
    {...} // autre produit suivant le même schéma
],
"customProps": { // liste des customisations possibles
    "colors": [ // couleur au format hexa, surcharge correspond au surcoût ajouté par l'option
        {"uuid":"03cd385b-8038-44c7-9497-c65c8000bbd4", "color": "#FFFFFF", "surcharge": 5},
        {"uuid":"70020266-e050-4e46-a135-61782e0deb15", "color": "#FF0000", "surcharge": 6},
        {...} // autre couleur custom
    ],
    "maps": [ // chemin des fichiers contenu dans le dossier public/ du repo
        {"uuid": "dfdc048d-9ea4-4043-b70a-044e6bce9603", "uri":  "assets/images/Arch31_045_ground.jpg", "surcharge": 20},
        {"uuid": "e85d2e0e-a0ae-4419-8af9-09baec56fafe", "uri":  "assets/images/BANDE.jpg", "surcharge": 21},
        {...} // autre texture custom
    ]
  }
``` 
> Exemple de contenu du fichier de config.json

