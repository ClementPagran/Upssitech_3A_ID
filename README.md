## Upssitech_3A_ID




- Malheureusement la formule gratuite du broker MQTT sur Shiftr.io permet de maintenir un broker actif pour seulement 6h. Ainsi si vous voulez lancer l’application il faut aller renseigner dans le code les informations  d’un nouveau broker lancé préalablement.

- Une fois cela fait, il faut lancer:
  - Capteurs_virtuels.pde
	- TraitementHumi.pde
	- TraitementTemp.pde

- De plus il faut aller renseigner les informations de WIFI dans le code de l’ESP32 pour que celui-ci aille se connecter au réseau en plus d’enregistrer un nouveau broker MQTT et enfin brancher le capteur de température SHT11 sur le pin D4 l’alimenter via son port USB

Le lancement de l’application étant un peu compliqué, je vous conseille d’aller voir la vidéo de démonstration disponible ici:
https://drive.google.com/file/d/1n_MUJGlSIuL71GSQf9KIAUYidzoLf_6i/view?usp=sharing
