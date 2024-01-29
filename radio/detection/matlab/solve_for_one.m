function [ solution ] = solve_for_one (...
    q, ...
    required_true_detection_probability, ...
    required_false_detection_probability, ...
    maximum_signals_count ...
    )
%SOLVE_FOR_ONE поиск одноэтапного обнаружителя

    solution = struct ( ...
            'count', double . empty ( ), ...
            'threshold', double . empty ( ), ...
            'true_detection_probability', double . empty ( ), ...
            'false_detection_probability', double . empty ( ) ...
        );

    count = 1;
    not_found = true;
    while ( ( count <= maximum_signals_count ) && not_found )
        % формируем обнаружитель
        detector = Detector ( q, count );

        % вычисляем порог по вероятности правильного обнаружения
        threshold = detector . true_detection_thresholds ( required_true_detection_probability );
        % вычисляем вероятность ложного обнаружения
        false_detection_probability = detector . false_detection_probabilities ( threshold );
        if ( false_detection_probability <= required_false_detection_probability )
            solution . count = count;
            solution . threshold = threshold;
            solution . true_detection_probability = detector . true_detection_probabilities ( threshold );
            solution . false_detection_probability = false_detection_probability;

            not_found = false;
        else
            count = count + 1;
        end
    end
end