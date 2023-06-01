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

        % комплексный вектор направления
        function vector = directions ( receivers, angles )
            % вычисляем синус угла
            sines = sin ( angles / 180 * pi );
            % вычисляем сдвиг фазы между соседними приёмниками
            phase_shifts = 2 * pi * receivers . distance * sines;
            % вычисляем направление
            vector = exp((0:1:(receivers.count-1)).' * phase_shifts * 1i);
        end

        % ковариационная матрица
        function result = covariance ( receivers, jammers )
            % матрица направлений помех
            directions = receivers . directions ( jammers ( :, 1 )' );
            % ковариационная матрица
            result = ...
                receivers . noise_power * eye ( receivers . count ) ...
                + directions * diag ( jammers ( :, 2 ) ) * directions';
        end
    end
end