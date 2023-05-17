function norms = diagram_sn( azimuths, elevations )
%DIAGRAM_SN нормы диаграммы второго канала
    norms = zeros( size(azimuths) );
    % вычисляем нормы
    for row = 1 : size(azimuths, 1)
        for column = 1 : size(azimuths, 2)
            norms(row, column) = norm( diagram_s( azimuths(row, column), elevations(row, column) ) );
        end
    end
end

