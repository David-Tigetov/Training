function quadric ( receivers, jammers, mode )
%QUDRIC квадратичная форма

    % ковариационная матрица
    matrix = receivers . covariance ( jammers );
    power = 1;
    if ( strcmp ( mode, "inverse" ) )
        matrix = inv ( matrix );
        power = -1;
    end

    angles = -90 : max ( 0.1, 1 / receivers . count ) : 90;
    form = zeros ( 1, length ( angles ) );
    for number = 1 : length ( angles )
        % вычисляем направление
        Y = receivers . direction ( angles ( number ) );
        % вычисляем квадратичную форму
        form ( number ) = abs ( Y' * matrix * Y )^power;
    end

    figure
    hold on
    % значения квадратичной формы
    plot ( angles, form );
    % направления помех
    for number = 1 : size ( jammers, 1 )
        height = receivers. noise_power * receivers . count + jammers( number, 2 ) * receivers . count^2;
        %plot ( [ jammers( number, 1), jammers( number, 1 ) ], [ 0, height ] )
        plot ( [ jammers( number, 1), jammers( number, 1 ) ] )
    end
    hold off
    grid on
end

