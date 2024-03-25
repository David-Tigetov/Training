function plot_surface( value_function, heading )
%PLOT_SURFACE отображение поверхности
    % азимуты и углы места
    [ azimuths, elevations ] = meshgrid( -pi : pi/50: pi, -pi/2 : pi/50 : pi/2 );

    values = zeros ( size ( azimuths ) );
    % вычисляем значения
    for row = 1 : size ( azimuths, 1 )
        for column = 1 : size ( azimuths, 2 )
            % азимут и угол места
            azimuth = azimuths(row, column);
            elevation = elevations(row, column);
            % вычисляем величину
            values(row, column) = value_function(azimuth, elevation);
        end
    end
    
    figure
    % строим поверхность
    surf ( azimuths, elevations, values );
    title(heading)
    xlabel('Azimuth');
    xticks([-1, -1/2, -1/3, -1/4, -1/6, 0, 1/6, 1/4, 1/3, 1/2, 1]*pi);
    xticklabels({'-pi', '-pi/2', '-pi/3', '-pi/4', '-pi/6', '0', 'pi/6', 'pi/4', 'pi/3', 'pi/2', 'pi'});
    ylabel('Elevation');
    yticks([-1/2, -1/3, -1/4, -1/6, 0, 1/6, 1/4, 1/3, 1/2]*pi);
    yticklabels({'-pi/2', '-pi/3', '-pi/4', '-pi/6', '0', 'pi/6', 'pi/4', 'pi/3', 'pi/2'});
end

