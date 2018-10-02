#Función que devuelve los valores de W1 y W2 a partir de los gradientes
# conjugados de la función cg_min de optim. Devuelve W1,W2, las iteraciones 
function [W1,W2,v,iteraciones] = bgdTrainGC(W1,W2,X,Y)
    pkg load optim; 
    W = packweights(W1,W2);
    dim = [rows(W1),columns(W1),rows(W2),columns(W2)];
    p = {W,X,Y,dim};
    ctl = [1,0.05,1,1000,3];
    t=@(W) target(W1,W2,X,Y);
    gt=@(W) gradtarget(W1,W2,X,Y);
   [wn,v,nev] = cg_min(gt,t,p,ctl);
   [W1,W2] = unpackweights(W,rows(W1),columns(W1),rows(W2),columns(W2));
   iteraciones=nev(1:1)
endfunction
