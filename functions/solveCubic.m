function[a,b,c,d] = solveCubic(x1,y1, x2,y2, deriv1, deriv2)

A = [x1^3 x1^2 x1 1; x2^3 x2^2 x2 1; 3*x1^2 2*x1 1 0;3*x2^2 2*x2 1 0];
B = [y1;y2;deriv1;deriv2];
C = linsolve(A,B);
a = C(1);
b = C(2);
c = C(3);
d = C(4);