function quadric ( receivers, jammers, volume, mode, power )
%QUADRIC квадратичная форма
%   receivers - набор приёмников
%   jammers - источники излучения (матрица)
%       [ угол направления источника 1 в градусах, мощность источника 1 ]
%       ...
%       [ угол направления источника M в градусах, мощность источника M ]
%   volume - объём выборки при оценке ковариационной матрицы
%       если volume = 0, то используется точная ковариационная матрица
%   mode - режим
%       "direct" - прямая матрица
%       не "direct" - обратная матрица
%   power - степень, в которую возводится квадратичная форма

    if volume == 0
        % точная ковариационная матрица
        matrix = receivers . covariance ( jammers );
    else
        % выборочная ковариационная матрица
        sample = receivers . sampling ( jammers, volume );
        matrix = sample * sample' / volume;
    end
    
    if ( strcmp ( mode, "inverse" ) )
        matrix = inv ( matrix );
    end

    angles = -90 : 0.01 : 90;
    % вычисляем квадратичные формы
    forms = quadric_ ( receivers, angles, matrix, power );

    % вычисляем квадратичные формы в направлении источников
    jammers_forms = quadric_ ( receivers, jammers ( :, 1 ), matrix, power );
    
    figure
    hold on
    % значения квадратичной формы
    plot ( angles, forms, 'b' );
    % направления помех
    for number = 1 : size ( jammers, 1 )
        plot ( [ jammers( number, 1 ), jammers( number, 1 ) ], [ 0, jammers_forms( number ) ], 'r' )
    end
    hold off
    grid on
end

function forms = quadric_ ( receivers, angles, matrix, power )
% QUADRIC_ вычисление квадратичной формы
    % вычисляем квадратичную форму в направлении источников
    forms = zeros ( 1, length ( angles ) );
    for number = 1 : length ( angles )
        % вычисляем направление
        Y = receivers . directions ( angles ( number ) );
        % вычисляем квадратичную форму
        forms ( number ) = abs ( Y' * matrix * Y )^power;
    end
end