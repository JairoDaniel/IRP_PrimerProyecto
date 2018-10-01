function [W1,W2,X,Y] = setDatos(datos, neuronas, clases)
  [X Y]=create_data(datos, clases, "vertical");
  [WT1]=create_data(neuronas,clases, "vertical");
  [WT2]=create_data(neuronas,clases, "vertical");
  W1=([WT1 WT2(:,1)]);
  [WT3]=create_data(neuronas+1,clases, "vertical");
  WT4 = [ones(clases,1)];
  W2=(WT4*WT3(:,1)');
endfunction