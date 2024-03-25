function G = maximum_gain( azimuth, elevation, diagram )
%MAXIMUM_GAIN Наибольший коэффициент усиления
    % диаграмма в заданном направлении
    F = diagram ( azimuth, elevation );
    % собственные числа и векторы
    [~, D] = eig ( F' * F );
    % наибольший коэффициент усиления
    G = max(diag(abs(D)));
end

