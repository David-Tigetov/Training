function [e, a] = tension( diagram )
%TENSION напряженность
    phases = 0 : pi/20 : 2*pi;

    e = real(diagram(1)*exp(1i*phases));
    a = real(diagram(2)*exp(1i*phases));
end

