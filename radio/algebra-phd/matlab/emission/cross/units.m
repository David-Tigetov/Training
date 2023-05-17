function [ ua, ue ] = units( azimuth, elevation )
%UNITS орты координатных линий углов

    % орт азимута
    ua = [ ...
            - sin(azimuth); ...
            cos(azimuth); ...
            0 ...
        ];

    % орт угла места
    ue = [ ...
            - sin(elevation) * cos(azimuth); ...
            - sin(elevation) * sin(azimuth); ...
            cos(elevation)
        ];
end