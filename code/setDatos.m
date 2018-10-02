function [W1,W2,X,Y] = setDatos(datos, neuronas, clases, tipo="radial")
  [X Y]=create_data(datos, clases, tipo);
  [WT1]=create_data(neuronas,clases, tipo);
  [WT2]=create_data(neuronas,clases, tipo);
  W1=([WT1 WT2(:,1)]);
  [WT3]=create_data(neuronas+1,clases, tipo);
  WT4 = [ones(clases,1)];
  W2=(WT4*WT3(:,1)');
endfunction