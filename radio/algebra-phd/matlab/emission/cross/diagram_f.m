function diagram = diagram_f( ~, elevation )
%DIAGRAM_F парциальная диаграмма первого канала
    diagram = 0.25 * [ cos(elevation); 0 ];
end