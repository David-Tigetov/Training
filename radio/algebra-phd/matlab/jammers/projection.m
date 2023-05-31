function projection(receivers, angle)
% PROJECTION модуль проекции

    % фиксированное направление
    X = receivers.direction(angle);

    % углы
    angles = -90 : 1 : 90;
    % модули проекций
    projections = zeros(1, length(angles));
    for number = 1 : length(angles)
        % вектор направления для текущего значения угла
        Y = receivers.direction(angles(number));
        % модуль проекции
        projections(number) = abs(Y'*X);
    end
    figure
    hold on
    % график модуля проекции
    plot(angles, projections);
    % линия фиксированного угла
    plot([angle angle], [0 receivers.count()], '-r' );
    hold off
    grid on