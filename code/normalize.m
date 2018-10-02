 #Función que normaliza la suma de Y da 1 en las salidas de las clases
function Y=normalize(yp)
  Y=yp;
  Y=Y'./sum(Y');
  Y=Y';
  
  for i=1:rows(Y)
    for j=1:columns(Y)
      if Y(i,j) != max(Y(i,:))
        Y(i,j) = 0;
      else
        Y(i,j) = 1;
      endif
    endfor
  endfor
endfunction