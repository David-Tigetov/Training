% парциальная диаграмма первого канала
F1 = @(a, e) diagram_f(a, e);
F2 = @(a, e) diagram_s(a, e);

Q = zeros(2, 2);
% КПД 1-го канала
Q(1,1) = integral2(@(a, e) cosine_product(F1, F1, a, e), 0, 2*pi, -pi/2, pi/2);
% пересечение каналов
Q(1,2) = integral2(@(a, e) cosine_product(F1, F2, a, e), 0, 2*pi, -pi/2, pi/2);
Q(2,1) = Q(1,2)';
% КПД 2-го канала
Q(2,2) = integral2(@(a, e) cosine_product(F2, F2, a, e), 0, 2*pi, -pi/2, pi/2);

R_12 = Q(1,2)/(Q(1,1)^0.5 * Q(2,2)^0.5);
% вычисляем ограничение
bound = 1/(1+abs(R_12));