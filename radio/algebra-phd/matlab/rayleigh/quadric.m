function Q = quadric ( X, M )
%QUADRIC вычисление квадратичной формы

    % вычисляем значения квадратичной формы
    Q = zeros ( 1, size ( X, 2 ) );
    for number = 1 : length ( Q )
        Q ( number ) = X ( :, number )' * M * X ( :, number );
    end
end