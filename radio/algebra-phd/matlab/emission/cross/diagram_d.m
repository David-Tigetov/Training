function dots = diagram_d( azimuths, elevations )
%DIAGRAM_FS скалярное произведение диаграм
    dots = zeros( size(azimuths) );
    % вычисляем произведения
    for row = 1 : size(azimuths, 1)
        for column = 1 : size(azimuths, 2)
            dots(row, column) = ...
                dot( ...
                        diagram_f( elevations(row, column) ), ...
                        diagram_s( azimuths(row, column), elevations(row, column) ) ...
                    );
        end
    end
end

