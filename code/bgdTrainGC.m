function [lossF, it]=bgdTrainGC(W1,W2,X,Y,size=60)
  pkg load optim;
  n=rows(X); #n par
  W1rows=rows(W1);
  W1cols=columns(W1);
  W2rows=rows(W2);
  W2cols=columns(W2);
  W=packweights(W1,W2);
  t1=target(W1,W2,X,Y)
  errVal=0;
  error=[];
  iter=[];
  alpha = 0.01;
  epsilon=0.5;
  while(abs(t1-errVal)<epsilon)
    t=@(W) target(W1,W2,X,Y);
    gt=@(W) gradtarget(W1,W2,X,Y);
    [w2, v, nev] =  cg_min(gt,t, W);
    Wn=W-alpha*w2;
    [W1, W2]=unpackweights(Wn, W1rows,W1cols,W2rows,W2cols);
    errVal=target(W1,W2,X,Y);
    iter=[iter i];
    error=[error errVal];
    W=Wn;
  endwhile
  #for i=[1:5000]
    #t=@(W) target(W1,W2,X,Y);
    #gt=@(W) gradtarget(W1,W2,X,Y);
    #[w2, v, nev] =  cg_min(gt,t, W);
    #Wn=W-alpha*w2;
    #[W1, W2]=unpackweights(Wn, W1rows,W1cols,W2rows,W2cols);
    #errVal=target(W1,W2,X,Y);
    #if(abs(t1-errVal)<epsilon) break;
    #endif;
   # delta=sqrt(max(sum((Wn-W).^2)));
   # if(delta<epsilon) break;
   #endif;
    #iter=[iter i];
    #error=[error errVal];
   # W=Wn;
  #endfor
  figure(1);
  hold off;
  plot(iter,error,"-b");
  hold on;
  it=iter;
  lossF=error;
endfunction