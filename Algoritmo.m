function [sol,optimvalue] = Algoritmo(Dt,g,m,Fmax,P0x,P0y,P0z,V0x,V0y,V0z,alpha,gamma,K)
% Resuelve el problema de optimización del apartado a).

% Creamos un problema de optimización e introducimos las variables a
% optimizar.
prob = optimproblem("ObjectiveSense","min");
F_norm = optimvar("F_norm",K);
P = optimvar("P",3,K+1,"Type","continuous");
V = optimvar("V",3,K+1,"Type","continuous");
F = optimvar("F",3,K,"Type","continuous");

% Definimos la función a minimizar
prob.Objective = gamma * Dt * sum(F_norm);

% Introducimos los valores iniciales de p(0)
prob.Constraints.P0x = P(1,1) == P0x;
prob.Constraints.P0y = P(2,1) == P0y;
prob.Constraints.P0z = P(3,1) == P0z;

% Introducimos los valores iniciales de v(0)
prob.Constraints.V0x = V(1,1) == V0x;
prob.Constraints.V0y = V(2,1) == V0y;
prob.Constraints.V0z = V(3,1) == V0z;

% Introducimos los valores de p(K)
prob.Constraints.PKx = P(1,K+1) == 0;
prob.Constraints.PKy = P(2,K+1) == 0;
prob.Constraints.PKz = P(3,K+1) == 0;

% Introducimos los valores de v(K)
prob.Constraints.VKx = V(1,K+1) == 0;
prob.Constraints.VKy = V(2,K+1) == 0;
prob.Constraints.VKz = V(3,K+1) == 0;

force_norms = optimconstr(K); 
for i = 1:K
    force_norms(i) = F_norm(i) == sqrt(F(1,i)^2 + F(2,i)^2 + F(3,i)^2);
end
prob.Constraints.force_norms = force_norms;

% Introducimos las condiciones de la ecuacion (2)
pos_relations_x = optimconstr(K+1);
pos_relations_y = optimconstr(K+1);
pos_relations_z = optimconstr(K+1);
for i = 1:K
    pos_relations_x(i) = P(1,i+1) == P(1,i) + (Dt/2) * (V(1,i)+V(1,i+1));
    pos_relations_y(i) = P(2,i+1) == P(2,i) + (Dt/2) * (V(2,i)+V(2,i+1));
    pos_relations_z(i) = P(3,i+1) == P(3,i) + (Dt/2) * (V(3,i)+V(3,i+1));
end
prob.Constraints.pos_relations_x = pos_relations_x;
prob.Constraints.pos_relations_y = pos_relations_y;
prob.Constraints.pos_relations_z = pos_relations_z;

% Introducimos las condiciones de la ecuacion (1)
vel_relations_x = optimconstr(K+1);
vel_relations_y = optimconstr(K+1);
vel_relations_z = optimconstr(K+1);
for i = 1:K
    vel_relations_x(i) = V(1,i+1) == V(1,i) + (Dt/m) * F(1,i);
    vel_relations_y(i) = V(2,i+1) == V(2,i) + (Dt/m) * F(2,i);
    vel_relations_z(i) = V(3,i+1) == V(3,i) + (Dt/m) * F(3,i) - Dt*g;
end
prob.Constraints.vel_relations_x = vel_relations_x;
prob.Constraints.vel_relations_y = vel_relations_y;
prob.Constraints.vel_relations_z = vel_relations_z;

% Introducimos las condiciones de la ecuacion (4)
pos_restrictions = optimconstr(K+1);
for i = 1:K+1
    pos_restrictions(i) =  alpha * sqrt(P(1,i)^2 + P(2,i)^2) <= P(3,i);
end
prob.Constraints.pos_restrictions = pos_restrictions;

% Introducimos las condiciones de la ecuacion (3)
force_restriction = optimconstr(K);
for i = 1:K
    force_restriction(i) = F_norm(i) <= Fmax;
end
prob.Constraints.force_restriction = force_restriction;

% Introducimos los valores iniciales de P, V, F y F_norm
P_initial = [uniform_descent(P0x,0,K);uniform_descent(P0y,0,K); uniform_descent(P0z,0,K)];
V_initial = [uniform_descent(V0x,0,K);uniform_descent(V0y,0,K); uniform_descent(V0z,0,K)];
F_initial = ones(3,K);
F_norm_initial = sqrt(3)*ones(1,K);

% Otros valores iniciales de P, V, F y F_norm
%initial.P = ones(3,K+1)
%initial.V = ones(3,K+1)
%initial.F = ones(3,K)
%initial.F_norm = ones(1,K)

initial.P = P_initial;
initial.V = V_initial;
initial.F = F_initial;
initial.F_norm = F_norm_initial;

% Resolvemos el problema
[sol,optimvalue] = solve(prob,initial);

end