function [x, y] = tension( diagram )
%TENSION напряженность
    phases = 0 : pi/20 : 2*pi;

    x = real(diagram(1)*exp(1i*phases));
    y = real(diagram(2)*exp(1i*phases));
end

