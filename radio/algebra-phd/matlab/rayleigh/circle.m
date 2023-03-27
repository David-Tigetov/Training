function X = circle
%CIRCLE координаты окружности

    % угол
    phi = [ 0:0.1:2*pi, 2*pi ];
    % координаты
    X = [
        cos( phi ) ;
        sin( phi )
    ];
end

