function y=predict(W1,W2,X)
    
  # usage predict(W1,W2,X)
  # 
  # This function propagates the input X on the neural network to
  # predict the output vector y, given the weight matrices W1 and W2 for 
  # a two-layered artificial neural network.
  # 
  # W1: weights matrix between input and hidden layer
  # W2: weights matrix between the hidden and the output layer
  # X:  Input vector, extended at its end with a 1
    
  # PONGA SU CODIGO AQUÍ
  
  vectX = [ones(rows(X),1) X];
  x1=W1*vectX';
  gTemp=(1./(1+(e.^(-x1))))';
  
  vectX2 = [ones(rows(gTemp),1) gTemp];
  
  x2=W2*vectX2';
  y=(1./(1+(e.^(-x2))))';
  
endfunction;
