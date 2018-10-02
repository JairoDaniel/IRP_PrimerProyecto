#!/usr/bin/octave-cli
## Logistic regression example

close all;
pkg load statistics;

##################################
## Construct some training data ##
##################################


k=3;   ## Number of classes
mk=5; ## Number of training points per class (NEURONAS)
filaPixelImagen=10 #Tamaño de imagen
m=filaPixelImagen*filaPixelImagen; #Datos de entrada 

[W1,W2,X,Y] = setDatos(m,mk,k,"radial");
plot_data(X,Y);
W1rows=rows(W1);
W1cols=columns(W1);
W2rows=rows(W2);
W2cols=columns(W2);
  
#Entrenar pesos
[lossF, it , w1, w2]=bgdTrain(W1,W2,X,Y,m/2);
Xzero=zeros(m,2);

#Cambiar para generar imagen mas random
for i= 1:filaPixelImagen
  for j= 1:filaPixelImagen
    Xzero(j+filaPixelImagen*(i-1),1)=(i-1);
    Xzero(j+filaPixelImagen*(i-1),2)=(j-1);
  endfor;
endfor; 
 
#mapear X
m=2/(filaPixelImagen-1);
Xm=m*Xzero -1; 
#Predecir salida con los pesos entrenados
yp = predict(w1,w2,Xm);

#Normalizar la suma de Y da 1 en las salidas de las clases
Y=yp;
Y=Y'./sum(Y');
Y=Y';

#X = [ones(rows(X),1) X]; ## Prefix them with the bias term (ones)



## Create an image, where the color of the pixel is created by
## combining a bunch of colors representing each class, and the
## mixture is made with the probabilities.

x=linspace(-1,1,filaPixelImagen);
[GX,GY]=meshgrid(x,x);

FZ =Y'; ## Add the last probability

#Vector de los maximos
[maxprob,maxk]=max(FZ);


cmap = [0,0,0; 1,0,0; 0,1,0; 0,0,1; 0.5,0,0.5; 0,0.5,0.5; 0.5,0.5,0.0];

## A figure with the winners
figure(k+2);

for i=1:rows(Y)
  for j=1:columns(Y)
    if Y(i,j) != max(Y(i,:))
      Y(i,j) = 0;
    else
      Y(i,j) = 1;
    endif
  endfor
endfor
salida=Y';
ccmap = cmap(2:1+k,:);
cwimg = ccmap'*salida;
redChnl   = reshape(cwimg(1,:),size(GX));
greenChnl = reshape(cwimg(2,:),size(GX));
blueChnl  = reshape(cwimg(3,:),size(GX));
mixed1 = flip(cat(3,redChnl,greenChnl,blueChnl),1);
imshow(mixed1);
title("Winner classes");


## A figure with the weighted winners
figure(k+3);

ccmap = cmap(2:1+k,:);
cwimg = ccmap'*FZ;
redChnl   = reshape(cwimg(1,:),size(GX));
greenChnl = reshape(cwimg(2,:),size(GX));
blueChnl  = reshape(cwimg(3,:),size(GX));

mixed = flip(cat(3,redChnl,greenChnl,blueChnl),1);
imshow(mixed);
title("Softmax classes");



