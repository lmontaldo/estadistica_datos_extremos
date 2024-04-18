rm(list = ls())
source("../extremales/Entrega_mayo/utils/libraries.R")
source("../extremales/Entrega_mayo/utils/dpg.R")
data=read.csv("../extremales/data/data_LAB_POT.csv")
#install.packages("POT")
library(POT)
library(VGAM)
cat("--------------------------------------------------")
cat("Distribucion de Pareto Generalizada (DPG)", '\n')
cat("--------------------------------------------------")
#
xaux <- seq(0, 10, length = 10000)
xi <- 0.2
sigma <- 1
mu <- 0
#
Fx <- dgp_distribution(xaux, xi, sigma, mu)
# Plot the distribution with improved appearance

plot(xaux, Fx, col = "yellow", type = "l", lwd = 2, ylim = c(0, 1), 
     xlab = "x", ylab = "F(x)", main = "Distribucion de Pareto Generalizada (DPG)", 
     sub = "Parameters: xi = 0.2, sigma = 1, mu = 0")


dev.off()
# Number of random combinations
num_combinations <- 3
# Set up the plotting layout
par(mfrow = c(1, num_combinations))

# Loop to generate random combinations and plot each distribution as a subplot
for (i in 1:num_combinations) {
  # Generate random values for mu, sigma, and xi within specified ranges
  mu <- runif(1, min = -0.1, max = 0.3)  # Adjust the range as needed
  sigma <- runif(1, min = 0, max = 0.5)   # Adjust the range as needed
  xi <- runif(1, min = -5, max = 5)     # Adjust the range as needed
  
  # Calculate Fx for the current combination
  Fx <- dgp_distribution(xaux, xi, sigma, mu)
  
  # Plot the distribution for the current combination
  plot(xaux, Fx, col = "yellow", type = "l", lwd = 2, ylim = c(0, 1), 
       xlab = "x", ylab = "F(x)", main = paste("Distribution Function (Combination", i, ")"), 
       sub = paste("Parameters: xi =", round(xi, 2), ", sigma =", round(sigma, 2), 
                   ", mu =", round(mu, 2)))
}
#
dev.off()
plot(xaux, pgpd(xaux, location=0, scale=1, shape=0.1),type="l", col="blue", ylim=c(0,1), ylab="F(x)", xlab="x", main= "Distribución de Pareto Generalizada")
lines(xaux, pgpd(xaux, location=0, scale=1, shape=0),col="green")
legend("bottomright", legend=c("xi=0 - Exponencial", "xi=0.1", "xi=2- pareto"), bty="n", col=c("green","blue","red"), lty=1)



# funcion a mano
xi=2
sigma=1
mu=0
points(xaux, 1- (1+ (xi*(xaux-mu)/sigma))^(-1/xi),col="yellow")
# función del VGAM
lines(xaux, pgpd(xaux, location=0, scale=1, shape=2),col="red")
#

# Densidad (prestar atención a la diferencia con exponencial en las colas)
plot(xaux, dgpd(xaux, location=0, scale=1, shape=2),type="l", col="red", log="", ylim=c(1e-5,1), ylab="f(x)", xlab="x")
lines(xaux, dexp(xaux),col="green")
lines(xaux, dgpd(xaux, location=0, scale=1, shape=0.1),col="blue")
legend("topright", legend=c("xi=0 - Exponencial", "xi=0.1", "xi=2- pareto"), bty="n", col=c("green","blue","red"), lty=1)
#
# pongamos el eje Y en escala logaritmica para apreciar mejor el comportamiento en las colas
plot(xaux, dgpd(xaux, location=0, scale=1, shape=2),type="l", col="red", log="y", ylim=c(1e-5,1), ylab="f(x)", xlab="x")
lines(xaux, dexp(xaux),col="green")
lines(xaux, dgpd(xaux, location=0, scale=1, shape=0.1),col="blue")
legend("topright", legend=c("xi=0 - Exponencial", "xi=0.1", "xi=2- pareto"), bty="n", col=c("green","blue","red"), lty=1)
#
# Densidad (prestar atención a la diferencia con exponencial en las colas)
xaux<-seq(0, 20, length=1000)
plot(xaux, dgpd(xaux, location=0, scale=6, shape=0),type="l", col="green", ylab="f(x)", xlab="x")
lines(xaux, dgpd(xaux, location=0, scale=6, shape=-1),col="orange")
lines(xaux, dgpd(xaux, location=0, scale=6, shape=2),col="red")
legend("topright", legend=c("xi=0 - Exponencial", "xi=-1 Uniforme", "xi=2- Pareto"), bty="n", col=c("green","orange","red"), lty=1)
#
set.seed(71)
rgpd(20,location=0, scale=1, shape=2) #genero 70 números aleatorios de una variable X con DPG con esos parámetros
#
set.seed(233)
plot(rgpd(20,location=0, scale=1, shape=2)) # notese la gran volatilidad pues el parámetro de forma es alto (xi=2)
points(rgpd(20,location=0, scale=1, shape=0.2), col="green")
dev.off()

##################### 
# POT
#####################

cat("Ejemplos aplicación de POT", "\n")
set.seed(54)
n=1500
Obs<- rlnorm(n, 4,1) # muestra de entrenamiento. en mis datos lo debo partir
plot(Obs,type="l")
#
# Paso 1
umbral<-400

exceso<-which(Obs > umbral) # selecciono los valores que son mayores que el umbral definido

# Paso 2
p<- 1 - (length(exceso) / length(Obs)) # Probabilidad de quedar bajo el umbral p=F(u)
p
# Paso 3
y<- Obs[exceso] - umbral # Esto es lo que llamamos "evento"
y
# Paso 5
#Separamos la muestra para el test de ajuste
d= 15 # Numero de datos para muestra A (entrenamiento)

selA<- sample(1:length(y), size=d, replace=FALSE)

yA<-y[selA] # Muestra entrenamiento
yB<-y[-selA] # muestra prueba

# Ajusto un modelo de pareto generalizado
GP <- fitgpd(yA, 0) # Umbral=0, por defecto por Maxima verosimilitud

k<-GP$fitted.values["shape"]
sigma<-GP$fitted.values["scale"]

print(k)
print(sigma)
#
#Probability Weighted Moments- Estimacion por el metodo de los momentos
pwu <- fitgpd(y, 0, "pwmu")
#str(pwu)
sigmaMom<-pwu$fitted.values[1] # scale
kMom<-pwu$fitted.values[2]  # Shape

hist(yA, prob=T)
lines(seq(0,1700, length=100),dgpd(seq(0,1700, length=100), 0, sigma,k))
lines(seq(0,1700, length=100),dgpd(seq(0,1700, length=100), 0, sigmaMom,kMom),col="red")

# Test en la muestra no usada para ajustar la GP (muestra B)
#ks.test(rnorm(1000, 0,1), "pnorm", 0,1) # P>0.05 misma distribucion
#ks.test(rnorm(1000, 0,1), rnorm(100,10,1)) # P>0.05 misma distribucion
ks.test(yB ,"pgpd",scale=sigma,shape=k) # ver la ayuda de ?pgpd

ks.test(yB ,"pgpd",scale=sigmaMom,shape=kMom) # ver la ayuda de ?pgpd

# Paso 6
# Ajusto GP con toda la data
GPtot <- fitgpd(y, 0) # Umbral=0, por defecto por Maxima verosimilitud
ktot<-GPtot$fitted.values["shape"]
sigmatot<-GPtot$fitted.values["scale"]
sigmatot
ktot
#
GPtotMom <- fitgpd(y, 0, "pwmu") # Umbral=0, por defecto por Maxima verosimilitud
GPtotMom$fitted.values[1] # scale
GPtotMom$fitted.values[2] # shape
# Con el modelo ajustado podemos pasar a analizar la distribución de los excesos.
# Paso 7 
# estimar la probabilidad de X<=t (F(t)), dado que t>umbral.
# F(X<=t)= p + (1-p) PGE(t-u)
t= 500  
# Probabilidad de no exceder un valor mayor a t (t>u)
p + (1-p)* pgpd(t-umbral, 0, unname(sigmatot),unname(ktot))
# Probabilidad de exceder t (el complemento)
1 - p + (1-p)* pgpd(t-umbral, 0, unname(sigmatot),unname(ktot))
#Compare con el valor calculado de forma empírica
1- sum(Obs<t)/length(Obs)
# Datos débilmente dependientes
set.seed(54)
yt <- arima.sim(list(order=c(1,0,0), ar=.2), n=5000)
plot(yt)
#
umbral=1.5
exceso<-which(yt > umbral) # selecciono los valores que son mayores que el umbral definido
p<- 1 - (length(exceso) / length(yt)) # Probabilidad de quedar bajo el umbral p=F(u)
p
#
y<- yt[exceso] - umbral # Esto es lo que llamamos "evento"
#y
hist(y)
#i Separamos la muestra para el test de ajuste
d= 50 # Numero de datos para muestra A (entrenamiento)
selA<- 1:d
yA<-y[selA] # Muestra entrenamiento
yB<-y[-selA] # muestra prueba
# ii- ajusto a la muestra A por método de los momentos
pwuA <- fitgpd(yA, 0, "pwmu")
sigmaMomA<-pwuA$fitted.values[1] # scale
kMomA<-pwuA$fitted.values[2]  # Shape
sigmaMomA
#
kMomA
# iii
#r=2
k=15
# Separamos en 15 grupos 
yBsplit<-split(yB, 0:length(yB) %/% k)
ks.test(yBsplit[[1]] ,"pgpd",scale=sigmaMomA,shape=kMomA)$statistic
#
Tes<-unlist(lapply(yBsplit, function(X) ks.test(X ,"pgpd",scale=sigmaMomA,shape=kMomA)$statistic) )
T<-Tes[1]
T_otros<- Tes[-1]
hist(T_otros)
abline(v=T)
sum(T>T_otros)/length(T_otros)
# En resumen, no puedo rechazar H0
# y por lo tanto es correcto utilizar una DPG en este caso. Luego debo ajustar el modelo a toda la data.
pwuTot <- fitgpd(y, 0, "pwmu")
sigmaMomTot<-pwuTot$fitted.values[1] # scale
kMomTot<-pwuTot$fitted.values[2]  # Shape
sigmaMomTot
#
kMomTot
#
hist(y, prob=T)
lines(seq(0,1700, length=100),dgpd(seq(0,1700, length=100), 0, sigmaMomTot,kMomTot))
cat("--------------------------------------------------")
cat("Procesos estacionarios debilmente dependientes","\n")
cat("--------------------------------------------------")
library(TSA)
library(tseries)
# Procesos de Media Móvil (MA)
set.seed(101)
MA2=arima.sim(model = list(order = c(0, 0, 2), ma=c(1.2,1.2)),n = 500) 
#Al establecer q=2, generamos un proceso MA(2). El valor de los parámetro ma corresponden a los valores que toma el paráemtro ?? mencionado más arriba. Como es un ma de órden 2 debemos especificar 2 valores. Pueden juagar modificando esos valores.
#Graficamos 
plot.ts(MA2,col=50)
runs.test(as.factor(MA2>median(MA2))) #esta función requiere factorizar a la variable, generamos dos categorías, una que considere a los valores por encima de la mediana y otra por debajo. 
MA2q90=quantile(MA2,0.90)
MA2q90 
#
excesoMA2<-which(MA2 > MA2q90)
excesoMA2 
#
MA2e=MA2[excesoMA2]
runs.test(as.factor(MA2e>median(MA2e)))
# Procesos de Autorregresión (AR)
set.seed(101)
AR1=arima.sim(model = list(order = c(1, 0, 0), ar=0.70),n = 500)  
#Al establecer p=1, generamos un proceso AR(1). El valor del parámetro ar corresponde al paráemtro Ø. Pueden juagar modificando ese valor.
#Graficamos
plot.ts(AR1,col=22) 
runs.test(as.factor(AR1>median(AR1)))
acf(AR1) #el gráfico de autocorrelación nos permite ver como se autocorrelaciona la serie considerando diferentes "lags". Observamos correlaciones significativas a lags bajos.
#
AR1q90=quantile(AR1,0.90)
AR1q90 
#
excesoAR1<-which(AR1 > AR1q90)
excesoAR1
#
AR1e=AR1[excesoAR1]
runs.test(as.factor(AR1e>median(AR1e)))
# Probemos a subir un poco el umbral
AR1q95=quantile(AR1,0.95)
AR1q95 
excesoAR1_2<-which(AR1 > AR1q95)
excesoAR1_2
# Evaluemos la aleatoriedad sobre los excesos considerando como umbral al q95
AR1e_2=AR1[excesoAR1_2]
runs.test(as.factor(AR1e_2>median(AR1e_2)))
# Datos reales
summary(data)
#
cf<-log(data$cf) + runif(nrow(data), 0.1,0.2) # agrego uniforme pequeña para evitar empates (no modifica el resultado)
umbral<- log(2000)
exceso<-which(cf> umbral) # selecciono los valores que son mayores que el umbral definido
p<- 1 - (length(exceso) / length(cf)) # Probabilidad de quedar bajo el umbral p=F(u)
p
#
y<- cf[exceso] - umbral # Esto es lo que llamamos "evento"
y
#
hist(y)
#i Separamos la muestra para el test de ajuste
d= 50 # Numero de datos para muestra A (entrenamiento)
selA<- 1:d
yA<-y[selA] # Muestra entrenamiento
yB<-y[-selA] # muestra prueba
# ii- ajusto a la muestra A por método de los momentos
pwuA <- fitgpd(yA, 0, "pwmu")
sigmaMomA<-pwuA$fitted.values[1] # scale
kMomA<-pwuA$fitted.values[2]  # Shape
sigmaMomA
kMomA
# iii
#r=2
k=7
# Separamos en k grupos 
yBsplit<-split(yB, 0:length(yB) %/% k)
ks.test(yBsplit[[1]] ,"pgpd",scale=sigmaMomA,shape=kMomA)$statistic
Tes<-unlist(lapply(yBsplit, function(X) ks.test(X ,"pgpd",scale=sigmaMomA,shape=kMomA)$statistic) )
T<-Tes[1]
T_otros<- Tes[-1]
hist(T_otros)
abline(v=T)
sum(T>T_otros)/length(T_otros)
# Ajusto a toda la serie
DPGDatos <- fitgpd(y, 0, "pwmu")



