#Vider le contenu de la mйmoire
#rm(list=ls())

#Changement du repertoire
#setwd("E:/projets/carbon_emmission")
setwd("C:/Users/admin/Desktop/projets/R/carbon_emmission/data")

#Charger les donnees
carbon<-read.csv(file = "archive.csv", header = T)
#carbon<-read.csv(file.choose())

#Lister et verifier le contenu des donnees
head(carbon)
#renommer les col
colnames(carbon)<-c('year',
                    'month',
                    'decimal_date',
                    'carbon_dioxide_ppm',
                    'carbon_dioxide_ppm_season_adj',
                    'carbon_dioxide_ppm_fit',
                    'carbon_dioxide_ppm_season_adj_fit')

# virefier les types des col
str(carbon)

#Convertir le type de l'attribut YEAR du NUM  a DATE
library(lubridate)
carbon[ , "date"] <- format(date_decimal(carbon$decimal_date), "%d-%m-%Y")
carbon$date <-as.Date(carbon$date, format="%d-%m-%Y")
carbon[ , c("year","month","date")]

# lister les données manquantes##
carbon[!complete.cases(carbon),]

## Summary##
summary(carbon)

##Plot tous les concentrations avec ggplot2##
library(ggplot2)
ggplot() +
    geom_line(data=carbon,aes(x=date,y=carbon_dioxide_ppm,color="carbon_dioxide"),alpha=.75) +
    geom_line(data=carbon,aes(x=date,y=carbon_dioxide_ppm_season_adj,color="carbon_dioxide_adjusted"),alpha=.75) +
    geom_line(data=carbon,aes(x=date,y=carbon_dioxide_ppm_fit,color="carbon_dioxide_fit"),alpha=.75) +
    geom_line(data=carbon,aes(x=date,y=carbon_dioxide_ppm_season_adj_fit,color="carbon_dioxide_adjusted_fit"),alpha=.75) +
    scale_colour_manual(name="data",
                        values=c(carbon_dioxide="#E2D200",
                        carbon_dioxide_adjusted="#46ACC8",
                        carbon_dioxide_fit="#E58601",
                        carbon_dioxide_adjusted_fit="#B40F20")) +
                        theme(legend.position="top") +
                        xlab('Date') +
                        ylab('concentrations de [PPM]')

#boite a moustaches de chaque mois
lesmois <- c("January","February","March","April","May","June","July","August","September","October","November","December")
carbon$MonthAbb <- lesmois[ carbon$month ]
carbon$ordered_month <- factor(carbon$MonthAbb, levels = month.name)
ggplot(data=carbon,aes(x=ordered_month,y=carbon_dioxide_ppm)) +
    geom_boxplot() +
    geom_jitter(shape=16, position=position_jitter(0.2)) +
    xlab('') + ylab('concentrations [ppm]') +
    theme(axis.text.x = element_text(angle=45, hjust=1))

#visualiser les concentrations de chaque mois par colour
library("RColorBrewer")
ggplot(data=carbon, aes(x=year,y=ordered_month)) +
                    geom_tile(aes(fill = carbon_dioxide_ppm),colour = "white") +
                    scale_fill_gradientn(colours=rev(brewer.pal(11,'Spectral'))) +
                    theme(axis.title.y=element_blank(),axis.title.x=element_blank(),legend.position="top")

##observation par mois
#obs=ts(carbon$carbon_dioxide_ppm,start=c(1958,1),frequency=12)
#obs

##Model (Série temporelle)
library("dplyr")
serie <- carbon %>% dplyr::select(year,month,carbon_dioxide_ppm)
serie_ts <- ts(serie$carbon_dioxide_ppm, start=c(1958,3),end=c(2016,02),frequency=12)

# Model ARIMA
library(forecast)
m_aa = auto.arima(serie_ts)

#prevision de 24 mois
f_aa = forecast(m_aa, h=24)
autoplot(f_aa, main = "Prevision du model ARIMA", ylab = "concentrations [ppm]")
#zoom sur les dernier mois
autoplot(f_aa, main = "Prevision du model ARIMA", ylab = "concentrations [ppm]",xlim = c(2014,2021), ylim = c(395, 415))

#prevision de 12 ans
f_aa2 = forecast(m_aa, h=360)
autoplot(f_aa2, main = "Prevision du model ARIMA", ylab = "concentrations [ppm]")
