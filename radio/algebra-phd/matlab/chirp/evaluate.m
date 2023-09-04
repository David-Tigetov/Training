close all

% параметры ЛЧМ
% длительность
T = 10;
% начальная частота
fb = 2;
% конечная частота
fe = 10;
% частота
frequency = @(t) f + (fe - fb) * t/T;
% сигнал
signal = @(t) cos(2 * pi * frequency(t) .* t);

% количество отсчётов
n = 4096;
% моменты времени отсчётов
t = 0:T/n:T-1/n;
% дискретный сигнал
x = signal(t);
figure
plot(t, x);

% частота дискретизации
fd = n/T;

% спектр сигнала
X = fft(x);
% номера отображаемых частот
%m = floor(fb*T):1:ceil(fe*T);
m = 1:n;
% вычисляем модуль в децибелах
S = abs(X(m));
% вычисляем фазу (без скачков)
Xa = angle(X(m));
Phase = Xa;
base = 0;
for k = 2:length(Xa)
    if ( Xa(k) - Xa(k-1) > 0.01*pi)
        base = base - 2*pi;
    end
    Phase(k) = Xa(k) + base;
end
% рисунок
figure
subplot(2,1,1)
plot(m/T, S)
grid on
subplot(2,1,2)
plot(m/T,Phase)
grid on