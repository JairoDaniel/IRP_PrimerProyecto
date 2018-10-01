function [lossF, it]=bgdTrain(W1,W2,X,Y,size=30)
  n=rows(X); #n par
  W=packweights(W1,W2);
  errorAct=0;
  errorAnt=1;
  error=[];
  iter=[];
  # Learning rate
  alpha = 0.01;
  epsilon=0.00001
for i=[1:50000]
  ind=randi(n-size);
  tempX=[X((ind:ind+size),:)];
  tempY=[Y((ind:ind+size),:)];
  [W1,W2]=unpackweights(W);
  [gn1 gn2] = gradtarget(W1,W2,tempX,tempY); # Gradient
  W1n=W1.-alpha.*gn1;
  W2n=W2.-alpha.*gn2;
  Wn= packweights(W1n, W2n);
  lossFunction=target(W1,W2,X,Y);
  error = [error lossFunction];
  iter=[iter i];
  delta=sqrt(max(sum((Wn-W).^2)));
  if(delta<epsilon) break;
  endif;
  W=Wn;
endfor
iteraciones=i
lossF=error;
it=iter;

figure(1);
hold off;
plot(it,lossF,"-b");
hold on;
endfunction