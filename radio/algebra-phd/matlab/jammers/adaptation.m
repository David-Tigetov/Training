function  adaptation( receivers, jammers, volume, echo )
%ADAPTATION адаптация
%   receivers - набор приёмников
%   jammers - источники излучения (матрица)
%       [ угол направления источника 1 в градусах, мощность источника 1 ]
%       ...
%       [ угол направления источника M в градусах, мощность источника M ]
%   volume - объём выборки при оценке ковариационной матрицы
%       если volume = 0, то используется точная ковариационная матрица
%   echo - угол эхо-сигнала в градусах

    if volume == 0
        covariance = receivers . covariance ( jammers );
    else
        sample = receivers . sampling ( jammers, volume );
        covariance = sample * sample' / volume;
    end
    % оптимальный весовой вектор
    weights = covariance \ receivers . directions ( echo );

    angles = -90 : 0.01 : 90;
    % мощности с разных направлений
    projections = abs ( weights' * receivers . directions ( angles ) ).^2;

    % мощность в направлении полезного сигнала
    echo_projection = abs ( weights' * receivers . directions ( echo ) ).^2;

    figure
    hold on
    % проекции в направлениях
    plot ( angles, projections, 'b' );
    % проекции в направлении источников излучения
    for number = 1 : size ( jammers, 1 )
        plot ( jammers( number, 1 ), 0, '*r' );
    end
    % проекция в направлении полезного сигнала
    plot ( [ echo, echo ], [ 0, echo_projection ], 'm' )
    hold off
    grid on
end