% коэффициент усиления для двух излучателей
% диаграмма направленности
F = [
        0.1*exp(1i*pi/6), 0.3*exp(1i*5*pi/4);
        0.2*exp(1i*pi/3), 0.1*exp(-1i*pi/10);
    ];

% оптимальная поляризация
[V, D] = eig(F*F');
[ ~, index ] = max(abs(diag(D)));
% оптимальные огибающие
a = F'*V(:,index);
a = a/norm(a);
% оптимальная поляризация
p = F*a;

% векторы напряжённости в каналах
[E1a, E1e] = tension(F(:,1)*a(1));
[E2a, E2e] = tension(F(:,2)*a(2));

% напряжённость оптимальной поляризации
[Epa, Epe] = tension(p);

% рисунок векторов напряжённости
figure
hold on
% первый излучатель
plot(E1a, E1e, 'b')
plot(E1a(1), E1e(1), 'dk')
plot(E1a(2), E1e(2), 'db')
% второй излучатель
plot(E2a, E2e, 'r')
plot(E2a(1), E2e(1), 'dk')
plot(E2a(2), E2e(2), 'dr')
% оптимальная
plot(Epa, Epe, 'm')
plot(Epa(1), Epe(1), 'dk')
plot(Epa(2), Epe(2), 'dm')
% векторы
plot([0, E1a(1)], [0, E1e(1)], 'b')
plot([0, E2a(1)], [0, E2e(1)], 'r')
plot([E1a(1), E1a(1) + E2a(1)], [E1e(1), E1e(1) + E2e(1)], 'r')
plot([E2a(1), E1a(1) + E2a(1)], [E2e(1), E1e(1) + E2e(1)], 'b')
hold off
axis equal
grid on
