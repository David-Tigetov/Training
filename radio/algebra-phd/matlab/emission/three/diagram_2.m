function F = diagram_2 ( azimuth, elevation )
% DIAGRAM_2 второй столбец диаграммы направленности
    F = 0.7 * amplitude(azimuth, elevation) * [exp(1i*pi/4); exp(1i*pi/4)];
end