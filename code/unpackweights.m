function [W1, W2]=unpackweights(W, W1rows, W1cols, W2rows, W2cols)
  W1=[reshape(W(1:(W1rows*W1cols)),W1rows,W1cols)];
  W2=[reshape(W((W1rows*W1cols)+1:rows(W)),W2rows,W2cols)];
endfunction