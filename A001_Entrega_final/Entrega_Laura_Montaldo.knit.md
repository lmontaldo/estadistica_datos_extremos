---
title: "Entrega: curso de datos extremales"
author: "Laura Montaldo, CI: 3.512.962-7"
date: "2024-03-11"
bibliography: references.bib  # Add this line
nocite: '@*'
output:
  pdf_document:
    latex_engine: xelatex
    keep_tex: true
    includes:
      in_header: header2.tex
documentclass: article
classoption: oneside
lang: es
header-includes:
  - \usepackage{amsthm}
---

\newtheorem{theorem}{Teorema}[section]









\newpage

<!-- titulo-->

\thispagestyle{empty}

\maketitle

\newpage

<!-- indice -->

\tableofcontents

\newpage

<!-- abstract -->

# Resumen

Your abstract goes here.

\newpage




This is chapter 1.


```r
1
```

```
## [1] 1
```






















<!-- MOTIVACION Y OBJETIVO DEL ESTUDIO -->


\section{Motivación y objetivo del estudio} 

<!-- introduccion a eventos raros -->

Siguiendo a @notas_curso, se dice que tenemos datos extremos cuando cada dato corresponde al máximo o mínimo de varios registros. Son un caso particular de evento raro o gran desviación respecto a la media. Entonces, en una gran variedad de dominios disciplinares suele ser de gran interés el trabajo con datos extremos, los que admiten diversos enfoques. La teoría más clásica de estadística de datos extremos se basa en los trabajos de Fréchet, Gumbel, Weibull, Fisher, Tippett, Gnedenko, entre otros. En este estudio, el foco va a estar puesto en esquemas que extienden a las distribuciones extremales clásicas.

<!-- indice -->

Los índices de $S\&P$ son una familia de índices de renta variable\footnote{En inglés se llaman equity indices} diseñados para medir el rendimiento del mercado de acciones en Estados Unidos que cotizan en bolsas estadounidenses. Ésta familia de índices está compuesta por una amplia variedad de índices basados en tamaño, sector y estilo. Los índices están ponderados por el criterio \textit{float-adjusted market capitalization} (FMC). Además, se disponen de índices ponderados de manera equitativa y con límite de capitalización de mercado, como es el caso del $S\&P\:500$. Este este sentido, el $S\&P 500$ entraría en el conjunto de índices ponderados por capitalización bursátil ajustada a la flotación (ver \href{http://www.overleaf.com}{\textcolor{blue}{$S\&P$ Dow Jones Indices}}). El mismo  mide el rendimiento del segmento de gran capitalización del mercado estadounidense. Es considerado como un indicador representativo del mercado de renta variable de los Estados Unidos, y está compuesto por 500 empresas constituyentes.
 
Se busca crear un indicador de una posible crisis bursátil. Como variable de referencia de toma la relación de precios al cierre de ayer sobre la de hoy 

\begin{equation}
Indicador_t=\frac{Precio_{t-1}}{Precio_t},\quad\text{para}\; t=1,...,T \label{eq:ind}
\end{equation}
\vspace{0.5cm}

Interpretación del Indicador:

\begin{itemize}
\item Si el $Indicador_t$    $\leq$ 1, el precio de cierre de hoy es mayor o igual que el de ayer, lo cual podría ser considerado una señal positiva.
\item Si el $Indicador_t$ > 1, el precio de cierre de hoy es menor que el de ayer, lo cual podría considerarse una señal de alerta.
\end{itemize}

\vspace{1cm}



\newpage

En las siguiente figuras se muestra la evolución histórica desde la fecha 03/01/1928 hasta 08/12/2023 del precio al cierre del día del indicar S&P 500.



![](Entrega_Laura_Montaldo_files/figure-latex/plot1-1.pdf)<!-- --> 

```
## [1] 24100     9
```


![](Entrega_Laura_Montaldo_files/figure-latex/unnamed-chunk-14-1.pdf)<!-- --> 




#### Concepto de series de tiempo estacionarias
Siguiendo a @enders, se dice que un proceso estocástico $z_{t}$ con media y varianza finitas es estacionario en covarianza para todo $t$ y $t-s$ cuando

\begin{align}
	\label{eq:2_7}
	E(z_{t})&=E(z_{t-s})=\mu\\
	\label{eq:2_8}
	var(z_t)&=var(z_{t-s})=\sigma^2_z\\
	\label{eq:2_9}
	cov(z_t,z_{t-s})&=cov(z_{t-j},z_{t-j-s})=\gamma_s
\end{align}
donde $\mu, \sigma^2_z, \gamma_s$ con constantes.

En~\eqref{eq:2_8}, cuando $s=0$ se va a tener que $\gamma_0$ es la varianza de $z_t$. Que una serie temporal sea estacionaria en covarianza implica que tanto la media como todas sus autocovarianzas\footnote{También se habla de proceso debilmente estacionario o estacionario de segundo orden.} no están afectadas por cambios en los orígenes temporales\footnote{En modelos multivariados, el término autocovarianza refiere a la covarianza entre $z_t$ y sus propios rezagos mientras que covarianza cruzada refiere a la covarianza entre series temporales}.

Dado que se está en un marco de ecuaciones en diferencias, se tienen que cumplir condiciones de estabilidad en el sistema y esto implica que las raíces características asociadas al sistema de interés caígan dentro del círculo unitario. Cuando una serie temporal no sea estacionaria, es posible que presente una evidente tendencia, medias y varianzas que no son constantes en el tiempo.


##### Pruebas ADF

Se testea para cada serie de datos

\begin{align*}
	&H_0)\; \gamma = 0\\
	&H_1)\; \gamma \neq 0   
\end{align*}

En este sentido, se consideran tres ecuaciones de regresión distintas para poner a prueba $H_0$,

\begin{align}
	\label{eq: modelo_c}
	\Delta z_t=&\gamma z_{t-1} + \sum_{i=2}^p \beta_i \Delta z_{t-i+1} + \varepsilon_t \\
	\label{eq: modelo_b}
	\Delta z_t=&a_0+\gamma z_{t-1} + \sum_{i=2}^p \beta_i \Delta z_{t-i+1} + \varepsilon_t \\
	\label{eq: modelo_a}
	\Delta z_t=&a_0+\gamma z_{t-1} + a_2 t+ \sum_{i=2}^p \beta_i \Delta z_{t-i+1} + \varepsilon_t
\end{align}

Existen tres estadísticos $\tau,\;\tau_{\mu},\;\tau_{\tau}$ para probar la hipótesis nula $H_0)\:\gamma=0$ en cada caso y además, se tienen otros tres $F-$estadísticos $\:\phi_1,\:\phi_2,\:\phi_3$ para hacer pruebas conjuntas sobre los coeficientes.  

Los estadísticos $\:\phi_1,\:\phi_2,\:\phi_3$ se construyen como pruebas $F$:

\begin{equation*}
	\phi_{i}=\frac{\left[SSR_{restringido}-SSR_{no\:restringido}\right]/r}{SSR_{no\:restringido}/(t-k)}    
\end{equation*}

donde SSR es la suma de los cuadrados de los residuos en los modelos restringidos y no restringidos, $r$ es la cantidad de restricciones, $T$ es la cantidad de observaciones,  $k$ es la cantidad de parámetros estimados en el modelo irrestricto, $i=1,2,3$. A su vez, $T-k$ van a ser los grados de libertad del modelos sin restricciones. Los valores de los coeficientes estimados se van a comparar con los valores críticos de tablas reportados por Dickey y Fuller(1981).
La hipótesis nula indica que el proceso de generación de los datos es la del modelo restringido contra la hipótesis alternativa de que los datos son generados por el modelo sin restringir. Cuando los valores de $\:\phi_1,\:\phi_2,\:\phi_3$ sean mayores a los valores críticos reportados por Dickey y Fuller(1981) se rechaza la hipótesis nula, cuando sean menores a los valores críticos entonces no se rechaza la hipótesis nula.



En el siguiente cuadro \ref{tab: modelos_adf} se consideran los tres modelos y cada una de las hipótesis a testear con sus respectivos estadísticos.
\begin{table}[h!]
	\centering
	\small % Smaller font size
	\setlength{\tabcolsep}{3pt} % Adjust column spacing
	\caption{Modelos del test ADF}
	\label{tab: modelos_adf}
	\begin{tabular}{|c|c|c|c|}
		\hline 
		& Modelo & $H_0)$ & Estadistíco de prueba \\
		\hline 
		\hline 
		c & $\Delta z_{t}=a_{0}+\gamma z_{t-1}+a_{2}t+\sum_{i=2}^{p}\beta_{i}\Delta z_{t-i+1}+\varepsilon_{t}$ & $\begin{array}{c}
			\gamma=0\\
			\gamma=a_{2}=0\\
			\gamma=a_{2}=a_{0}=0
		\end{array}$ & $\begin{array}{c}
			\tau_{\tau}\\
			\phi_{3}\\
			\phi_{2}
		\end{array}$ \\
		\hline 
		b & $\Delta z_{t}=a_{0}+\gamma z_{t-1}+\sum_{i=2}^{p}\beta_{i}\Delta z_{t-i+1}+\varepsilon_{t}$ & $\begin{array}{c}
			\gamma=0\\
			\gamma=a_{0}=0
		\end{array}$ & $\begin{array}{c}
			\tau_{\mu}\\
			\phi_{1}
		\end{array}$ \\
		\hline 
		a & $\Delta z_{t}=\gamma z_{t-1}+\sum_{i=2}^{p}\beta_{i}\Delta z_{t-i+1}+\varepsilon_{t}$ & $\gamma=0$ & $\tau$ \\
		\hline 
	\end{tabular}
\end{table}


Cuando no se conozca el proceso de generación de los datos, se sugiere realizar las pruebas de Dickey-Fuller Aumentado partiendo del modelo
menos restrictivo para cada serie temporal a uno más particular.




Si bien las pruebas de ADF son útiles para detectar la presencia de raíces unitarias, los mismos tienen sus limitaciones. Partiendo del modelo general al particular, cada prueba está condicionada a que las pruebas anteriores sean correctas.  Cuando se empieza por el primer paso, es decir, con el modelo (c) con constante y con tendencia, se hace más difícil rechazar $H_0)$, por lo tanto, cuando se rechace la hipótesis nula en un modelo (c) se tiende a rechazar también la hipótesis nula cuando no se incluyan los términos deterministas.  A su vez, establece que el problema principal de las pruebas de Dickey-Fuller es que tanto el intercepto como la pendiente de la tendencia son, con frecuencia, estimados de manera \textit{pobre}  bajo la presencia de raíces unitarias. En general, se tiende a no rechazar la hipótesis nula de raíz unitaria incluso cuando el verdadero valor de $\gamma$ no es cero. Además, la prueba presenta limitaciones también frente a cambios de régimen.




\newpage

##### Pruebas KPSS

En @kpss, se parte de una representación cada serie temporal como la suma de un componente de tendencia determinística, un paseo aleatorio y un error estacionario. En este contexto, se pone a prueba


\begin{align*}
	H_0)&\text{ la serie es estacionaria alrededor de una tendencia}    \\
	H_1)&\text{ la serie es no estacionaria}
\end{align*}

que se corresponde con la hipótesis de que la varianza del paseo aleatorio (\textit{random walk}) es igual a cero. 

Se emplea un estadístico de Multiplicadores de Lagrange (ML) para testear la hipótesis nula de estacionariedad. De esta manera, siendo $z_t$ con $t=1,2,...,T$ las series a las que se les quiere aplicar el test, se asume que se puede descomponer a la serie en la suma de un componente de tendencia determinística, un paseo aleatorio y un error estacionario se tiene que,

\begin{equation}
	\label{eq: kpss2}    
	z_t=\xi t + r_t + \varepsilon_t
\end{equation}

Donde $r_t$ es un paseo aleatorio:

\begin{equation}
	\label{eq: kpss3}    
	r_t = r_{t-1} + u_t,
\end{equation}

donde $u_t$ es $iid(0,\sigma_u^2)$. El valor inicial $r_0$  es fijo y sirve se intercepto. La hipótesis de estacionariedad es $\sigma_u^2=0$ y como se asume que $\varepsilon_t$ es estacionario, bajo la hipótesis nula $z_t$ es estacionaria alrededor de una tendencia.

En el caso particular de que en el modelo \eqref{eq: kpss2} se tenga $\xi=0$, bajo la hipótesis nula $z_t$ va a ser estacionaria alrededor de una constante ($r_0$).

Sean $e_t$ con $t=1,2,...,T$, los residuos de la regresión $z$ con un intercepto y tendencia. A su vez, sea $\hat{\sigma_\varepsilon^2}$ la estimación del error de la varianza de la regresión (suma de los residuos al cuadrado divida $T$). Con lo anterior, se define el proceso de suma parcial de los residuos como

\begin{equation}
	\label{eq: kpss5}
	S_t=\sum_{i=1}^t r_i, \quad t=1,....,T   
\end{equation}

Entonces el estadístico ML es 

\begin{equation}
	\label{eq: kpss6}
	ML=\sum_{t=1}^T S^2_t/\hat{\sigma^2_\varepsilon}   
\end{equation}

En el caso de que se quiera poner a prueba la hipótesis nula de estacionariedad alrededor de una constante se define $e_t$ como los residuos de la regresión $z$ sobre un intercepto ($e_t=z_t-\bar{z})$.

Cabe resaltar que es una prueba de cola superior y se reportan los valores críticos. Además, para este caso se asume que los errores $\varepsilon_t \overset{\text{iid}}{\sim} \mathcal{N}(0,\sigma_{\varepsilon}^2)$
Sin embargo, se puede extender la prueba con supuestos más débiles sobre la distribución de los errores dado que el supuesto anterior puede ser poco realista.



```r
ts_relacion=df[,c('relacion')]
```




```r
result_adf <- suppressWarnings(adf.test(ts_relacion))
cat('p-valor adf:', result_adf$p.value ,'\n')
```

```
## p-valor adf: 0.01
```




```r
result_kpss <- suppressWarnings(kpss.test(ts_relacion))
cat('p-valor kpss:', result_kpss$p.value ,'\n')
```

```
## p-valor kpss: 0.1
```


```r
#install.packages('aTSA')
aTSA::adf.test(ts_relacion)
```

```
## Augmented Dickey-Fuller Test 
## alternative: stationary 
##  
## Type 1: no drift no trend 
##       lag    ADF p.value
##  [1,]   0 -1.326   0.205
##  [2,]   1 -0.770   0.404
##  [3,]   2 -0.543   0.486
##  [4,]   3 -0.414   0.525
##  [5,]   4 -0.340   0.547
##  [6,]   5 -0.298   0.559
##  [7,]   6 -0.255   0.571
##  [8,]   7 -0.221   0.581
##  [9,]   8 -0.190   0.590
## [10,]   9 -0.180   0.593
## [11,]  10 -0.164   0.597
## [12,]  11 -0.152   0.601
## [13,]  12 -0.141   0.604
## [14,]  13 -0.128   0.608
## Type 2: with drift no trend 
##       lag    ADF p.value
##  [1,]   0 -156.9    0.01
##  [2,]   1 -112.1    0.01
##  [3,]   2  -90.6    0.01
##  [4,]   3  -77.8    0.01
##  [5,]   4  -68.9    0.01
##  [6,]   5  -64.6    0.01
##  [7,]   6  -58.9    0.01
##  [8,]   7  -54.7    0.01
##  [9,]   8  -50.2    0.01
## [10,]   9  -47.2    0.01
## [11,]  10  -44.8    0.01
## [12,]  11  -42.6    0.01
## [13,]  12  -41.9    0.01
## [14,]  13  -40.1    0.01
## Type 3: with drift and trend 
##       lag    ADF p.value
##  [1,]   0 -156.9    0.01
##  [2,]   1 -112.1    0.01
##  [3,]   2  -90.6    0.01
##  [4,]   3  -77.8    0.01
##  [5,]   4  -68.9    0.01
##  [6,]   5  -64.7    0.01
##  [7,]   6  -59.0    0.01
##  [8,]   7  -54.7    0.01
##  [9,]   8  -50.2    0.01
## [10,]   9  -47.2    0.01
## [11,]  10  -44.9    0.01
## [12,]  11  -42.6    0.01
## [13,]  12  -41.9    0.01
## [14,]  13  -40.1    0.01
## ---- 
## Note: in fact, p.value = 0.01 means p.value <= 0.01
```




<!-- MARCO TEORICO -->

\newpage

\section{Marco teorico}
\subsection{El enfoque de conteo de eventos y los modelos de base Poissoniana.} 

Fijaremos un cierto umbral, llamaremos \textit{evento} cuando la variable observada supera ese umbral y dado un cierto intervalo del tiempo $J$, contaremos

\begin{eqution}
N(J)= \text{número de eventos en el intervalo}\; J.
\end{equation}


Fijando un $u=1.025$, el evento es una señal negativa del precio de $SP\$500$ que estaría dado por la cantidad de días en el mes $J$ que $Indicador_t$ supera el umbral $u$.
Un evento ser que $Indicador_t$ supere un umbral $u>1.025$.  Si el número de eventos está dado por los días de un mes, entonces $N(mes)$ va a ser la cantidad de días que occurió el evento en un mes, $N(mes)=3$ es la cantidad de señales negativas en el mes.

como la cantidad de días ($d$) que el indicar aumentó un cierto porcentaje de $d-1$ a $d$.

$2.5\%$ en un
Si $d$ es la cantidad de días y $J$ es el intervalo de días en un mes, N(mes)
N(mes)= cantidad de períodos de 3 días durante un mes, en que se registró una aumento mayor o igual a 2.5% del índice de un día para el otro.


$N$ es lo que se llama un proceso de conteo o proceso puntua\footnote{\textit{Counting process, Point process} en inglés}, un tipo de modelos utilizados en Logística, Telecomunicaciones, estudios de Contaminación Atmosférica o Costera, Clima, etc.

El proceso de conteo más simple es el llamado \textit{Proceso de Poisson}, que puede caracterizarse de la siguiente manera.


 
\begin{definition}[Proceso de Poisson]\label{def:1}
Si $N$ es un proceso de conteo y $\lambda>0$, diremos que $N$ es un Proceso de Poisson de parámetro $\lambda$ (y abreviaremos $N$ es $PP(\lambda)$ ) si se cumple:
\begin{itemize}
\item[a)] Para todo intervalo $J$ de los reales positivos, $N(J)$ es una variable aleatoria que tiene distribución de Poisson de parámetro $\lambda$ longitud($J$).
\item[b)] Si $J, L, M...$ es una cantidad arbitraria de intervalos de reales positivos \textit{disjuntos}, entonces $N(J), N(L), N(M),...$ son variables aleatorias independientes.
\end{itemize}
\end{definition}

El siguiente teorema brinda una visualización muy interesante de los Procesos de Poisson, que nos servirá mucho para introducir otros modelos y que es ideal para poder simular computacionalmente Procesos de Poissson.

\begin{theorem}[Otra visión de los Procesos de Poisson]\label{thm:otra_vision}
Si $T_1,...,T_n,...$ se supone $iid$,  con distribución Exponencial de parámetro $\lambda>0$ y definimos que ocurre el primer evento en el instante $T_1$, el segundo en el instante $T_1+T_2$, el tercero en el instante $T_1+T_2+T_3$ y asì sucesivamente, el proceso $N$ de conteo de tales eventos, es un proceso de Poisson.
\end{theorem}




Dicho de otro modo el Proceso de Poisson representa eventos aislados ("que ocurren de a uno y claramente separados"), con tiempos inter-eventos $iid$ y exponenciales.
Obviamente, esto muchas veces es \textit{too good to be true}, pero variaciones de este modelo tan simple pueden brindar modelos realistas.


##### Observación 1: 

En la práctica, si se toman datos en los instantes $1,...,n$ suele reescalarse el tiempo dividiendo por $n$ y los instantes quedan en $[0,1]$. Allí se define un $PP$ de manera casi idéntica, obviamente modificando en la definición, tanto en $a)$ como en $b)$ que los intervalos deben estar contenidos en $[0,1]$.

##### Observación 2: 

Conviene recordar que si $X$ es una $VA$ Poisson de parámetro $\lambda>0$ y $T$ es una $VA$ exponencial de parámetro $\lambda$, entonces $E(X)= \lambda$ y $E(T)=1/lambda$ . Si $T_1,...,T_n,...$ siendo $iid$ son los tiempos inter-eventos de un $PP(\lambda)$ se deduce entonces de la ley de los grandes números que

\begin{equation}
\frac{\sum_{i=1}^{i=n} T_i}{n} \rightarrow 1/ \lambda \quad cuando \quad n\rightarrow \infty
\end{equation}

Es decir que el tiempo promedio entre eventos "a la larga" es $1/\lambda$ . Similarmente si $J_1,...,J_n,...$ son intervalos disjuntos de longitud $1$, por la definición \ref{def:1} y la ley de los grandes números se tiene que


\begin{equation}
\frac{\sum_{i=1}^{i=n} N(J_i)}{n} \rightarrow \lambda \quad cuando \quad n\rightarrow \infty
\end{equation}

Más aún, puede probarse que

\begin{equation}
\frac{N((0,t))}{t} \rightarrow \lambda \quad cuando \quad t \rightarrow \infty
\end{equation}

Esto permite observar una consecuencia del Teorema \ref{thm:otra_vision}, que es una propiedad intuitivamente muy atractiva.

La tasa promedial de incidencia de los eventos en un $PP(\lambda)$ es inversamente proporcional al tiempo promedial inter-eventos.

##### Ejemplo 1: 

Propiedades como esta hicieron, en las primeras dos décadas del siglo $XX$, a un creador genial como Agner Erlang modelar mediante Procesos de Poisson las llamadas que arribaban a una central telefónica, así como (con parámetros muy distintos) el proceso de ocupación de las líneas entre dos centrales. Eso condujo no sólo al desarrollo de las primeras centrales de telefonía conmutada por circuitos por CTC, la filial danesa de Bell, sino además a que Erlang desarrollara su "fórmulas de bloqueo", fino cálculo por el cual, según los parámetros del proceso de arribo y del proceso de ocupación de líneas, se calcula la probabilidad de "saturación" (no hay ninguna línea disponible) dado el número de líneas entre centrales, o, dada una probabilidad de saturación “tolerable” ($\epsilon$).

DISEÑAR (determinar el mínimo número de lineas necesarias para que la probabilidad de bloqueo no exceda $\epsilon$ ). Si el tiempo entre arribos de llamadas a la central es Exponencial de parámetro $\lambda$, y la duración media de una llamada es Exponencial de parámetro $\mu$, entonces el parámetro crucial de la fórmula de Erlang es 

\begin{align}
\rho=&\lambda/\mu  \nonumber \\
= &\text{“duración media de la llamada”/ “tiempo medio entre llamadas”}\label{eq:ro}
\end{align}


y a mayor valor de $\rho$, mayor probabilidad de saturación para una conectividad dada. Esta fórmula  \eqref{eq:ro} aún sigue en uso en algunos problemas y dió pie al desarrollo de fórmulas de bloqueo más sofisticadas para situaciones más complejas. Con mucha justicia, la unidad en la que se mide la intensidad de tráfico en redes se llama \textit{erlang} y este ejemplo nos parece una clara muestra de cuán útil ha sido el muy sencillo Proceso de Poisson.
Sin embargo, en otros problemas, por ejemplo en modernas redes de datos en las que los “eventos” de “demanda de servicio” pueden ocurrir simultáneamente en muy grandes cantidades (“clustering”), aparece un modelo más sofisticado, que puede ser definido a partir del Proceso de Poisson: el Proceso de Poisson Compuesto.


\begin{definition}[Proceso de Poisson Compuesto]\label{def:2}
Si $N$ es un Proceso de Poisson de parámetro $\lambda>0$ , $G$ es una distribución de probabilidad en los naturales $1,2,3...$, consideramos un proceso $S_1,...,S_n$ $iid$ con distribución $G$ y construímos un nuevo proceso de conteo $M$ de la forma siguiente:
\begin{itemize}
\item Cuando $N$ tiene su primer evento, $M$ tiene $S_1$ eventos simultáneos;
\item Cuando $N$ tiene su segundo evento, $M$ tiene $S_2$ eventos simultáneos..... (y así sucesivamente)
\end{itemize}
decimos que $M$ es un Proceso de Poisson Compuesto de parámetro $\lambda>0$ y distribución de eventos $G$ (y abreviaremos $M$ es $PPC(\lambda;G)$)
\end{definition}


##### Ejercicio 1 : 

Demostrar que para un $PPC(\lambda;G)$ el tiempo medio inter-eventos sigue siendo $1/\lambda$, pero que la tasa de incidencia media de eventos ahora es $lambda E(G)$.



##### Observación 3. 

Para aclarar, si $G$ es una distribución degenerada otorga al 1 probabilidad 1, el correspondiente $PPC(\lambda;G)$ en realidad es un $PPC(\lambda)$. Ergo, el $PP$ es un caso particular de $PPC$.

##### Observación 4. 

Para evitar confusiones frecuentes, distinguiremos explícitamente estos procesos de los llamados Procesos de Poisson no-homogéneos. Para ello recordemos, sin entrar en tecnicismos, que una medida en los reales positivos es una función que a los conjuntos asocia números positivos con las mismas propiedades formales, excepto que no tiene por qué dar a todo el conjunto de los reales positivos ( a todo el universo) el valor 1. Dicho de otro modo una probabilidad es una medida particular, que a todo el universo asigna el valor 1. Puede pensarse como ejemplo típico de una medida, la que asigna a un conjunto la integral sobre ese conjunto de una función no negativa (no necesariamente de integral total 1, puede ser incluso infinita). La longitud es el ejemplo más simple de medida (llamada también medida de Lebesgue) y la longitud de todos los reales positivos es infinito. Puede demostrarse que la longitud multiplicada por una constante no negativa son las únicas medidas invariantes por traslaciones, punto importante para la distinción que queremos hacer.

\begin{definition}[Proceso de Poisson No Homogéneo]\label{def:3}
Si $N$ es un proceso de conteo y $m$ es una medida que NO puede expresarse como una constante por la longitud, diremos que $N$ es un Proceso de Poisson No Homogéneo de medida $m$ (y abreviaremos $N$ es $PPNH(m)$ ) si se cumple:

\begin{itemize}
\item[a)] Para todo intervalo $J$ de los reales positivos, $N(J)$ es una variable aleatoria que tiene distribución de Poisson de parámetro $m(J)$.
\item[b)] Si $J, L, M...$ es una cantidad arbitraria de intervalos positivos DISJUNTOS, entonces $N(J), N(L), N(M),...$ son variables aleatorias independientes.
\end{itemize}
\end{definition}

Queda claro que el proceso de Poisson podría verse de la manera a) y b) anterior cuando $m=\text{constante por longitud}$, por eso, para no confundir, se excluye a título expreso que $m$ pueda ser constante por longitud.
Para dejar en claro la diferencia entre los PPNH y los PPC ( o el simple PP), recordemos que en los PPC, los tiempos inter-eventos son exponenciales de parámetro $\lambda>0$ e $iid$. El siguiente resultado muestra la diferencia de conceptos. Por su extrema simplicidad, lo detallaremos.


\begin{theorem}[PPNH no es PPC]\label{thm:2}
Si $N$ es un PPNH y $T_1$ es el tiempo del primer evento, la distribución de $T_1$ no es exponencial.
Por lo tanto, un PPNH no es PPC.
\end{theorem}

<!-- ME QUEDE EN PAGINA 72 DEMOSTRACION-->


<!-- MT:  Peaks Over Treshold) y variantes-->

\newpage


\subsection{POT (Peaks Over Treshold) y variantes}



<!-- ESTRATEGIA EMPIRICA -->


\newpage
\section{Estrategia Empírica}



A la columna relativa a la relacion de precios se la resta por 1 para tener centrados los valores de la relacion de precios en cero. Y posteriormente analizar si las series, fijando distintos umbrales son estacionarias.











![](Entrega_Laura_Montaldo_files/figure-latex/unnamed-chunk-22-1.pdf)<!-- --> 



![](Entrega_Laura_Montaldo_files/figure-latex/unnamed-chunk-23-1.pdf)<!-- --> 



![](Entrega_Laura_Montaldo_files/figure-latex/unnamed-chunk-24-1.pdf)<!-- --> 

![](Entrega_Laura_Montaldo_files/figure-latex/unnamed-chunk-25-1.pdf)<!-- --> 



```r
filtered_df_0_025 <- df %>%
  filter(rel_cero>= 0.025)
```



```r
head(filtered_df_0_025)
```

```
##         Date  Open  High   Low Close Volume Dividends Stock.Splits relacion
## 1 1928-06-11 18.68 18.68 18.68 18.68      0         0            0 1.036938
## 2 1928-07-11 18.95 18.95 18.95 18.95      0         0            0 1.025330
## 3 1928-12-06 22.91 22.91 22.91 22.91      0         0            0 1.039284
## 4 1929-02-07 24.71 24.71 24.71 24.71      0         0            0 1.031566
## 5 1929-03-25 24.51 24.51 24.51 24.51      0         0            0 1.042432
## 6 1929-04-01 24.88 24.88 24.88 24.88      0         0            0 1.026125
##     rel_cero
## 1 0.03693793
## 2 0.02532979
## 3 0.03928414
## 4 0.03156620
## 5 0.04243162
## 6 0.02612546
```

```r
data=filtered_df_0_025[,c('Date', 'rel_cero')]
n=dim(data)[1]
```



```r
fecha_maxima <- max(data$Date)
# Reescalar el tiempo dividiendo cada fecha por la fecha máxima
data$tiempo_reescalado <- as.numeric(data$Date - min(data$Date)) / as.numeric(fecha_maxima - min(data$Date))
head(data)
```

```
##         Date   rel_cero tiempo_reescalado
## 1 1928-06-11 0.03693793      0.0000000000
## 2 1928-07-11 0.02532979      0.0008690614
## 3 1928-12-06 0.03928414      0.0051564311
## 4 1929-02-07 0.03156620      0.0069814600
## 5 1929-03-25 0.04243162      0.0083140209
## 6 1929-04-01 0.02612546      0.0085168019
```




```r
ggplot(df, aes(x = Date, y = rel_cero)) +
  geom_line() +
  geom_hline(yintercept = 0.05, linetype = "solid", color = "cyan") +  # Add horizontal line
  ggtitle("S&P500: Valores históricos del Indicador (03/01/1928-08/12/2023)") +
  xlab("Fecha") +
  ylab("Valores del Indicador") +
  scale_x_date(limits = date_range) +
  scale_y_continuous(breaks = seq(0, ceiling(max(df$relacion)), by = 0.05)) +
  theme(
    axis.title.x = element_text(margin = margin(t = 20, b = 40)),
    axis.title.y = element_text(margin = margin(r = 20, l = 40)),
    plot.title = element_text(size = 11, hjust = 0.5),  # Center the plot title
    axis.text = element_text(size = 10),  # Adjust the size of axis text
    axis.title = element_text(size = 12),  # Adjust the size of axis titles
    legend.title = element_text(size = 10),  # Adjust the size of legend title
    legend.text = element_text(size = 8)  # Adjust the size of legend text
  )
```

![](Entrega_Laura_Montaldo_files/figure-latex/unnamed-chunk-29-1.pdf)<!-- --> 



```r
filtered_df_0_05 <- df %>%
  filter(rel_cero >= 0.05)
dim(filtered_df_0_05)
```

```
## [1] 98 10
```


```r
plot(filtered_df_0_05)
```

![](Entrega_Laura_Montaldo_files/figure-latex/unnamed-chunk-31-1.pdf)<!-- --> 



```r
hist(filtered_df_0_05$relacion, main = "Histograma relacion con umbral 0.05 ", xlab = "relacion")
```

![](Entrega_Laura_Montaldo_files/figure-latex/unnamed-chunk-32-1.pdf)<!-- --> 

```r
hist(filtered_df_0_025$relacion, main = "Histograma relacion con umbral 0.025 ", xlab = "relacion")
```

![](Entrega_Laura_Montaldo_files/figure-latex/unnamed-chunk-33-1.pdf)<!-- --> 






