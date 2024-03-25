function P = cosine_product( azimuths, elevations, F, S )
%COSINE_PRODUCT скалярное произведение с косинусом
    P = zeros ( size ( azimuths ) );

    for row = 1 : size ( azimuths, 1 )
        for column = 1 : size ( azimuths, 2 )
            azimuth = azimuths(row, column);
            elevation = elevations(row, column);

            P(row, column) = F(azimuth, elevation)' * S(azimuth, elevation) * cos(elevation);
        end
    end
end

