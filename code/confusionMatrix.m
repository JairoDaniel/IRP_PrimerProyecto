[W1,W2,X,Y] = setDatos(30,5,2);
[lossF,it,W1N,W2N]=bgdTrain(W1,W2,X,Y,3);
[W1e,W2e,Xe,Ye] = setDatos(30,5,2);
yp=predict(W1N,W2N,Xe);
yn=normalize(yp);
conMat=Y'*yn
TN=conMat(1:1);
FP=conMat(:,2)(1);
FN=conMat(2);
TP=conMat(:,2)(2);

F1=(2*TP)/((2.*TP)+FP+FN)
sensitividad=TP/(TP+FN)
precision=TP/(TP+FP)