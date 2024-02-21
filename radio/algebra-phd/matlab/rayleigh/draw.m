function draw ( axes, path, curve )
%DRAW изображение кривой

    % находим индексы минимального и максимального значения на кривой
    [ ~, minimum ] = min ( curve );
    [ ~, maximum ] = max ( curve );

    hold on

    % путь
    plot3 ( axes, path ( 1, : ), path ( 2, : ), zeros ( 1, size ( path, 2 ) ), 'b' );
    % кривая
    plot3 ( axes, path ( 1, : ), path ( 2, : ), curve, 'r' );

    % точка мимимума
    plot3 ( axes, [ -path( 1, minimum ), path( 1, minimum ) ], [ -path( 2, minimum ), path( 2, minimum ) ], [ 0, 0 ], 'm' );
    % точка максимума
    plot3 ( axes, [ -path( 1, maximum ), path( 1, maximum ) ], [ -path( 2, maximum ), path( 2, maximum ) ], [ 0, 0 ], 'c' );

    hold off
    grid on
end