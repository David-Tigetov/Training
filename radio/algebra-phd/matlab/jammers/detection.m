% приёмники
receivers = Receivers ( 5, 0.5, 1 );

% углы источников
jammers . angles = [ 15 -30 ];
% мощность источников
jammers . power = [ 4 7 ];
% количество источников
jammers . count = length ( jammers . angles );

% направления источников
jammers . directions = zeros ( receivers . count, jammers . count );
for jammer = 1 : 1 : jammers . count
    % вычисляем направление
    jammers. directions ( :, jammer ) = receivers . direction ( jammers . angles ( jammer ) );
end

% ковариационная матрица
jammers . covariance = receivers . noise_power * eye ( receivers . count ) + jammers . directions * diag ( jammers . power ) * jammers . directions';

% спектральное разложение ковариационной матрицы
[eigenvectors, eigennumbers] = eig ( jammers . covariance );

% вычисляем разложение направлений по собственным векторам
coefficients = eigenvectors\jammers.directions;

count = 5;
phases = -pi: 0.01 : pi;
a_norms = zeros ( length ( phases ), 1 );
b_norms = zeros ( length ( phases ), 1 );
a_denominator = zeros ( length ( phases ), 1 );
for number = 1 : length ( phases )
    phase = phases ( number );
    phases_shifts = [ pi/6 - phase, pi/6 + 0.1 - phase ];

    if ( phase ~= 0 )
        a_norms ( number ) = abs ( ( 1 - exp(1i * count * phases_shifts(1) ) ) / ( 1 - exp(1i * phases_shifts(1) ) ) )^2;
    else
        a_norms ( number ) = 16;
    end

    if ( abs ( 1 - exp ( 1i * phases_shifts(1) ) ) > 0.5 )
        a_denominator ( number ) = 1 / abs ( 1 - exp ( 1i * phases_shifts(1) ) )^4;
    else
        a_denominator ( number ) = 0;
    end

    if ( phase ~= 0 )
        b_norms ( number ) = abs ( ( 1 - exp(1i * count * phases_shifts(2) ) ) / ( 1 - exp(1i * phases_shifts(2) ) ) )^2;
    else
        b_norms ( number ) = 16;
    end
end
%figure
%polarplot ( phases, a_norms, phases, a_norms )
figure
plot ( phases, a_norms, phases, a_denominator );
figure
plot ( phases, a_norms, phases, b_norms, phases, a_norms + b_norms );