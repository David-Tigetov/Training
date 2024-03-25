function P = power ( azimuth, elevation, diagram, input )
%POWER мощность излучения
    % напряжённость
    E = diagram(azimuth, elevation) * input;
    % мощность
    P = norm(E)^2;
end