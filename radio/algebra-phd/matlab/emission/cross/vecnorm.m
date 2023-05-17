function norms = vecnorm ( vectors )
%VECNORM нормы столбцов матрицы
    norms = zeros(1, size(vectors, 2));
    for number = 1 : length( norms )
        norms(number) = norm(vectors(:, number));
    end
end

