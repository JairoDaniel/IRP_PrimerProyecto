function w=packweights(W1,W2)
  w=[reshape(W1,prod(size(W1)),1) ; reshape(W2,prod(size(W2)),1)];
endfunction
