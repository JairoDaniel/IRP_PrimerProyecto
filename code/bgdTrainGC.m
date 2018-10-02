function [lossF, it]=bgdTrainGC(W1,W2,X,Y,size=130)
  pkg load optim;
  n=rows(X); #n par
  W1rows=rows(W1);
  W1cols=columns(W1);
  W2rows=rows(W2);
  W2cols=columns(W2);
  W=packweights(W1,W2);
  lossFunction=target(W1,W2,X,Y)
  lossFunctionNew=0;
  error=[];
  iter=[];
  alpha = 0.05;
  epsilon=0.00005; 
  for i=[1:10000]
    ind=randi(n-size);
    tempX=[X((ind:ind+size),:)];
    tempY=[Y((ind:ind+size),:)];
    [W1,W2]=unpackweights(W, W1rows, W1cols, W2rows, W2cols);
    t=@(W) target(W1,W2,tempX,tempY);
    gt=@(W) gradtarget(W1,W2,tempX,tempY);
    [w2, v, nev] =  cg_min(gt,t, W);
    Wn=W-alpha*w2;
    [W1, W2]=unpackweights(Wn, W1rows,W1cols,W2rows,W2cols);
    lossFunctionNew=target(W1,W2,tempX,tempY);
    iter=[iter i];
    error=[error lossFunctionNew];
    if(abs(lossFunction-lossFunctionNew)<epsilon) break;
    endif;
    printf("i: %d ,lossFunctionNew: %d   \r",i,lossFunctionNew);
    fflush(stdout);
    W=Wn;
    lossFunction=lossFunctionNew;
  endfor
  figure(1);
  hold off;
  plot(iter,error,"-b");
  hold on;
  it=iter;
  lossF=error;
endfunction