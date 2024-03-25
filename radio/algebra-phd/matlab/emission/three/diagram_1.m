function F = diagram_1 ( azimuth, elevation )
% DIAGRAM_1 первый столбец диаграммы направленности
    F = 0.55 * amplitude(azimuth + pi/6, elevation + pi/4) * [exp(1i*pi/3); exp(1i*pi/4)];
end

