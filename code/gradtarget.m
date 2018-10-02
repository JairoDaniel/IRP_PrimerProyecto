function [gW1,gW2]=gradtarget(W1,W2,X,Y)

  # usage gradtarget(W1,W2,X,Y)
  # 
  # This function evaluates the gradient of the target function on W1 and W2.
  # 
  # W1: weights matrix between input and hidden layer
  # W2: weights matrix between the hidden and the output layer
  # X:  training set holding on the rows the input data, plus a final column 
  #     equal to 1
  # Y:  labels of the training set
    
  # PONGA SU CODIGO AQUÍ
  
  yp=predict(W1,W2,X);
  deltak=(yp-Y).*yp.*(1-yp);
  vectX = [ones(rows(X),1) X];
  a1=W1*vectX';
  zj=(1./(1.+(e.^(-a1))))';
  tempW2=W2;
  tempW2(:,1)=[];
  deltaj= (zj' .* (1.-zj') .* (tempW2' * deltak'))';
  zj=[ones(rows(zj),1) zj];
  gW1=deltaj'*vectX;
  gW2=(deltak'*zj);
endfunction;
