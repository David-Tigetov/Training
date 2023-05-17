Q = zeros(2, 2);

% КПД 1-го канала
Q(1,1) = 2 * pi * integral(@(e) vecnorm(diagram_f(e)).^2 .* cos(e), -pi/2, pi/2);
% КПД 2-го канала
Q(2,2) = integral2(@(a, e) diagram_sn(a, e).^2 .* cos(e), 0, 2*pi, -pi/2, pi/2);
% пересечение каналов
Q(1,2) = integral2(@(a, e) diagram_d(a, e) .* cos(e), 0, 2*pi, -pi/2, pi/2);
Q(2,1) = Q(1,2)';

R_12 = Q(1,2)/(Q(1,1)^0.5 * Q(2,2)^0.5);
% вычисляем ограничение
bound = 1/(1+abs(R_12));