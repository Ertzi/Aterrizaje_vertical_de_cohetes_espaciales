% Introducimos los datos iniciales:
Dt = 1;
g = 0.1;
m = 10;
Fmax = 11;
P0x = 50;
P0y = 50;
P0z = 100;
V0x = -10;
V0y = 0;
V0z = -10;
alpha = 0.5;
gamma = 1;
K = 35;

% Utilizamos el algoritmo para resolver el problema:
[sol, optimvalue] = Algoritmo(Dt,g,m,Fmax,P0x,P0y,P0z,V0x,V0y,V0z,alpha,gamma,K);

% Dibujamos el grafico de la trayectoria y las fuerzas del motor para cada 
% momento de tiempo:

plot3(sol.P(1,:),sol.P(2,:),sol.P(3,:),'DisplayName', 'Trayectoria del cohete',Color="green");
xlabel("X")
ylabel("Y")
zlabel("Z")
xlim([-40 65])
ylim([-10 55])
zlim([0 115])
title(['Descenso con mínimo consumo de combustible (',num2str(optimvalue),' combustible utilizado)'])
grid on
hold on
quiver3(sol.P(1,:),sol.P(2,:),sol.P(3,:),[sol.F(1,:),0],[sol.F(2,:),0],[sol.F(3,:),0],"Color",'#80B3FF',"DisplayName",'Vectores de los perfiles de empuje')
quiver3(sol.P(1,1),sol.P(2,1),sol.P(3,1),sol.V(1,1),sol.V(2,1),sol.V(3,1), "Color","magenta","LineStyle","--","LineWidth",1.5,'AutoScale','on', 'AutoScaleFactor', 1,'DisplayName', 'Vector de velocidad inicial')
scatter3(sol.P(1,1),sol.P(2,1),sol.P(3,1),30,"black","filled","MarkerEdgeColor","k",'DisplayName', 'Posición inicial')
scatter3(sol.P(1,K+1),sol.P(2,K+1),sol.P(3,K+1),30,"red","filled","MarkerEdgeColor","k",'DisplayName', 'Posición objetivo')
legend('Location','best','FontSize',14)

% Dibujamos la pendiente de planeo mínima

%[X,Y] = meshgrid(-20:0.25:50);
%Z = sqrt(X.^2 + Y.^2)*alpha;
%contour3(X,Y,Z,50,"DisplayName","Pendiente de planeo mínima","Color","#000000")
hold off

% Gráficos extra:
% Plano xz:

%plot(sol.P(1,:),sol.P(3,:),'DisplayName', 'Trayectoria del cohete xz',Color="green");
%xlabel("X")
%ylabel("Z")
%xlim([-40 65])
%ylim([0 115])
%hold on
%title(['Descenso con mínimo consumo de combustible xz (',num2str(optimvalue),' combustible utilizado)'])
%quiver(sol.P(1,:),sol.P(3,:),[sol.F(1,:),0],[sol.F(3,:),0],"Color",'#80B3FF',"DisplayName",'Vectores de los perfiles de empuje xz')
%quiver(sol.P(1,1),sol.P(3,1),sol.V(1,1),sol.V(3,1), "Color","magenta","LineStyle","--","LineWidth",1.5,'AutoScale','on', 'AutoScaleFactor', 1,'DisplayName', 'Vector de velocidad inicial xz')
%scatter(sol.P(1,1),sol.P(3,1),30,"black","filled","MarkerEdgeColor","k",'DisplayName', 'Posición inicial')
%scatter(sol.P(1,K+1),sol.P(3,K+1),30,"red","filled","MarkerEdgeColor","k",'DisplayName', 'Posición objetivo')
%legend('Location','best','FontSize',14)
hold off

% Plano yz:

%plot(sol.P(2,:),sol.P(3,:),'DisplayName', 'Trayectoria del cohete yz',Color="green");
%xlabel("Y")
%ylabel("Z")
%xlim([-40 65])
%ylim([0 115])
%hold on
%title(['Descenso con mínimo consumo de combustible yz (',num2str(optimvalue),' combustible utilizado)'])
%quiver(sol.P(2,:),sol.P(3,:),[sol.F(2,:),0],[sol.F(3,:),0],"Color",'#80B3FF',"DisplayName",'Vectores de los perfiles de empuje yz')
%quiver(sol.P(2,1),sol.P(3,1),sol.V(2,1),sol.V(3,1), "Color","magenta","LineStyle","--","LineWidth",1.5,'AutoScale','on', 'AutoScaleFactor', 1,'DisplayName', 'Vector de velocidad inicial yz')
%scatter(sol.P(2,1),sol.P(3,1),30,"black","filled","MarkerEdgeColor","k",'DisplayName', 'Posición inicial')
%scatter(sol.P(2,K+1),sol.P(3,K+1),30,"red","filled","MarkerEdgeColor","k",'DisplayName', 'Posición objetivo')
%legend('Location','best','FontSize',14)
%hold off

% Plano xy

%plot(sol.P(1,:),sol.P(2,:),'DisplayName', 'Trayectoria del cohete xy',Color="green");
%xlabel("X")
%ylabel("Y")
%xlim([-40 65])
%ylim([-40 65])
%hold on
%title(['Descenso con mínimo consumo de combustible xy (',num2str(optimvalue),' combustible utilizado)'])
%quiver(sol.P(1,:),sol.P(2,:),[sol.F(1,:),0],[sol.F(2,:),0],"Color",'#80B3FF',"DisplayName",'Vectores de los perfiles de empuje xy')
%quiver(sol.P(1,1),sol.P(2,1),sol.V(1,1),sol.V(2,1), "Color","magenta","LineStyle","--","LineWidth",1.5,'AutoScale','on', 'AutoScaleFactor', 1,'DisplayName', 'Vector de velocidad inicial xy')
%scatter(sol.P(1,1),sol.P(2,1),30,"black","filled","MarkerEdgeColor","k",'DisplayName', 'Posición inicial')
%scatter(sol.P(1,K+1),sol.P(2,K+1),30,"red","filled","MarkerEdgeColor","k",'DisplayName', 'Posición objetivo')
%legend('Location','best','FontSize',14)
%hold off


