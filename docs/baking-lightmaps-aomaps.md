# Baking Lightmaps & AOmaps

On va utiliser Flatiron pour déplier les UV2 et baker les maps.

Etapes :
- Préparation des objets
- Dépliage UV2
- Choix des maps à baker
- Baking
- Retouche
- Utilisation au sein du projet

## Préparation des objets
Comme Corona ne propose pas de passe lightmap de base, il va falloir tricher un peu. On va appliquer un `Material Override` (`Render Settings (F10) => Scene => Render Overrides`) avec un **matériau mat presque blanc** (220 dans mon cas pour que ça ne crame pas trop).

![flatiron-mtl-ovr](images/flatiron-mtl-ovr.png)

Si il y a des objets **lumineux** ou **transparents**, il faut les **exclure de l'override** pour garder leur impact sur la lightmap, éclairage si lumineux et ombres atténuées si transparent. Pour ça il faut sélectionner les objets à exclure et cliquer sur le `+` pour les ajouter à la liste.

**Régler l'éclairage de la scène** à l'aide du rendu interactif de Corona. S'assurer qu'il n'y a pas d'ombres trop marquées qui dépassent du sol du Stand, autrement ça va faire bizarre puisque ces ombres ne seront pas visibles sur le sol de la Zone qui possèdera une lightmap différente.

Pour les objets `produits`, on ne va pas les inclure du tout dans la lightmap, voir ci-dessous

## Dépliage UV2
Pour accéder à l'interface de Flatiron, aller dans l'onglet `Utilities`. S'il n'apparaît pas, cliquer sur `More` et le chercher dans la liste.

Sélectionner les objets à inclure dans la lightmap (on ne sélectionnera pas les `produits`).

Paramètres à utiliser pour le dépliage :
- Type de dépliage : `hard surface`
- `Target Channel` (canal UV) : 2
- `Gutter Padding` (espace entre les ilots) : 8
- `Texture Width & Height` : pas très important on règlera ça au moment du choix des maps à baker
- `Unwrap Group Name` : nom qui sera utilisé plus tard pour choisir quel groupe baker. Sera utilisé automatiquement pour les noms de fichiers générés (ex. `booth_a_Corona_Beauty.png`)


![flatiron-depliage-uv2](images/flatiron-depliage-uv2.png)

Une fois cliqué sur `Unwrap`, un aperçu du dépliage sera affiché si `Show Unwrap Preview` est coché.

## Choix et réglage des maps
Réglages dans le rollout `Baking` :
- `Baked Map Path` : **ça ne fonctionne pas !** Il faut régler le chemin d'enregistrement des maps dans la fenêtre `Render To Texture (touche 0)` de Max...
- `Overlap` : 4 (la moitié de `Gutter Padding`)


On va utiliser la passe `Corona`

![flatiron-bake-elements](images/flatiron-bake-elements.png)