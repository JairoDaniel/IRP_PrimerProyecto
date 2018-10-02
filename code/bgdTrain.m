function [lossF, it, W1N, W2N]=bgdTrain(W1,W2,X,Y,size=130)
  n=rows(X); #n par
  W1rows=rows(W1);
  W1cols=columns(W1);
  W2rows=rows(W2);
  W2cols=columns(W2);
  W=packweights(W1,W2);
  error=[];
  iter=[];
  # Learning rate
  alpha = 0.05;
  epsilon=0.00005;
  lossFunction=target(W1,W2,X,Y);
  for i=[1:100000]
    ind=randi(n-size);
    tempX=[X((ind:ind+size),:)];
    tempY=[Y((ind:ind+size),:)];
    [W1,W2]=unpackweights(W, W1rows, W1cols, W2rows, W2cols);
    [gn1, gn2] = gradtarget(W1,W2,tempX,tempY); # Gradient
    gn=packweights(gn1,gn2);
    Wn=W-(alpha * gn);
    [W1,W2]=unpackweights(Wn, W1rows, W1cols, W2rows, W2cols);
    lossFunctionNew=target(W1,W2,tempX,tempY);
    error = [error, lossFunctionNew];
    iter=[iter, i];
    if(abs(lossFunction-lossFunctionNew)<epsilon) break;
    endif;
    W=Wn;
    lossFunction=lossFunctionNew;
    printf("i: %d ,lossFunctionNew: %d   \r",i,lossFunctionNew);
    fflush(stdout);
  endfor
  W=Wn;
  lossF=error;
  it=iter;
  [W1N, W2N] = unpackweights(W, W1rows,W1cols,W2rows,W2cols);
  figure(1);
  hold off;
  plot(it,lossF,"-b");
  hold on;
endfunction