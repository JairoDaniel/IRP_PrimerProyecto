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

[W1,W2,X,Y] = setDatos(m,mk,k);

W1rows=rows(W1);
W1cols=columns(W1);
W2rows=rows(W2);
W2cols=columns(W2);
  
#Entrenar pesos
[lossF, it , w1, w2]=bgdTrain(W1,W2,X,Y,m/2);

#[W1,W2]=unpackweights(w, W1rows, W1cols, W2rows, W2cols); 
#Predecir salida con los pesos entrenados
yp = predict(w1,w2,X);

#Normalizar la suma de Y da 1 en las salidas de las clases
Y=yp;
Y=Y'./sum(Y');
Y=Y';

X = [ones(rows(X),1) X]; ## Prefix them with the bias term (ones)



## Create an image, where the color of the pixel is created by
## combining a bunch of colors representing each class, and the
## mixture is made with the probabilities.

x=linspace(-1,1,filaPixelImagen);
[GX,GY]=meshgrid(x,x);

FZ =Y'; ## Add the last probability

#Vector de los maximos
[maxprob,maxk]=max(FZ);


## Plot the data
figure(1); hold off;

colors={"r";"g";"b";"m";"c";"k"};
markers={"o";"s";"v";"*";"x";"+"};

scatter(X(maxk==1,2),X(maxk==1,3),colors{1},markers{1},"filled");
hold on;
for kk=2:k
  scatter(X(maxk==kk,2),X(maxk==kk,3),colors{kk},markers{kk},"filled");
endfor

grid on;
daspect([1,1,1]);
axis([-2,2,-2,2]);
xlabel("x");
ylabel("y");
title("All classes");

## A figure with the winners
figure(k+2);
winner=flip(uint8(reshape(maxk,size(GX))),1);
cmap = [0,0,0; 1,0,0; 0,1,0; 0,0,1; 0.5,0,0.5; 0,0.5,0.5; 0.5,0.5,0.0];
wimg=ind2rgb(winner,cmap);
imshow(wimg);
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


