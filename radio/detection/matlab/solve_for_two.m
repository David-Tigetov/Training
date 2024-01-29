function [ optimal, varargout ] = solve_for_two( ...
    q, ...
    required_true_detection_probability, ...
    required_false_detection_probability, ...
    maximum_signals_count, ...
    target_probability, ...
    tolerance...
    )
%SOLVE_FOR_TWO поиск двух-этапного обнаружителя

    % инициализируем решение
    optimal = struct ( ...
            'first_count', double . empty ( ), ...
            'second_count', double . empty ( ), ...
            'thresholds', double . empty ( 0, 2 ), ...
            'mean_count', double . empty ( ), ...
            'first_true_detection_probability', double . empty ( ), ...
            'first_false_detection_probability', double . empty ( ) ...
        );

    % инициализируем набор вариантов
    solutions ( 1 ) = optimal;
    solutions ( 1 ) = [ ];

    % инициализируем пределы количеств сигналов
    first_maximum_count = maximum_signals_count;
    second_maximum_count = maximum_signals_count;

    for first_count = 1 : 1 : first_maximum_count
        % формируем первый обнаружитель
        first_detector = Detector ( q, first_count );

        % находим значение порога первого обнаружителя, соответствующее вероятности правильного обнаружения
        first_true_threshold_maximum = first_detector . true_detection_thresholds ( required_true_detection_probability );

        % если при этом пороге вероятность ложного обнаружения больше требуемой
        % (требуется подбор второго обнаружителя)
        if ( required_false_detection_probability < first_detector . false_detection_probabilities ( first_true_threshold_maximum ) )
            % придётся подбирать второй обнаружитель
            for second_count = 1 : 1 : second_maximum_count
                % формируем второй обнаружитель
                second_detector = Detector( q, second_count );

                % находим значение порога второго обнаружителя, соответствующее вероятности правильного обнаружения
                second_true_threshold_maximum = second_detector . true_detection_thresholds ( required_true_detection_probability );
                % вычисляем значение порога второго по вероятности ложного обнаружения и порогу первого обнаружителя
                second_false_threshold = second_detector . false_detection_thresholds ( ...
                        required_false_detection_probability / first_detector . false_detection_probabilities ( first_true_threshold_maximum ), ...
                        second_true_threshold_maximum ...
                    );

                % если есть пересечение кривых
                if ( second_false_threshold <= second_true_threshold_maximum )
                    % иницилазируем первую и вторую точки на плоскости двух порогов
                    thresholds = [ ...
                            first_true_threshold_maximum , 0 ; ...
                            first_true_threshold_maximum , second_false_threshold ...
                        ];
                    % был шаг в направлении второго порога
                    previous_direction = 2;

                    out_of_bounds = false;
                    % пока шаг изменения порогов больше точности и не вышли за допустимые границы
                    while ( ( abs ( thresholds ( end, previous_direction ) - thresholds ( end-1, previous_direction ) ) > tolerance ) && ~out_of_bounds  )
                        switch previous_direction
                            % был шаг по порогу первого обнаружителя
                            case 1
                                % вычисляем следующий порог второго обнаружителя
                                next_threshold = second_detector . false_detection_thresholds ( ...
                                        required_false_detection_probability / first_detector . false_detection_probabilities ( thresholds ( end, 1 ) ), ...
                                        thresholds ( 2 ) ...
                                    );
                                % устанавливаем следующий порог
                                thresholds ( end + 1, 1 : 2 ) = [ thresholds( end, 1 ) , next_threshold ];
                                % устанавливаем направление, в котором делали шаг
                                previous_direction = 2;

                            % был шаг по порогу второго обнаружителя
                            case 2
                                % вычисляем следующий порог первого обнаружителя
                                next_threshold = first_detector . true_detection_thresholds ( ...
                                        required_true_detection_probability / second_detector . true_detection_probabilities ( thresholds ( end, 2 ) ), ...
                                        thresholds ( 1 ) ...
                                    );
                                % устанавливаем следующий порог
                                thresholds ( end + 1, 1 : 2 ) = [ next_threshold , thresholds( end, 2 ) ];
                                % устанавливаем направление, в котором делали шаг
                                previous_direction = 1;
                        end

                        % проверяем выход на допустимые границы порогов, устанавливаемые условной вероятностью правильного обнаружения
                        if ( ( first_true_threshold_maximum < thresholds ( end, 1 ) ) || ( second_true_threshold_maximum < thresholds ( end, 2 ) ) )
                            out_of_bounds = true;
                        end
                    end

                    % если не было выхода за границы
                    if ~out_of_bounds
                        % найдена точка пересечения кривых
                        % заполняем количества
                        solutions ( end + 1 ) . first_count = first_count;
                        solutions ( end ) . second_count = second_count;
                        % сохраняем итерационные значения порогов
                        solutions ( end ) . thresholds = thresholds;
                        % вычисляем средние количество сигналов
                        solutions ( end ) . mean_count = ...
                            solutions ( end ) . first_count ...
                            + ( ...
                                target_probability * first_detector . true_detection_probabilities ( solutions ( end ) . thresholds ( end, 1 ) ) ...
                                + ( 1 - target_probability ) * first_detector . false_detection_probabilities ( solutions ( end ) . thresholds ( end, 1 ) ) ...
                            ) * solutions ( end ) . second_count;
                        % вычисляем условные вероятности правильного и ложного обнаружений первого обнаружителя
                        solutions ( end ) . first_true_detection_probability = first_detector . true_detection_probabilities ( solutions ( end ) . thresholds ( end, 1 ) );
                        solutions ( end ) . first_false_detection_probability = first_detector . false_detection_probabilities ( solutions ( end ) . thresholds ( end, 1 ) );
                    end
                end
            end
        else
            % у второго обнаружителя значение порога нулевое - второй обнаружитель вовсе не нужен
            solutions ( end + 1 ) . first_count = first_count;
            solutions ( end ) . second_count = 0;
            solutions ( end ) . thresholds = [ first_true_threshold_maximum , 0 ];
            solutions ( end ) . mean_count = first_count;
            % вычисляем условные вероятности правильного и ложного обнаружений первого обнаружителя
            solutions ( end ) . first_true_detection_probability = first_detector . true_detection_probabilities ( solutions ( end ) . thresholds ( end, 1 ) );
            solutions ( end ) . first_false_detection_probability = first_detector . false_detection_probabilities ( solutions ( end ) . thresholds ( end, 1 ) );
        end
    end

    % есть есть решения
    if ( ~ isempty ( solutions ) )
        % находим вариант с наименьшим средним количеством сигналов
        [ ~, index_of_minimum ] = min ( [ solutions . mean_count ] );
        % сохраняем оптимальное решение
        optimal = solutions ( index_of_minimum );
    end

    % если требуется сохранить все найденные варианты
    if ( nargout >= 2 )
        varargout{1} = solutions;
    end
end

