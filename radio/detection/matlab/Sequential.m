classdef Sequential
    %SEQUENTIAL характеристики последовательного критерия
    
    properties
        % вероятности ошибок
        probabilities
        % пороги последовательного критерия
        thresholds
        % средние значения слагаемого
        summands_means
        % средние значения количества наблюдений
        observations_means
    end
    
    methods
        % конструктор
        function sequential = Sequential ( q, true_detection_probability, false_detection_probability )
            % вероятности ошибок первого и второго родов
            sequential . probabilities . alpha = false_detection_probability;
            sequential . probabilities . beta = 1 - true_detection_probability;

            % пороги последовательного критерия
            sequential . thresholds . lnA = log ( sequential.probabilities.beta / ( 1 - sequential.probabilities.alpha ) );
            sequential . thresholds . lnB = log ( ( 1 - sequential.probabilities.beta ) / sequential.probabilities.alpha );

            % плотность вероятности в случае шума
            noise_pdf = @(u) u .* exp ( - u.^2 / 2 );
            % плотность вероятности в случае смеси шума и помехи
            signal_pdf = @(u) u .* exp ( - ( u.^2 + q^2 ) / 2 ) .* besseli ( 0, u * q );

            % вычисляем средние значения слагаемых
            sequential . summands_means = - q^2/2 + [ ...
                    integral( @(u) log( besseli(0, q*u) ) .* noise_pdf( u ), 0, 10, 'AbsTol', 10^(-15) ) , ...
                    integral( @(u) log( besseli(0, q*u) ) .* signal_pdf( u ), 0, 10, 'AbsTol', 10^(-15) ) ...
                ];

            % вычисляем средние количества наблюдений
            sequential . observations_means = ...
                [ ...
                    sequential.thresholds.lnA * ( 1 - sequential.probabilities.alpha ) + sequential.thresholds.lnB * sequential.probabilities.alpha, ...
                    sequential.thresholds.lnA * sequential.probabilities.beta + sequential.thresholds.lnB * ( 1 - sequential.probabilities.beta ) ...
                ] ...
                ./ sequential . summands_means;
        end
    end
end