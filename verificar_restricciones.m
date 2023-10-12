function [bool] = verificar_restricciones(P,V,F,F_norm,Fmax,K,alpha,Dt,g,m,tolerancia)
% Verifica que una solución cumpla las restricciones:
% true si las cumple, false si no

bool = true;
P_new = [P(1,1) zeros(1,K);P(2,1) zeros(1,K);P(3,1) zeros(1,K)];
V_new = [V(1,1) zeros(1,K);V(2,1) zeros(1,K);V(3,1) zeros(1,K)];

% P_K = (0,0,0)?
    if ((abs(P(1,K+1) - 0) > tolerancia) | (abs(P(2,K+1) - 0) > tolerancia) | (abs(P(3,K+1) - 0) > tolerancia))
        bool = false;
        disp("P_K = (0,0,0)?")
    end
% V_K = (0,0,0)?
    if ((abs(V(1,K+1) - 0) > tolerancia) | (abs(V(2,K+1) - 0) > tolerancia) | (abs(V(3,K+1) - 0) > tolerancia))
        bool = false;
        disp("V_K = (0,0,0)")
    end
for i = 1:K
    % F_norm(i) <= F_max?
    if F_norm(i) > Fmax
        bool = false;
        disp("F_norm(i) <= F_max")
        break
    end

    % P_z >= alpha * sqrt(P_x ^2 + P_y ^2)?
    if P(3,i) < alpha * sqrt(P(1,i)^2 + P(2,i)^2)
        bool = false;
        disp("P_z >= alpha * sqrt(P_x ^2 + P_y ^2)")
        break
    end

    % F_norm(i) == sqrt(F(1,i)^2 + F(2,i)^2 + F(3,i)^2)
    if abs(F_norm(i) - sqrt(F(1,i)^2 + F(2,i)^2 + F(3,i)^2)) > tolerancia
        bool = false;
        disp("F_norm(i) == sqrt(F(1,i)^2 + F(2,i)^2 + F(3,i)^2)")
        break
    end

    V_new(1,i+1) = V(1,i) + (Dt/m) * F(1,i);
    V_new(2,i+1) = V(2,i) + (Dt/m) * F(2,i);
    V_new(3,i+1) = V(3,i) + (Dt/m) * F(3,i) - Dt*g;

    P_new(1,i+1) = P_new(1,i) + (Dt/2) * (V_new(1,i) + V_new(1,i+1));
    P_new(2,i+1) = P_new(2,i) + (Dt/2) * (V_new(2,i) + V_new(2,i+1));
    P_new(3,i+1) = P_new(3,i) + (Dt/2) * (V_new(3,i) + V_new(3,i+1));
end

% V_new - V == 0?
% P_new - P == 0 ?
for i = 1:3
    for j = 1: K+1
        if abs(V_new(i,j) - V(i,j)) > tolerancia
            bool = false;
            disp("V_new - V == 0")
            break
        end
        if abs(P_new(i,j) - P(i,j)) > tolerancia
            bool = false;
            disp("P_new - P == 0 ")
                
            break
        end
    end
end

end

