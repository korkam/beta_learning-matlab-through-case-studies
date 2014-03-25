function B = signs(A) 
B = (A>0)-(A<0);
B(~isfinite(B)) = 0;