function R = rayleigh( A, B )
%RAYLEIGH вычисление отношения Релея

    % аргументы на окружности
    X = circle;

    % значения квадратичной формы A
    QA = quadric ( X, A );
    % значения квадратичной формы B
    QB = quadric ( X, B );
    % отношение Релея
    R = QA ./ QB;

    figure
    % рисунок квадратичной формы A
    axes = subplot ( 1, 3, 1 );
    draw ( axes, X, QA );
    title ( axes, 'A' );
    % рисунок квадратичной формы B
    axes = subplot ( 1, 3, 2 );
    draw ( axes, X, QB );
    title ( axes, 'B' );
    % рисунок отношения Релея
    axes = subplot ( 1, 3, 3 );
    draw ( axes, X, R );
    title ( axes, 'R' );
end