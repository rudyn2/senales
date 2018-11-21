% Parte 1: Grafique la se?al en el tiempo y en frecuencia.

filename = '/T5.wav';
[y,Fs] = audioread(filename);
nfft = 8192;
soundsc(y,Fs)
L = size(y);
T = 1/Fs;


fprintf('Frecuencia de muestreo: %d\n', Fs);
fprintf('Tiempo entre muestras : %d\n', T);
t = 0:T:((L-1)*T);


hold on
subplot(2,1,1);
plot(t,y);
title('Amplitud de la se?al en el tiempo');
xlabel('Tiempo [s]');
ylabel('Amplitud [V]');


subplot(2,1,2);
Y=fft(y,nfft);
% tomar la FFT, y llenando con ceros, de manera que el largo de la FFT sea nfft
Y = Y(1:nfft/2); 
% la FFT es sim?trica, as? que se tira la mitad
my = abs(Y).^2;
% tomar la  potencia espectral, m?dulo alcuadrado de la FFT
f = (0:nfft/2-1)*Fs/nfft; 
%construccion del vector de frecuencias
plot(f,my);



% Parte 2: Obtenga y grafique la se?al portadora en tiempo y frecuencia,
% recuerde que se desea desplazar la se?al a 3 kHz.



% Parte 3: Demodule la se?al de la parte 2. Grafique en tiempo y
% frecuencia. Escuche y compare la se?al obtenida con la original.

% Restricciones:
% - Utilizar la misma frecuencia de modulaci?n.
% - La atenuaci?n no debe ser menor a 30 dB. Las p?rdidas en la banda
%   de paso no pueden ser mayores a 1 dB. Considere que la se?al se
%   encuentra contenida en la bada de 2 kHz y que la frecuencia de corte se
%   encuentra en +-1.2 kHz (con respecto a la frecuencia central).
