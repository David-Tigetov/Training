function H = hermite( size, definition )
%HERMITE формирование эрмитовых матриц

    % формируем произвольную матрицу
    U = rand ( size, size ) + 1i * rand ( size, size );
    % ортогонализируем и нормируем столбцы
    U = orth ( U );

    % формируем собственные числа
    diagonal = ( rand ( 1, size ) - 0.5 ) * 10;
    if ( definition == "positive" )
        diagonal = abs ( diagonal ) + 1;
    end
    % формируем диагональную матрицу
    D = diag ( diagonal );

    % вычисляем эрмитову матрицу
    H = U * D * U';
end