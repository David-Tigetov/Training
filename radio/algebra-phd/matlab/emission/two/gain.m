% коэффициент усиления для излучателя с четырьмя каналами
% диаграмма направленности
F = [
        0.1*exp(1i*pi/6), 0.3*exp(1i*5*pi/4);
        0.2*exp(1i*pi/3), 0.1*exp(-1i*pi/10);
    ];

% оптимальная поляризация
[V, D] = eig(F*F');
% оптимальные огибающие
a = F'*V(:,2);
a = a/norm(a);
% оптимальная поляризация
p = F*a;

% векторы напряжённости в каналах
[E1x, E1y] = tension(F(:,1)*a(1));
[E2x, E2y] = tension(F(:,2)*a(2));

% напряжённость оптимальной поляризации
[Epx, Epy] = tension(p);

% рисунок векторов напряжённости
figure
hold on
% первый канал
plot(E1x, E1y, 'b')
plot(E1x(1), E1y(1), 'dk')
plot(E1x(2), E1y(2), 'db')
% второй канал
plot(E2x, E2y, 'r')
plot(E2x(1), E2y(1), 'dk')
plot(E2x(2), E2y(2), 'dr')
% оптимальная
plot(Epx, Epy, 'm')
plot(Epx(1), Epy(1), 'dk')
plot(Epx(2), Epy(2), 'dm')
% векторы
plot([0, E1x(1)], [0, E1y(1)], 'b')
plot([0, E2x(1)], [0, E2y(1)], 'r')
plot([E1x(1), E1x(1) + E2x(1)], [E1y(1), E1y(1) + E2y(1)], 'r')
plot([E2x(1), E1x(1) + E2x(1)], [E2y(1), E1y(1) + E2y(1)], 'b')
hold off
axis equal
grid on