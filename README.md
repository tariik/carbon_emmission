# carbon_emmission
un modèle pour prédire l’augmentation du taux de CO2 dans l’atmosphère

### Descriptif des données
Cet ensemble des données comprend les observations mensuelles des concentrations atmosphériques de dioxyde de carbone provenant de l'observatoire de Mauna Loa (Hawaii) à une latitude de 19,5, une longitude de -155,6 et une élévation de 3397 mètres.

##### Colonnes 1-3: 
  indique la date dans les formats redondants suivants: année, mois et date décimale

##### Colonne 4: 
  concentration mensuelle de CO2 en parties par million (ppm) mesurée sur l'échelle d'étalonnage 08A et collecté à minuit le 15 de chaque   mois.

##### Colonne 5: 
  fournit les mêmes données après un ajustement saisonnier, ce qui implique de soustraire des données un ajustement à 4 harmoniques avec      un facteur de gain linéaire pour supprimer le cycle saisonnier des mesures de dioxyde de carbone

##### Colonne 6: 
  fournit les données avec le bruit supprimé, généré à partir d'une fonction (spline) cubique rigide plus des fonctions 4-harmonique avec   gain linéaire

##### Colonne 7: 
  correspond aux mêmes données avec le cycle saisonnier supprimé.
