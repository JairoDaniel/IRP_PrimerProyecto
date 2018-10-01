function [W1, W2]=unpackweights(W)
  W1=[W(:,1) W(:,2) W(:,3)];
  W1(rows(W1),:) = [];
  W(:,1)=[];
  W(:,1)=[];
  W(:,1)=[];
  W2=W';
endfunction