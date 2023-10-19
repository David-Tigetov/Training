classdef Receivers
    %RECEIVERS Приёмники
    
    properties ( Access = private )
        % количество приёмников
        count_
        % расстояние между соседними приёмниками (в длинах волны)
        distance_
        % мощность собственных шумов
        noise_power_        
    end

    properties ( Dependent )
        % количество приёмников
        count
        % расстояние между соседними приёмниками (в длинах волны)
        distance
        % мощность собственных шумов
        noise_power
    end
    
    methods
        % конструктор
        function receivers = Receivers ( count, distance, noise_power )
            if ( count <= 0 )
                error ( 'Receivers: non-positive receivers count.' );
            end
            
            if ( distance <= 0 )
                error ( 'Receivers: non-positive distance.' );
            end
                    
            if ( noise_power <= 0 )
                error ( 'Receivers: non-positive noise power' );
            end
        
            receivers . count_ = count;
            receivers . distance_ = distance;
            receivers . noise_power_ = noise_power;
        end

        % получение количества приёмников
        function result = get . count ( receivers )
            result = receivers . count_;
        end
        
        % получение расстояния между соседними приёмниками (в длинах волны)
        function result = get . distance ( receivers )
            result = receivers . distance_;
        end
            
        % получение мощности собственных шумов
        function result = get . noise_power ( receivers )
            result = receivers . noise_power_;
        end

        % векторы направлений
        function vectors = directions ( receivers, angles )
            % вычисляем синус угла
            sines = sin ( angles / 180 * pi );
            % вычисляем сдвиг фазы между соседними приёмниками
            phase_shifts = 2 * pi * receivers . distance * sines;
            % вычисляем направление
            vectors = exp((0:1:(receivers.count-1)).' * phase_shifts * 1i);
        end

        % ковариационная матрица шумов и источников излучения
        function result = covariance ( receivers, jammers )
            % инициализируем дисперсиями шумов
            result = receivers . noise_power * eye ( receivers . count );

            % если есть источники излучения
            if size ( jammers, 1 ) > 0 
                % матрица направлений помех
                directions = receivers . directions ( jammers ( :, 1 )' );
                % добавляем дисперсии помех
                result = result + directions * diag ( jammers ( :, 2 ) ) * directions';
            end
        end

        % выборка комплексных огибающих
        function result = sampling ( receivers, jammers, volume )
            % инициализируем шумовыми огибающими
            result = ( randn ( receivers . count_, volume ) + 1i * randn ( receivers . count_, volume ) ) * ( 0.5 * receivers . noise_power_ )^0.5;

            % добавляем огибающие источников излучения
            for number = 1 : size ( jammers, 1 )
                % вектор направления
                direction = receivers . directions ( jammers ( number, 1 ) );
                % случайные огибающие с мощностью источника излучения
                signals = ( randn ( 1, volume ) + 1i * randn ( 1, volume ) ) * ( 0.5 * jammers ( number, 2 ) )^0.5;
                % добавляем внешнее произведение
                result = result +  direction * signals;
            end
        end
    end
end