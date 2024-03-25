% коэффициент усиления для двух излучателей
% парциальная диаграмма направленности первого излучателя
F1 = @(a, e) [ 0.1*exp(1i*pi/6) * cos(e) ; 0.2*exp(1i*pi/3) * sin(a) ];
% парциальная диаграмма направленности второго излучателя
F2 = @(a, e) [ 0.3*exp(1i*5*pi/4) * cos(e) ; 0.1*exp(-1i*pi/10) * sin(a) ];

% вычисляем матрицу Q
Q = zeros(2, 2);
% вычисляем КПД первого излучателя
Q(1,1) = integral2(@(a, e) cosine_product(F1, F1, a, e), 0, 2*pi, -pi/2, pi/2 );
% вычисляем коэффициент пересечения диаграмм
Q(1,2) = integral2(@(a, e) cosine_product(F1, F2, a, e), 0, 2*pi, -pi/2, pi/2 );
Q(2,1) = Q(1,2)';
% вычисляем КПД второго излучателя
Q(2,2) = integral2(@(a, e) cosine_product(F2, F2, a, e), 0, 2*pi, -pi/2, pi/2 );

% нормированный коэффициент пересечения диаграмм
R_12 = Q(1,2)/(Q(1,1)^0.5 * Q(2,2)^0.5);
% вычисляем ограничение
bound = 1/(1+abs(R_12));

% границы КПД и оптимальные огибающие
[V, D] = eig(Q);

% функция напряженности
E = @(a, e) F1(a,e)*V(1,1) + F2(a,e)*V(2,1);
% излучаемая мощность (КПД)
Pr1 = integral2(@(a, e) cosine_product(E, E, a, e), 0, 2*pi, -pi/2, pi/2);

% функция напряженности (КПД)
E = @(a, e) F1(a,e)*V(1,2) + F2(a,e)*V(2,2);
% излучаемая мощность
Pr2 = integral2(@(a, e) cosine_product(E, E, a, e), 0, 2*pi, -pi/2, pi/2);