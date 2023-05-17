function diagram = diagram_s( azimuth, elevation )
%DIAGRAM_S парциальная диаграмма второго канала
    % в декартовых координатах
    f2_cartesian = [ ...
            cos(elevation)^2                  * cos(azimuth) * sin(azimuth); ...
            cos(elevation)^2                  * sin(azimuth)^2 - 1; ...
            cos(elevation)   * sin(elevation) * sin(azimuth) ...
        ];
    % орты по углам
    [ ua, ue ] = units(azimuth, elevation);
    % парциальная диаграмма второго канала
    diagram = [ ...
            dot(f2_cartesian, ue);
            dot(f2_cartesian, ua)
        ];

%    diagram = [ cos(elevation); 0 ];
    % нормировка
    diagram = diagram / (4*pi)^0.5;
end