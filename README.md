## Upssitech_3A_ID




- Malheureusement la formule gratuite du broker MQTT sur Shiftr.io permet de maintenir un broker actif pour seulement 6h. Ainsi si vous voulez lancer l’application il faut aller renseigner dans le code les informations  d’un nouveau broker lancé préalablement.

- Une fois cela fait, il faut lancer:
  - Capteurs_virtuels.pde
  - TraitementHumi.pde
  - TraitementTemp.pde

- De plus il faut aller renseigner les informations de WIFI dans le code de l’ESP32 pour que celui-ci aille se connecter au réseau en plus d’enregistrer un nouveau broker MQTT, téléverser le code vers la carte et enfin brancher le capteur de température DHT11 sur le pin D4 et alimenter la carte via son port USB.

Le lancement de l’application étant un peu compliqué, je vous conseille d’aller voir la vidéo de démonstration disponible ici:
https://drive.google.com/file/d/1n_MUJGlSIuL71GSQf9KIAUYidzoLf_6i/view?usp=sharing

Le rapport est disponible [ici](https://github.com/ClementPagran/Upssitech_3A_ID/blob/master/Rapport%20Projet%20ID.pdf)
