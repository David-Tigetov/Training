function bearings = detection ( receivers, jammers, volume )
% DETECTION обнаружение и пеленгация по собственным числами и векторам
%   receivers - набор приёмников
%   jammers - источники излучения (матрица)
%       [ угол направления источника 1 в градусах, мощность источника 1 ]
%       ...
%       [ угол направления источника M в градусах, мощность источника M ]
%   volume - объём выборки при оценке ковариационной матрицы
%       если volume = 0, то используется точная ковариационная матрица

    if volume == 0
        % ковариационная матрица
        covariance = receivers . covariance ( jammers );
    else
        sample = receivers . sampling ( jammers, volume );
        covariance = sample * sample' / volume;
    end        

    % спектральное разложение ковариационной матрицы
    [eigenvectors, eigennumbers] = eig ( covariance );

    bearings = double.empty();
    % анализируем все собственные векторы
    for number = 1 : length ( eigennumbers )
        % если собственное значение соответствует направлению на источник
        if ( abs ( eigennumbers ( number, number ) ) > 1.1 * receivers . noise_power ( ) )
            % определяем сдвиг фазы между соседними приёмниками
            phase_shift = angle ( eigenvectors ( 2, number ) / eigenvectors ( 1, number ) );
            % вычисляем синус угла
            sine = phase_shift / ( 2 * pi ) / receivers . distance ( );
            % вычисляем угол в градусах
            if isempty ( bearings )
                bearings ( 1 ) = rad2deg ( asin ( sine ) );
            else
                bearings ( end + 1 ) = rad2deg ( asin ( sine ) );
            end
        end
    end
