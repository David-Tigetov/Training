function [a, e] = tension( diagram )
%TENSION напряженность
    phases = 0 : pi/20 : 2*pi;

    a = real(diagram(1)*exp(1i*phases));
    e = real(diagram(2)*exp(1i*phases));
end

