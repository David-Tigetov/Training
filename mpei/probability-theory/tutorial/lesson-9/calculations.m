% функция распределения к задаче 1
points = [
        1 1 1/9;
        1 2 1/9;
        1 3 1/9;
        2 2 1/6;
        2 3 1/6;
        3 3 1/3;
    ];
X = [ -1 1 1.0001 2 2.0001 3 3.0001 5 ];
Y = [ -1 1 1.0001 2 2.0001 3 3.0001 5 ];
F ( 1 : length ( Y ), 1 : length ( X ) ) = 0;
for x_number = 1 : length ( X )
    for y_number = 1 : length ( Y )
        for row = 1 : size( points, 1 )
            if ( ( points ( row, 1 ) < X ( x_number ) ) && ( points ( row, 2 ) < Y ( y_number ) ) )
                F ( y_number, x_number ) = F ( y_number, x_number ) + points ( row, 3 );
            end
        end
    end
end

figure
hold on
surf(X, Y, F);
xlabel('X');
ylabel('Y');
hold off