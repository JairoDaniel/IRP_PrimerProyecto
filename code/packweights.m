function w=packweights(W1,W2)
  
  W1=[W1 ; [ones(1,3)]];
  w=[W1 , W2'];
endfunction
