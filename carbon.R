#Vider le contenu de la mйmoire
#rm(list=ls())

#Changement du repertoire courant
setwd("E:/projets/carbon_emmission")

#Charger les donnees
carbon<-read.csv(file = "data/archive.csv", header = T)

#Lister et verifier le contenu des donnees
head(carbon)
str(carbon)
summary(carbon)
