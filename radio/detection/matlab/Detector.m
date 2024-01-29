classdef Detector
    %DETECTION квадратичный детектор сигнала
    
    properties ( Access = private )
        % энергетическая характеристика сигнала
        q_
        % количество сигналов
        M_
        % параметр B
        B_
        % плотность вероятности при смеси шума и сигнала
        signal_pdf
        % плотность вероятности при шуме
        noise_pdf

        % функция распределения при смеси шума и сигнала
        signal_cdf
        % функция распределения при шуме
        noise_cdf
    end

    properties ( Dependent )
        q
        M
        B
    end

    methods
        % конструктор
        function detector = Detector ( q, M )
            detector . q_ = q;
            detector . M_ = M;
            detector . B_ = M * q^2/2;

            detector . signal_pdf = @(u) 1/2 * ( u/(2*detector.B_) ).^((detector.M_-1)/2) .* exp(-(detector.B_ + u/2)) .* besseli( detector.M_-1, (2*detector.B_*u).^0.5 );
            detector . noise_pdf = @(u) u.^(detector.M_-1) ./ ( 2^detector.M_ * factorial(detector.M_-1) ) .* exp( -u/2 );

            detector . signal_cdf = @(u) integral( @(x) detector . signal_pdf(x), 0, max(0, u), 'AbsTol', 10^(-15) );
            detector . noise_cdf = @(u) integral( @(x) detector . noise_pdf(x), 0, max(0, u), 'AbsTol', 10^(-15) );
        end

        % вероятность правильного обнаружения
        function probabilities = true_detection_probabilities ( detector, u )
            probabilities = zeros ( 1, length ( u ) );
            for number = 1 : 1 : length ( probabilities )
                probabilities ( number ) = 1 - detector . signal_cdf ( u ( number ) );
            end
        end

        % вероятность ложного обнаружения
        function probabilities = false_detection_probabilities ( detector, u )
            probabilities = zeros ( 1, length ( u ) );
            for number = 1 : 1 : length ( probabilities )
                probabilities ( number ) = 1 - detector . noise_cdf ( u ( number ) );
            end
        end

        % пороги, при которых достигаются условные вероятности правильного обнаружения
        function thresholds = true_detection_thresholds ( detector, probabilities, varargin )
            switch nargin
                case 2
                    thresholds = Detector . thresholds ( probabilities, @(u) detector.true_detection_probabilities( u ) );
                otherwise
                    thresholds = Detector . thresholds ( probabilities, @(u) detector.true_detection_probabilities( u ), varargin{1} );
            end
        end

        % пороги, при которых достигаются условные вероятности ложного обнаружения
        function thresholds = false_detection_thresholds ( detector, probabilities, varargin )
            switch nargin
                case 2
                    thresholds = Detector . thresholds ( probabilities, @(u) detector.false_detection_probabilities( u ) );
                otherwise
                    thresholds = Detector . thresholds ( probabilities, @(u) detector.false_detection_probabilities( u ), varargin{1} );
            end
        end
    end

    methods ( Access = private, Static )
        % пороги, при которых достигаются условные вероятности обнаружения
        function result = thresholds ( probabilities, probability_function, varargin )
            result = zeros ( 1, length ( probabilities ) );

            for number = 1 : length ( probabilities )
                if ( ( 0 < probabilities ( number ) ) && ( probabilities ( number ) < 1 ) )
                    hint = 0;
                    % если есть подсказка для границы отрезка локализации
                    if nargin >= 3
                        if number <= length ( varargin{1} )
                            % используем подсказку
                            hint = varargin{1} ( number );
                        end
                    end

                    % находим отрезок локализации
                    % если вероятность больше требуемой, то нужно двигаться вправо
                    if ( probability_function ( hint ) > probabilities ( number ) )
                        % находим правую границу отрезка локализации
                        step = 10;
                        right = hint + step;
                        while ( probability_function ( right ) > probabilities ( number ) )
                            right = right + step;
                        end
                        % устанавливаем отрезок локализации
                        localization_range = [ right - step , right ];
                    % если вероятность меньше, то нужно двигаться влево
                    else
                        % находим левую границу отрезка локализации
                        step = 10;
                        left = hint - step;
                        while ( ( probability_function ( left ) < probabilities ( number ) ) && ( left > 0 ) )
                            left = left - step;
                        end
                        % устанавливаем отрезок локализации
                        localization_range = [ max( left, 0 ) , left + step ];
                    end

                    % ищем корень
                    result ( number )  = fzero ( @(u) probability_function( u ) - probabilities ( number ), localization_range );
                else
                    if ( 1 <= probabilities ( number ) )
                        result ( number ) = 0;
                    else
                        result ( number ) = inf;
                    end
                end
            end
        end
    end
end