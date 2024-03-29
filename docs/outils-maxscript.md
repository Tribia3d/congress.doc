# Outils Maxscript
Pour faciliter le réglage des propriétés des objets, il y a des petits scripts qui permettent de définir les paramètres sans trop se préoccuper de la forme du code requis.

## Outil Congress
- 1.0.32: [maxscript-webgl-properties-congress-1.0.32.zip](maxscripts/maxscript-webgl-properties-congress-1.0.32.zip)
    - ajout du type `booth_product`
    - ajout de la prop `boothProductKey3d`
    - suppression de la prop `productKey3d`
- 1.0.31: [maxscript-webgl-properties-congress-1.0.31.zip](maxscripts/maxscript-webgl-properties-congress-1.0.31.zip)
    - ajout de la prop `focusOnClick`
- 1.0.30: [maxscript-webgl-properties-congress-1.0.30.zip](maxscripts/maxscript-webgl-properties-congress-1.0.30.zip)
    - ajout du type `video_texture`
    - ajout de la prop `videoTextureId`
- 1.0.29: [maxscript-webgl-properties-congress-1.0.29.zip](maxscripts/maxscript-webgl-properties-congress-1.0.29.zip)
    - ajout du type `product_customizable_element`
    - suppression de la prop `productCustomizableElement` remplacée par (voir ligne suivante)
    - ajout des props `productCustomizableColor` et `productCustomizableMap`
- 1.0.28: [maxscript-webgl-properties-congress-1.0.28.zip](maxscripts/maxscript-webgl-properties-congress-1.0.28.zip)
    - ajout des types `trigger` et `triggerable` ainsi que la propriété `triggerableId`
- 1.0.27: [maxscript-webgl-properties-congress-1.0.27.zip](maxscripts/maxscript-webgl-properties-congress-1.0.27.zip) 
- 1.0.26
    - ajout du type `product_customizable` et des props `productCustomizableId` et `productCustomizableElement`

![gltf_properties_congress](images/gltf_properties_congress.jpg)

## **--ANCIEN--** Propriétés des objets (v0.5.09)

[***ANCIEN*** Outil téléchargeable ICI](maxscripts/TRIBIA_CongressUserProperties.ms) (dernière mise à jour 0.5.09 le 06/09/2021)

```warning
**Nécessite Python v2 !** Actuellement c'est Python v3 qui est utilisé par défaut avec 3ds Max 2021+. Il faut ajouter une variable d'environnement pour forcer l'utilisation de la v2 :

- Rechercher `path` dans le **menu démarrer** et ouvrir `Modifier les variables d'environnement système`
- En bas cliquer sur `Variables d'environnement...` puis sur `Nouvelle`
- Mettre `ADSK_3DSMAX_PYTHON_VERSION` comme nom et `2` comme valeur puis `OK` successivement sur toutes les fenêtres précédentes
- Redémarrer Max et exécuter le script, il ne doit pas y avoir d'erreur et apparaître dans la liste des outils de `Customize User Interface` dans la catégorie `TRIBIA`

![maxscript-description](images/force-python-v2.png)
```

![maxscript-description](images/maxscript-description.png)
> (Capture d'une vieille version)

- **type** :
    - `billboard` : (= silhouettes)
    - `booth` : défini cet objet comme un Stand. Il faudra également remplir `id` pour spécifier de quel stand il s'agit (et éventuellement `booth_model` si on veut instancier un modèle de stand sur le dummy).
    - `booth_camera` : défini cette caméra comme caméra de stand. **Nécessaire pour pouvoir entrer sur le stand !**
    - `booth_model` : défini cet objet comme modèle de stand. Il faudra spécifier un nom dans `boothModel` plus bas.
    - `camera` : défini cette caméra comme caméra de zone. **Nécessaire pour le bon chargement de la zone !**
    - `camera_position` : défini cette caméra comme cible pour un déplacement direct dans la zone. Il faudra également remplir `id` pour spécifier de quel caméra il s'agit
    - `conference` : 
    - `elevator` : 
    - `elevator_camera` : 
    - `goto_booth` : deplace la caméra sur un stand (= signalétique à l'entrée des zones)
    - `goto_position` : défini cet objet comme cliquable pour se déplacer vers la caméra définie dans `CameraPositionId`
    - `goto_zone` : défini cet objet comme cliquable pour charger la zone définie dans `gotoZoneId`
    - `ground` : défini cet objet comme sol cliquable pour les déplacement dans la zone. **Nécessaire si on veut pouvoir se déplacer dans la zone**
    - `lab` : défini cet objet comme étant un lab
    - `lightmap` : nom de la lightmap contenue dans le matériau de cet objet. L'objet ne sera pas affiché et la lightmap sera copiée sur les matériaux des objets possédant la propriété `useLightmap` avec la même nom
    - `envmap` : idem que `lightmap` mais pour les map de réflexion. Utiliser `useEnvmap` sur les objets pour appliquer la map sur son matériau.
    - `product` : défini l'objet comme un produit, il faudra spécifier `media_type` et `key_3d`
    - `product_animated` : WIP
    - `product_standalone` : permet de deplacer la camera face à l'axe -y de l'objet (= thèses novaq)
    - `video_texture` : va lire la vidéo dont l'url est spécifié dans `config.json` correspondante à `videoTextureId`
    
- **booth & goto_zone & goto_position & lab**
    - `id` : uuid du stand (ex `5efb49ef2bac05001bf10e54`) ou uuid de la zone à charger (ex `6795ec46-b54b-46fb-9059-003a5cadca5b` pour l'accueil), ou id caméra (`camera_position`), ou uuid lab
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
- **divers**
    - `booth_tooltip` : ouvrira le tooltip du stand au clic sur celui-ci
    - `no_title` : Ce produit n'aura pas de titre (uniquement innovation)
    - `do_not_scale` : utilisé pour les produits, cet objet (et ses enfants) ne sera pas mis à l'échelle en fonction du format de la texture (utilisé pour le support du pdf de stand)
    - `booth_contact` : au clic sur cet objet, le layer `contact` de kinoba sera ouvert (utilisé sur le calendrier et l'ipad)
    - `limit_distance` : Cet objet sera interactif que lorsque la camera sera à une certaine distance de celui-ci
    - `goto_pos` : L'objet cliqué positionnera la camera sur la caméra avec le `cameraPositionId` spécifié (utilisé lorsqu'un objet possède déjà un type **autre que** type=goto_position)`
    - `focusOnClick` : Déplace la caméra active devant l'objet (idem type product_standalone mais peut etre appliqué à un objet ayant déjà un type défini)
    - `booth_information` : Affichera l'overlay informations du stand (appel kinoba)
    - `no_marker` : Si true, la puce de l'objet ne sera pas afficée (par ex pour un produit ou un stand)
    - `collectable` : indique si l'objet est un collectable de la chasse au trésor
    - `collectableId` : identifiant de l'objet chasse au tresor
    - `highlight_object` : affiche un contour lorsque la souris passe sur l'objet
    - `visibleFrom` : l'objet est invisible avant cette date (format timestamp)
    - `visibleUntil` : l'objet est invisible après cette date (format timestamp)
    - `` : 
    - `` : 
    - `` : 
    - ...

## Vertex Colors

![maxscript-vertex-colors](images/maxscript-vertex-colors.png)

Pour que les matériaux apparaissent bien dans le viewer, il est nécessaire que les `vertex colors` soient blanches. Ce script permet de faire le changement en blanc sur tous les objets sélectionnés.
**Ca ne fonctionne pas sur les objets autres que `Edit Poly` et `Edit Mesh`, il faudra convertir les objets `Box`, `Plane`, etc. (en poly de préférence).

[Outil téléchargeable ICI](maxscripts/TRIBIA_SetVertexColorsToWhite.ms)

## Récupération UUIDs depuis fichier max (v0.1)

Permet de récupérer les UUIDs déjà spécifiés pour les stands d'une zone. Le script va sortir toute la liste des UUIDs présents dans les propriétés de tous les objets de la scène max.

![maxscript-get-uuids](images/maxscript-get-uuids.png)

```warning
Comme le champ `uuid` est également utilisé pour indiquer l'id de la zone vers laquelle se diriger dans le cas d'un objet `type=goto_zone`. Penser à vérifier la validité des uuids (les stands ne possèdent pas de tiret `-`)
```

[Outil téléchargeable ICI](maxscripts/TRIBIA_GetBoothUUIDs.ms)

## Copie-Colle Transform objet

Permet de copier la `position`, `rotation` et `scale` d'un objet d'une scène / fenêtre max dans le presse papier. Puis de les appliquer sur un autre objet dans une scène / fenêtre max différente (ou dans la même scène).

![maxscript-copy-paste-transform](images/maxscript-copy-paste-transform.PNG)

[Outil téléchargeable ICI](maxscripts/TRIBIA_CopyPasteTransformSOLO.ms)

## Trouver les objets ayant un matériau CoronaMtl
Copier-coller cette ligne dans le listener de max, ça va sélectionner tous les objets ayant un CoronaMtl appliqué.
```
select (for o in objects where (o.material != undefined and classof o.material == CoronaMtl) collect o)
```
> TODO: améliorer pour détecter les CoronaMtl derrière un Multimaterial également...