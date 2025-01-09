
# Tous au sport !

'Tous au sport !' est un projet développé par moi, Kilian Juhel, dans le cadre d'un hackathon du lundi 06/01/2025 au dimanche 09/01/2025
Il a été réalisé seul dans le cadre du BTS SIO de chevrollier.
Aucun code initial a été fourni.
## Deployment

Ce projet a été réalisé en Flutter et utilse les librairies suivantes :
- latlong2: ^0.9.1
- flutter_map: ^7.0.2
- geolocator: ^13.0.2
- http: ^1.2.2

Pour l'installer, vous pouvez télécharger le projet en ZIP depuis
[github][https://github.com/JuhelKilian/hackathonN4-2025.git]:

Ou le cloner depuis :
[github][git@github.com:JuhelKilian/hackathonN4-2025.git]

En utilisant
```bash
  git clone git@github.com:JuhelKilian/hackathonN4-2025.git
```

Une fois téléchargé, vous pouvez installer les dépendances en rentrant :

```bash
  flutter pub get
```

Et si cela ne fonctionne pas :
```bash
  flutter pub upgrade
  flutter pub get
```


## Choix techniques

### La plateforme

Ce projet a été réalisé dans le but d'afficher les activités proches de chez sois et les parkings à proximité. Il me parait donc cohérent de faire une application mobile pour répondre au mieu à ce besoin de mobilité (vélo).


### La localisation

Ce projet permet d'afficher sa localisation, et donc de voir les activités et parkings à coté de chez sois.

La localisation est facultative, si l'utilisateur choisit de l'aciver, alors un marqueur apparaitra à la position de celui-ci. Un message indiquera également qu'elle a été affichée.

Si elle n'est pas rentrée, un message l'indiquera puis disparaitra ensuite.


### Les markeurs

Suite à des problèmes avec l'API, qui avait bloqué notre groupe car nous avions envoyé trop de requetes, j'ai limité l'application a recevoir 100 localisations d'activités et de parkings.

Les marqueurs rouges indiquent les parkings à vélo et les marqueurs marrons indiquent les activités.

Une légende le rappelle en haut à gauche de l'écran.


## Base de données

Ce projet n'utilise pas de base de données, car il utilise directement les API de Open Data Angers, accessibles depuis les liens suivants :

[Installation sportive Angers]
[https://angersloiremetropole.opendatasoft.com/explore/dataset/equipements-sportifs-angers/information/]

[Parking à vélo sur Angers]
[https://angersloiremetropole.opendatasoft.com/explore/dataset/parking-velo-angers/information/]