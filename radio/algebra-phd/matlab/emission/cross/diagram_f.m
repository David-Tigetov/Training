function diagram = diagram_f( elevations )
%DIAGRAM_F парциальная диаграмма первого канала
    diagram = [ ...
            cos(elevations); ...
            zeros(1, length(elevations)) ...
        ];
    % нормировка
    diagram = diagram / (4*pi)^0.5;    
end

