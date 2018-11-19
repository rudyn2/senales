% Parte 1: Grafique la se?al en el tiempo y en frecuencia.

filename = '/T5.wav';
[y,Fs] = audioread(filename);
soundsc(y,Fs)
L = size(y);
T = 1/Fs;
%wena tonto shushetumare te voy a romper el ojete cmo a tu vieja
% sapo tonto y la rectm te voy a hacer cagar 
%q we a sapo y la maraca
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
F = fft(y);
P2 = abs(F/L(1));
P1 = P2(1:L(1)/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L(1)/2))/L(1);
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')




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
