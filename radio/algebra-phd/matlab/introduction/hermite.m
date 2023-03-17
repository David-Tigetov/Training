function H = hermite( definition )
%HERMITE формирование эрмитовых матриц

    % формируем произвольную матрицу
    U = rand ( 2, 2 );
    % ортогонализуем второй столбец
    U(:,2) = U(:,2) - dot( U(:,1), U(:,2) ) * U(:,1) / norm( U(:,1) )^2;
    % нормируем столбцы
    U(:,1) = U(:,1)/norm(U(:,1));
    U(:,2) = U(:,2)/norm(U(:,2));

    % формируем собственные числа
    diagonal = ( rand ( 1, 2 ) - 0.5 ) * 10;
    if ( definition == "positive" )
        diagonal = abs ( diagonal );
    end
    % формируем диагональную матрицу
    D = diag ( diagonal );

    % вычисляем эрмитову матрицу
    H = U' * D * U;
end