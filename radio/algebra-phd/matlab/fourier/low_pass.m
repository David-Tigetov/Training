volume = 100;
times = 0:1:volume-1;
frequencies = 0:1:volume-1;

% частота среза
cut = 3;
% спектр импульсной характеристики
H = zeros(1, volume);
% оставляем постоянную
H(1) = 1;
% оставляем первые три гармоники
H(2:cut+1) = 1;
H(volume-cut+1:volume) = 1;
% импульсная характеристика
h = ifft(H);
% рисунок
figure
% спектр
subplot(2,1,1)
stem(frequencies, H);
ylim([0 2])
grid on
title('H')
% импульсная характеристика
subplot(2,1,2)
stem(frequencies, h);
grid on
title('h');

% ВХОДНОЙ СИГНАЛ
% амплитуды
x_a = [1 -0.5 0.4 0.9 0.15 0.1 0.25 0.3];
% частоты
x_f = [0 1 2 3 33 34 35 36];
% сигнал
x = zeros(1,volume);
for k = 1:length(x_f)
    x = x + x_a(k)*cos(x_f(k)*2*pi/volume*times);
end
% спектр
X = abs(fft(x));
% рисунок
figure
% спектр
subplot(2,1,1)
stem(frequencies,X);
grid on
title('X');
% сигнал
subplot(2,1,2)
plot(times,x);
grid on
title('x');

% ПРЕОБРАЗОВАНИЕ
% циклическая свёртка
y = cconv(x,h,volume);
% рисунок
figure
hold on
% исходный сигнал
plot(times,x);
% фильтрованный сигнал
plot(times,y);
hold off
grid on
title('x, y');