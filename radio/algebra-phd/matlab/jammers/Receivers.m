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
        function vector = direction ( receivers, angle )
            % вычисляем синус угла
            sine = sin ( angle / 180 * pi );
            % вычисляем сдвиг фазы между соседними приёмниками
            phase_shift = - 2 * pi * receivers . distance * sine;
            % вычисляем направление
            vector = exp((0:1:(receivers.count-1)).' * phase_shift * 1i);
        end
    end
end