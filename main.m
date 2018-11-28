% Parte 1: Grafique la se?al en el tiempo y en frecuencia.

filename = '/T5.wav';
[y,Fs] = audioread(filename);
nfft = 8000;
L = size(y);
T = 1/Fs;
wc = 2*pi*3000;


fprintf('Frecuencia de muestreo: %d\n', Fs);
fprintf('Tiempo entre muestras : %d\n', T);
t = 0:T:((L-1)*T);


hold on
subplot(4,1,1);
plot(t,y);
title('Senal de entrada en funcion del tiempo');
xlabel('Tiempo [s]');
ylabel('Amplitud [V]');


f = (0:nfft/2-1)*Fs/nfft; 
Y=fft(y,nfft); % FFT de se?al de entrada

Y = Y(1:nfft/2); 
my = abs(Y).^2; % Potencia se?al de entrada 

[b, a] = butter(40, 2*1000/Fs); % Filtro pasa bajo en los 1000 Hz
yprima = 2*filter(b,a,y);       % Amplificaci?n de 2 y filtrado
Yprima = fft(yprima,nfft);      % FFT de se?al filtrada
Yprima = abs(Yprima(1:nfft/2)).^2;  % Potencia de se?al filtrada

subplot(4,1,2);
plot(f,my);
title('Espectro de Fourier de senal de entrada');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');

subplot(4,1,3);
plot(t,yprima);
title('Senal de entrada filtrada con pasa bajo en 1kHz en funcion del tiempo');
xlabel('Tiempo [s]');
ylabel('Amplitud');

subplot(4,1,4);
plot(f,Yprima);
title('Espectro de Fourier de senal filtrada');
xlabel('Tiempo [s]');
ylabel('Amplitud');

fprintf('Program paused. Press enter to continue.\n');
pause;

% Tiempo portadora
hold on
figure();
subplot(2,1,1);
p = cos(wc*t);
plot(t(1,1:100),p(1,1:100));
title('Senal portadora en funcion del tiempo');
xlabel('Tiempo [s]');
ylabel('Amplitud');


% Fourier portadora
subplot(2,1,2);
Y=fft(p,nfft);
Y = Y(1:nfft/2); 
my = abs(Y).^2;
f = (0:nfft/2-1)*Fs/nfft; 
plot(f,my);
title('Espectro de fourier de la sennal portadora');
xlabel('Frecuencia [Hz]');
ylabel('Potencia');
hold off;

% Senal modulada: s
s = p'.*y;
fprintf('Program paused. Press enter to continue.\n');
pause;


figure();
subplot(3,1,1);
plot(t,s);
title('Senal modulada en funcion del tiempo');
xlabel('Tiempo [s]');
ylabel('Amplitud');


subplot(3,1,2);
Y=fft(s,nfft);
Y2 = fftshift(Y);
Y = Y(1:nfft/2); 
my = abs(Y).^2;
f = (0:nfft/2-1)*Fs/nfft;
f2 = (-nfft/2:nfft/2-1)*Fs/nfft;

plot(f2,abs(Y2).^2);
title('Espectro de fourier centrado de senal modulada');
xlabel('Frecuencia [Hz]');
ylabel('Potencia');

subplot(3,1,3);
plot(f, abs(Y2(4000:end-1,1)).^2);
title('Espectro de fourier positivo de senal modulada');
xlabel('Frecuencia [Hz]');
ylabel('Potencia');

fprintf('Program paused. Press enter to continue.\n');
pause;

figure();


d = s'.*p;
Wp = 2*1200/Fs; Ws = 2*1400/Fs;
[n, Wn] = buttord(Wp,Ws,1,30);
[b, a] = butter(40, 2*1200/Fs);
demodulada = filter(b,a,d);

subplot(2,1,1);
soundsc(demodulada,Fs);
plot(t,demodulada);
title('Senal demodulada en funcion del tiempo');
xlabel('Tiempo [s]');
ylabel('Amplitud');

subplot(2,1,2);
Y3 = fft(demodulada,nfft);
Y3 = Y3(1:nfft/2); 
plot(f, abs(Y3).^2);
title('Espectro de fourier de la senal demodulada');
xlabel('Frecuencia [Hz]');
ylabel('Potencia');
