% направление
azimuth = pi/10;
elevation = pi/8;

% точка
radius = 2;
O = point(azimuth, elevation, radius);

% диаграмма направленности
F = [ diagram_f(azimuth, elevation) , diagram_s(azimuth, elevation) ];
% вычисляем собственные числа и векторы
[V, D] = eig(F*F');
% оптимальные огибающие
[ ~, index ] = max(abs(diag(D)));
a = F'*V(:,index);
a = a/norm(a);
% оптимальная поляризация
p = F*a;

% орты
[ua, ue] = units(azimuth, elevation);
% напряжённость первого канала
[E1a, E1e] = tension(F(:,1)*a(1));
E1 = E1a .* ua + E1e .* ue;
% напряжённость второго канала
[E2a, E2e] = tension(F(:,2)*a(2));
E2 = E2a .* ua + E2e .* ue;
% оптимальная напряжённость
[Epa, Epe] = tension(p);
Ep = Epa .* ua + Epe .* ue;

figure
hold on
% оси
plot3([0 1], [0 0], [0 0], 'g');
plot3([0 0], [0 1], [0 0], 'g');
plot3([0 0], [0 0], [0 1], 'g');
% направление
plot3([0 O(1)], [0 O(2)], [0 O(3)], 'k');
% напряжённость первого канала
plot3(O(1) + E1(1,:), O(2) + E1(2,:), O(3) + E1(3,:), 'db')
% напряжённость второго канала
plot3(O(1) + E2(1,:), O(2) + E2(2,:), O(3) + E2(3,:), 'dr')
% оптимальная напряжённость
plot3(O(1) + Ep(1,:), O(2) + Ep(2,:), O(3) + Ep(3,:), 'dm')
hold off
axis equal