%% Proyecto I: Equalizador básico de audio
% 
% Curso de Procesamiento de Señales
% Programa de Matemáticas Aplicadas y Ciencias de la Computación
% Universidad del Rosario, Agosto 2021
% 
% Profesor: ALexander Caicedo Dorado
%
% En esta función pueden encontrar las funciones básicas para adquirir una
% señal de audio utiliznado MATLAB, y calcular su transformada de Fourier.
% La salida de la transformada de Fourier deben utilizarla para realizar
% las tareas indicadas en el enundciado del Proyecto

%% Aquirir señal de audio

% recObj = audiorecorder; % Creando el objeto de audio
% 
% fs = recObj.SampleRate; % Extrayendo la frecuencia de muestreo del objeto de grabación.
% t_grab = 2; % Especificando el tiempo de grabación en segundos. Tenga en cuenta qu ese generará
%             % una grabación que se almacenara en un vector de 2*fs muestras.
% 
% disp('Comienza la grabación.')
% recordblocking(recObj, t_grab);
% disp('Termina la grabación.');
% 
% x= getaudiodata(recObj); % Extrayendo los datos grabados del elemento de grabación
% x = x./max(x); % Normalización de la señal

[x,fs] = audioread("monsters.ogg");

% Graficando la señal obtenida
n = length(x);
t = (0:n-1)/fs; % Creando un vector de tiempo
figure,
plot(t,x);
grid on
xlabel('tiempo [s]')
ylabel('Amplitud [u.a.]')
title('Señal de sonido grabada')

% Escuchando la señal grabada
sound(x,fs)

%% Calculo de la transformada de Fourier de la señal

Fx = fft(x); % Algoritmo para calcular los valores de la Transformada de Fourier
Fxs = fftshift(Fx); % Corrimiento de la transformada para obtener valores negativos y positivos. 
f = (-n/2:n/2-1)*fs/n; % Creación del vector de Frecuencias

% Grafica de la magnitud de la transformada de Fourier
figure, subplot(211)
plot(f,abs(Fxs))
xlabel('Frecuencia [Hz]')
ylabel('Amplitud [u.a.]')
title ('Magnitud de la Transformada de Fourier de la Señal')
grid on

% Grafica de la magnitud de la transformada de Fourier
subplot(212)
plot(f,angle(Fxs))
xlabel('Frecuencia [Hz]')
ylabel('Fase [radianes]')
title ('Fase de la Transformada de Fourier de la Señal')
grid on

%% Obteniendo la Transformada inversa de Fourier

Fx2 = ifftshift(Fxs); % Devolviendo el corrimiento realizado con fftshift
y = real(ifft(Fx2)); % Calculando la transformada inversa (Se toma la parte real, porque debido 
                     % a errores numericos se obtiene una transformada compleja, pero los valores 
                     % complejos son muy pequeños.
y = y./max(y); % Se normaliza la señal de salida

% Graficando la señal en el tiempo
figure,
plot(t,y);
grid on
xlabel('tiempo [s]')
ylabel('Amplitud [u.a.]')
title('Señal de sonido recuperada')

%% Test

frec1 = 0.005*rectangularWindow(f,Fxs,30,300);
frec2 = 0.05*rectangularWindow(f,Fxs,301,3000);


a = abs(frec1);
b = abs(frec2);

frec = frec1+frec2;
figure
plot(f, a+b);
% hold on
% plot(f, abs(Fxs));


fx3 = ifftshift(frec);
y2 = real(ifft(fx3));
y2 = y2./max(y2);


figure
% plot(t,y);
% hold on
plot(t,y2);


%sound(y2,fs);


%% Test 2


frec1 = 2*blackmanWindow(f,Fxs,30,300);
frec2 = 0.5*blackmanWindow(f,Fxs,301,3000);

a = abs(frec1);
b = abs(frec2);

frec = frec1+frec2;
figure
plot(f, a+b);
hold on
plot(f, abs(Fxs));

fx3 = ifftshift(frec);
y2 = real(ifft(fx3));
y2 = y2./max(y2);


figure
plot(t,y);
hold on
plot(t,y2);


%sound(y2,fs);
