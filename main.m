% Parte 1: Grafique la se?al en el tiempo y en frecuencia.

filename = '/T5.wav';
[y,Fs] = audioread(filename);
nfft = 8000;
%soundsc(y,Fs)
L = size(y);
T = 1/Fs;
wc = 2*pi*3000;



fprintf('Frecuencia de muestreo: %d\n', Fs);
fprintf('Tiempo entre muestras : %d\n', T);
t = 0:T:((L-1)*T);


hold on
subplot(4,1,1);
plot(t,y);
title('Amplitud de la senal en el tiempo');
xlabel('Tiempo [s]');
ylabel('Amplitud [V]');
hold off


f = (0:nfft/2-1)*Fs/nfft; 
Y=fft(y,nfft);


Y = Y(1:nfft/2); 
my = abs(Y).^2;

[b, a] = butter(40, 2*1000/Fs);
yprima = 2*filter(b,a,y);
Yprima = fft(yprima,nfft);
Yprima = abs(Yprima(1:nfft/2)).^2;

subplot(4,1,2);
plot(f,my);

subplot(4,1,3);
plot(t,yprima);

subplot(4,1,4);
plot(f,Yprima);

% Parte 2: Obtenga y grafique la se?al portadora en tiempo y frecuencia,
% recuerde que se desea desplazar la se?al a 3 kHz.

fprintf('Program paused. Press enter to continue.\n');
pause;

figure();
% Tiempo portadora
subplot(2,1,1);
title('Senal portadora en funcion del tiempo');
p = cos(wc*t);
plot(t(1,1:100),p(1,1:100));

% Fourier portadora
subplot(2,1,2);
Y=fft(p,nfft);
Y = Y(1:nfft/2); 
my = abs(Y).^2;
f = (0:nfft/2-1)*Fs/nfft; 
plot(f,my);

% Senal modulada: s
s = p'.*y;
fprintf('Program paused. Press enter to continue.\n');
pause;

figure();
subplot(3,1,1);
title('Senal portadora en funcion del tiempo');
plot(t,s);

subplot(3,1,2);
Y=fft(s,nfft);
Y2 = fftshift(Y);
Y = Y(1:nfft/2); 
my = abs(Y).^2;
f = (0:nfft/2-1)*Fs/nfft;
f2 = (-nfft/2:nfft/2-1)*Fs/nfft;
plot(f2,abs(Y2).^2);

subplot(3,1,3);
plot(f, abs(Y2(4000:end-1,1)).^2);



% Parte 3: Demodule la se?al de la psarte 2. Grafique en tiempo y
% frecuencia. Escuche y compare la se?al obtenida con la original.

% Primero la modulada se multiplica por un coseno
figure();
hold on
title('Senal demodulada en funcion del tiempo');
xlabel('Tiempo [s]');
ylabel('Amplitud');
d = s'.*p;
[b, a] = butter(40, 2*1200/Fs);
demodulada = filter(b,a,d);
plot(t,demodulada);

% Restricciones:
%   Utilizar la misma frecuencia de modulaci?n.
%   La atenuaci?n no debe ser menor a 30 dB. Las perdidas en la banda
%   de paso no pueden ser mayores a 1 dB. Considere que la se?al se
%   encuentra contenida en la bada de 2 kHz y que la frecuencia de corte se
%   encuentra en +-1.2 kHz (con respecto a la frecuencia central).
