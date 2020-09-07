# Outils Maxscript
Pour faciliter le réglage des propriétés des objets, il y a des petits scripts qui permettent de définir les paramètres sans trop se préoccuper de la forme du code requis.

# Propriétés des objets

[Outil téléchargeable ICI](maxscripts/TRIBIA_CongressUserProperties.ms)

![maxscript-description](images/maxscript-description.png)

- **type** :
    - `booth` : défini cet objet comme un Stand. Il faudra également remplir `id` pour spécifier de quel stand il s'agit (et éventuellement `booth_model` si on veut instancier un modèle de stand sur le dummy).
    - `booth_camera` : défini cette caméra comme caméra de stand. **Nécessaire pour pouvoir entrer sur le stand !**
    - `booth_model` : défini cet objet comme modèle de stand. Il faudra spécifier un nom dans `boothModel` plus bas.
    - `camera` : défini cet caméra comme caméra de zone. **Nécessaire pour le bon chargement de la zone !**
    - `goto_zone` : défini cet objet comme cliquable pour charger la zone définie dans `id`
    - `ground` : défini cet objet comme sol cliquable pour les déplacement dans la zone. **Nécessaire si on veut pouvoir se déplacer dans la zone**
    - `lightmap` : nom de la lightmap contenue dans le matériau de cet objet. L'objet ne sera pas affiché et la lightmap sera copiée sur les matériaux des objets possédant la propriété `useLightmap` avec la même nom
    - `envmap` : idem que `lightmap` mais pour les map de réflexion. Utiliser `useEnvmap` sur les objets pour appliquer la map sur son matériau.
    - `product` : défini l'objet comme un produit, il faudra spécifier `media_type` et `key_3d`
- **booth & goto_zone**
    - `id` : uuid du stand (ex `5efb49ef2bac05001bf10e54`) ou uuid de la zone à charger (ex `6795ec46-b54b-46fb-9059-003a5cadca5b` pour l'accueil)
    - `boothModel` : si `type=booth_model` alors on défini le nom de ce modèle. Si `type=booth` on va copier le modèle à la position/rotation de cet objet.
- **product**
    - `media_id` : défini le type de produit à afficher (texture, pdf, video)
    - `key_3d` : clé générique pour le placement du média (`logo`, `totem`, `innovation_1_image_1`, `innovation_2_video_1`, etc.)
- **lightmap & envmap**
    - `lightmap` : nom de la lightmap du slot diffuse du matériau appliqué à cet objet. A utiliser si `type=lightmap` est spécifié.
    - `useLightmap` : nom de la lightmap à utiliser sur l'objet (peu importe le type). La lightmap sera appliquée au matériau de l'objet et tous les matériaux des "enfants" de cet objet (pas besoin de le spécifier sur chaque objet). **Si `none` est spécifié pour cette propriété alors aucune lightmap ne sera appliquée à cet objet.**
    - `envmap` :  idem `lightmap`   
    - `useEnvmap` :  idem `useLightmap`
- **instances**
    - `instanceSource` : défini cet objet comme un modèle d'instance qui sera éventuellement cloné sur d'autres objets possédant la propriété `replaceBy`
    - `replaceBy` : nom de l'instance par laquelle remplacer cet objet (depuis un objet `instanceSource` contenu dans ce fichier, ou depuis la biblio objets)
- **matériaux**
    - `material` : nom du matériau à appliquer sur cet objet. Si vide, l'objet gardera son matériau, sinon il sera remplacé.

# Vertex Colors

![maxscript-vertex-colors](images/maxscript-vertex-colors.png)

Pour que les matériaux apparaissent bien dans le viewer, il est nécessaire que les `vertex colors` soient blanches. Ce script permet de sélectionner tous les objets et de faire le changement en blanc.
**Ca ne fonctionne pas sur les objets autres que `Edit Poly` et `Edit Mesh`, il faudra convertir les objets `Box`, `Plane`, etc. (en poly de préférence).

[Outil téléchargeable ICI](maxscripts/TRIBIA_SetVertexColorsToWhite.ms)
