function result = point( azimuth, elevation, radius )
%POINT координаты точки
    result = radius * [ ...
                cos(elevation) * cos(azimuth); ...
                cos(elevation) * sin(azimuth); ...
                sin(elevation); ...
            ];
end