function A = amplitude ( azimuth, elevation )
% AMPLITUDE амплитуда

    % амплитуда
    A = cos(1.5*azimuth) * cos(2*elevation) ...
        * (-pi/3 <= azimuth) * (azimuth <= pi/3 ) ...
        * (-pi/4 <= elevation ) * (elevation <= pi/4 );
end

