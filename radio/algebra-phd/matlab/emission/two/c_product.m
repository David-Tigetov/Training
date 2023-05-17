function result = c_product ( F1, F2, azimuths, elevations )
%PRODUCT вычисление скалярных произведений, умноженных на косинус угла места
    result = zeros(size(azimuths));

    for row = 1 : size(azimuths, 1)
        for column = 1 : size(azimuths, 2)
            azimuth = azimuths(row, column);
            elevation = elevations(row, column);
            result(row,column) = F1(azimuth, elevation)' * F2(azimuth, elevation) * cos(elevation);
        end
    end
end

