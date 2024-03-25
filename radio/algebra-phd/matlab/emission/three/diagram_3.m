function F = diagram_3 ( azimuth, elevation )
% DIAGRAM_3 третий столбец диаграммы направленности
    F = 0.6 * amplitude(azimuth - pi/6, elevation - pi/4) * [exp(-1i*pi/3); exp(-1i*pi/4)];
end

