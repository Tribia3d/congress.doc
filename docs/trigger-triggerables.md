# Trigger & Triggerable

La version où cette fonctionnalité a été introduite dans l'outil maxscript est `1.0.28`.

## Principe
Un objet de type `trigger` va permettre (au moment du clic) de déclencher des animations sur un objet `triggerable` et sa hiérarchie.

Fonctionnalité introduite afin de faire tourner les plateaux sur hall Studio TV.

## Modélisation
- L'objet "contrôlé" doit posséder le type `triggerable`
    - Le champ `triggerableId` doit être renseigné (avec un uuid ou n'importe quelle chaine de caractère unique)
    - Les animations des enfants de cet objet doivent être présentes dans la fenêtre `Babylon Animation Groups` et avoir l'objet parent comme racine
- L'objet déclenchera les animations avec un clic doit être du type `trigger`
    - Le champ `triggerId` doit être renseigné (la liste déroulante est préremplie avec les `triggerableId` déjà spécifiés sur d'autres objets) avec celui de l'objet à contrôler

Dans le cas du Studio TV, la plane invisible devant le pupitre a un type `trigger` et un champ `triggerId="plateau_tv"`. Et tous les *Points* (de préférence ne pas utiliser de *Dummy*) parents des plateaux sont rattachés à un unique *Point* parent qui lui possède le type `triggerable` et un champ `triggerableId="plateau_tv"`.

## Configuration
Cela se passe dans la partie `triggerables` du fichier de config `JSON`.

```json
...
 "triggerables": [
    {
        "uuid":  "plateau_tv",
        "states":  [
            {"name": "fond vert", "animationNames":  ["apparition_fd_vert","disparition_nature"], "default":  true},
            {"name": "haussmannien", "animationNames":  ["apparition_haussmann","disparition_fd_vert"]},
            {"name": "nature", "animationNames":  ["apparition_nature","disparition_haussmann"]},
        ]
    },
    {...}
  ],
...
``` 
> Exemple de contenu du fichier de config.json

- `uuid`: chaine de caractère à indiquer dans `triggerId` et `triggerableId`
- `states`: contient tous les états du composant, qui tournerons en boucle avec les clics successifs sur l'objet de contrôle du type `trigger`
    - `name`: nom de l'état *pas utilisé pour l'instant*
    - `animationNames`: tableau contenant les noms des animations (déclarés dans `Babylon Animation Groups`) à lire en simultané lors du passage à l'état en question
    - `default`: spécifier `true` pour l'état par défaut
