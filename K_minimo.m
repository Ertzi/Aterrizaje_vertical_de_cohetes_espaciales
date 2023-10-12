function [K_min] = K_minimo(Dt,g,m,Fmax,P0x,P0y,P0z,V0x,V0y,V0z,alpha,gamma,K,tolerancia)
%Devuelve el K más pequeño con el que el algoritmo no de error.
v = ones(1,K);
while  K > 0
sol = Algoritmo(Dt,g,m,Fmax,P0x,P0y,P0z,V0x,V0y,V0z,alpha,gamma,K);
if verificar_restricciones(sol.P,sol.V,sol.F,sol.F_norm,Fmax,K,alpha,Dt,g,m,tolerancia) == 0
    v(K) = 0;
end
K = K-1 % Para ver en qué iteración vamos
end

disp(v) % Para ver en qué iteraciones falla el algoritmo
K_min = find(v,1,"first");
end

