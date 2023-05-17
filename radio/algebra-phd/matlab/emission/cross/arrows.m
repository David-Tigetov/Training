% диаграмма направленности излучателя
azimuths = 0 : pi/6 : 2*pi;
elevations = -pi/2 : pi/10 : pi/2;
radii = [0.1];

% выделяем память
points = zeros( 3, length(radii) * length(elevations) * length(azimuths) );
% вычисляем координаты
number = 1;
for azimuth = azimuths
    for elevation = elevations
        for radius = radii
            points(:, number) = point(azimuth, elevation, radius);
            number = number + 1;
        end
    end
end

% выделяем память
f1 = zeros( 3, length(azimuths) * length(elevations) * length(radii) );
f2 = zeros( 3, length(azimuths) * length(elevations) * length(radii) );
% вычисляем координаты
number = 1;
for azimuth = azimuths
    for elevation = elevations
        % вычисляем орты
        [ ua, ue ] = units(azimuth, elevation);
        % вычисляем диаграмму первого канала
        F = diagram_f(elevation);
        S = diagram_s(azimuth, elevation);
        for radius = radii
            f1(:, number) = [ue, ua] * F / radius;
            f2(:, number) = [ue, ua] * S / radius;
            number = number + 1;
        end
    end
end

figure
hold on
% оси
quiver3(0, 0, 0, max(radii), 0, 0, 'g');
quiver3(0, 0, 0, 0, max(radii), 0, 'g');
quiver3(0, 0, 0, 0, 0, max(radii), 'g');
% строим изображение поля первого канала
quiver3(points(1,:), points(2,:), points(3,:), f1(1,:), f1(2,:), f1(3,:), 'b')
% строим изображение поля второго канала
quiver3(points(1,:), points(2,:), points(3,:), f2(1,:), f2(2,:), f2(3,:), 'r')
hold off
axis equal
