classdef Contours
    %CONTOURS контуры поверхностей условных вероятностей правильного и ложного обнаружений
    
    properties
    end
    
    methods ( Static )
        % изображение контуров
        function draw ( first_detector, second_detector, true_detection_probability, false_detection_probability, varargin )
            % вычисляем точки графика условных вероятностей правильного обнаружения первого детектора
            first_true_probabilities = Contours . plot ( @(u) first_detector . true_detection_probabilities ( u ), 10^(-6) );
            % вычисляем точки графика условных вероятностей ложного обнаружения первого детектора
            first_false_probabilities = Contours . plot ( @(u) first_detector . false_detection_probabilities ( u ), 10^(-6) );

            % вычисляем точки графика условных вероятностей правильного обнаружения первого детектора
            second_true_probabilities = Contours . plot ( @(u) second_detector . true_detection_probabilities ( u ), 10^(-6) );
            % вычисляем точки графика условных вероятностей ложного обнаружения первого детектора
            second_false_probabilities = Contours . plot ( @(u) second_detector . false_detection_probabilities ( u ), 10^(-6) );

            % вычисляем точки кривой условной вероятности правильного обнаружения
            true_detection_curve = Contours . curve ( ...
                    @ ( probabilities ) first_detector . true_detection_thresholds ( probabilities ), ...
                    @ ( threshold ) first_detector . true_detection_probabilities ( threshold ), ...
                    @ ( probabilities, hints ) second_detector . true_detection_thresholds ( probabilities, hints ), ...
                    true_detection_probability ...
                );
            % вычисляем точки кривой условной вероятности ложного обнаружения
            false_detection_curve = Contours . curve ( ...
                    @ ( probabilities) first_detector . false_detection_thresholds ( probabilities ), ...
                    @ ( threshold ) first_detector . false_detection_probabilities ( threshold ), ...
                    @ ( probabilities, hints ) second_detector . false_detection_thresholds ( probabilities, hints ), ...
                    false_detection_probability ...
                );

            figure
            hold on
            % графики условных вероятностей первого обнаружителя
            plot3 ( first_true_probabilities . arguments, zeros ( length ( first_true_probabilities . arguments ) ), first_true_probabilities . values, 'r' );
            plot3 ( first_false_probabilities . arguments, zeros ( length ( first_false_probabilities . arguments ) ), first_false_probabilities . values, 'b' );
            % графики условных вероятностей второго обнаружителя
            plot3 ( zeros ( length ( second_true_probabilities . arguments ) ), second_true_probabilities . arguments, second_true_probabilities . values, 'r' );
            plot3 ( zeros ( length ( second_false_probabilities . arguments ) ), second_false_probabilities . arguments, second_false_probabilities . values, 'b' );
            % график кривой условной вероятности правильного обнаружения
            plot3 ( true_detection_curve . first_thresholds, true_detection_curve . second_thresholds, zeros ( length ( true_detection_curve . first_thresholds ) ), 'r' );
            % график кривой условной вероятности ложного обнаружения
            plot3 ( false_detection_curve . first_thresholds, false_detection_curve . second_thresholds, zeros ( length ( false_detection_curve . first_thresholds ) ), 'b' );
            % если есть пороги
            if ( nargin >= 5 )
                % рисуем точки итерационного процесса поиска порогов
                plot3 ( varargin{1}( :, 1 ), varargin{1}( :, 2 ), zeros ( size ( varargin{1}, 1 ) ), '-+g' );
            end
            hold off
            grid on
        end
    end

    methods ( Access = private, Static )
        % носитель и значения функции
        function result = plot ( probability, tolerance )
            % задаём первый аргумент и вычисляем первое значение
            result . arguments ( 1 ) = 0;
            result . values ( 1 ) = probability ( result . arguments ( 1 ) );

            % задаём остальные аргументы и вычисляем остальные значение пока они больше точности
            while ( result . values ( end ) > tolerance )
                result . arguments ( end + 1 ) = result . arguments ( end ) + 1;
                result . values ( end + 1 ) = probability ( result . arguments ( end ) );
            end
        end

        % контур поверхности на фиксированном уровне
        function result = curve ( first_thresholds, first_probabilities, second_thresholds, probability )
            % определяем наибольшие пороги обнаружителей
            first_maximum_threshold = first_thresholds ( probability );

            % формируем значения порога первого обнаружителя
            result . first_thresholds = [ 0 : 0.01 : first_maximum_threshold , first_maximum_threshold ];
            % выделяем память для значений порога второго обнаружителя
            result . second_thresholds = zeros ( 1, length ( result . first_thresholds ) );
            % вычисляем значения порога второго обнаружителя
            for number = 1 : 1 : length ( result . first_thresholds )
                if number == 1
                    second_threshold_hint = 0;
                else
                    second_threshold_hint = result . second_thresholds ( number - 1 );
                end

                % вычисляем значение второго порога
                result . second_thresholds ( number ) = second_thresholds ( probability / first_probabilities ( result . first_thresholds ( number ) ), second_threshold_hint );
            end
        end
    end
end