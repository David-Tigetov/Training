% ЗАДАНИЕ 1
diagrams = {@diagram_1, @diagram_2, @diagram_3, @diagram};
for number = 1 : length(diagrams)
    % поверхность наибольшего коэффициента усиления
    plot_surface( ...
        @(azimuth, elevation) maximum_gain(azimuth, elevation, @diagram), ...
        ['Gain ', num2str(number)]);
end

% ЗАДАНИЕ 2
Q = zeros(3,3);
diagrams = {@diagram_1, @diagram_2, @diagram_3};
for row = 1 : 3
    for column = row : 3
        Q(row, column) = integral2(@(azimuths, elevations) cosine_product(azimuths, elevations, diagrams{row}, diagrams{column}), -pi, pi, -pi/2, pi/2);
        Q(column, row) = Q(row, column)';
    end
end

% ЗАДАНИЕ 3
% собственные числа и векторы
[V, D] = eig(Q);
% индекс наибольшего собственного значения
[maximum_efficiency, maximum_index] = max(abs(diag(D)));
% поверхность мощности излучения
plot_surface(@(azimuth, elevation) power(azimuth, elevation, @diagram, V(:,maximum_index)), 'Maximum efficiency power');

% ЗАДАНИЕ 4
% фиксированное направление
fixed_azimuth = pi/12;
fixed_elevation = -pi/6;
% диаграмма в фиксированном направлении
F = diagram(fixed_azimuth, fixed_elevation);
% собственные числа и векторы
[V, D] = eig(F'*F);
% индекс наибольшего собственного числа
[~, maximum_index] = max(abs(diag(D)));
% коэффициент полезного действия
maximum_gain_efficiency = norm(Q*V(:,maximum_index))^2;
% поверхность мощности излучения
plot_surface(@(azimuth, elevation) power(azimuth, elevation, @diagram, V(:,maximum_index)), 'Maximum gain power');

clear diagrams number
clear row column
clear F
clear V D maximum_index
clear fixed_azimuth fixed_elevation