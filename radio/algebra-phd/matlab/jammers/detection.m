% приёмники
receivers = Receivers ( 5, 0.5, 1 );

% углы и мощности источников
jammers = [ 15 4 ];
% jammers = [ 15 4; -30 7 ];

% ковариационная матрица
covariance = receivers . covariance ( jammers );

% спектральное разложение ковариационной матрицы
[eigenvectors, eigennumbers] = eig ( covariance );

bearings = zeros ( 1, length ( eigennumbers ) );
% анализируем все собственные векторы
for number = 1 : length ( eigennumbers )
    % если собственное значение соответствует направлению на источник
    if ( abs ( eigennumbers ( number, number ) ) > receivers . noise_power ( ) + 0.1 )
        % определяем сдвиг фазы между соседними приёмниками
        phase_shift = angle ( eigenvectors ( 2, number ) / eigenvectors ( 1, number ) );
        % вычисляем синус угла
        sine = phase_shift / ( 2 * pi ) / receivers . distance ( );
        % вычисляем угол в градусах
        bearings ( number ) = rad2deg ( asin ( sine ) );
    end
end
clear number phase_shift sine