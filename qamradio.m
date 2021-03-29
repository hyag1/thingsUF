%% Modulação
Fs = 3;                                         %freq do sinal
Ta = 1E-4;                                       %tempo de amostagem
t = [0:Ta:1];                                 %vetor do tempo
Sf = cos(2*pi*150*t).*exp(-5*t);                %sinal em fase
Sq = exp(-40*t);                                %sinal em quadraduta

port = sin(2*pi*500*t);                       %portadora em fase
portQuad = sin((2*pi*500*t)+(90*pi/180));     %portadora em quadratura

mod1 = Sf.*port;                                %modulação da portadora em fase
mod2 = Sq.*portQuad;                            %modulação da portadora em quadratura

QAM = mod1 + mod2;                              %somatorio dos dois sinais modulados


%% DEMODULAÇÃO
oscilador = sin(2*pi*500*t);                  %oscilador local em fase
osciladorquad = sin(2*pi*500*t+(90*pi/180));  %oscilador local em quadratura

demod1 = QAM.*oscilador;                        
demod2 = QAM.*osciladorquad;


%% Graficos no tempo

subplot(3,1,1);
plot(t,QAM);                    %Sinal QAM no Tempo
title('Sinal QAM no Tempo');
ylabel('Amplitude');
xlabel('Tempo');

subplot(3,1,2);
plot(t,Sf);                      %Sinal em fase m_1(t) no Tempo
title('Sinal em Fase no tempo');
ylabel('Amplitude');
xlabel('Tempo');

subplot(3,1,3);
plot(t,Sq);                      %Sinal em quadratura m_2(t) no Tempo
title('Sinal em Quadratura no tempo');
ylabel('Amplitude');
xlabel('Tempo');
% Gráfico composto Sinal em Fase
figure;
plot(t,Sf,t,demod1);
ylabel('Amplitude');
xlabel('Tempo');
legend('Sinal em Fase Original','Sinal em Fase Demodulado','location','southeast');
% Gráfico composto Sinal em Quadratura
figure;
plot(t,Sq,t,demod2);
ylabel('Amplitude');
xlabel('Tempo');
legend('Sinal em Quadratura Original','Sinal em Quadratura Demodulado','location','southeast');
%% Graficos na Frequência
fa = 1/Ta;
lfft=length(mod1)*10;                         % Comprimento da fft (Arbitrário)
freq=(-fa/2:fa/lfft:fa/2-fa/lfft);            % Eixo de frequência 
fa = 1/Ta;
Mfft=fft(mod1,lfft)/lfft;                        % Calcula a FFT
M_sig=fftshift(Mfft);


lfft3=length(QAM)*10;                         % Comprimento da fft (Arbitrário)
freq1=(-fa/2:fa/lfft3:fa/2-fa/lfft3);            % Eixo de frequência 
Mfft3=fft(QAM,lfft3)/lfft3;                        % Calcula a FFT
M_sig3=fftshift(Mfft3);

lfft2=length(mod2)*10;                         % Comprimento da fft (Arbitrário)
freq2=(-fa/2:fa/lfft2:fa/2-fa/lfft2);            % Eixo de frequência 
Mfft2=fft(mod2,lfft2)/lfft2;                        % Calcula a FFT
M_sig2=fftshift(Mfft2);

subplot(3,1,1);
plot(freq,abs(M_sig)); %Espectro do sinal c(t).m_1(t) não filtrado
title('Espectro do Sinal em Fase');
ylabel('Magnitude');
xlabel('Frequência [Hz]');


subplot(3,1,2);
plot(freq2,abs(M_sig2)); %Espectro do sinal c(t).m_2(t) não filtrado
title('Espectro do Sinal em Quadratura');
ylabel('Magnitude');
xlabel('Frequência [Hz]');

subplot(3,1,3);
plot(freq1,abs(M_sig3)); %Espectro do sinal QAM
title('Espectro do Sinal em QAM');
ylabel('Magnitude');
xlabel('Frequência [Hz]');

%% Gráfico composto Sinal em Fase na frequencia

fa = 1/Ta;
lfft4=length(Sf)*10;                         % Comprimento da fft (Arbitrário)
freq3=(-fa/2:fa/lfft4:fa/2-fa/lfft4);            % Eixo de frequência 
Mfft4=fft(Sf,lfft4)/lfft4;                        % Calcula a FFT
M_sig4=fftshift(Mfft4);

lfft5=length(demod1)*10;                         % Comprimento da fft (Arbitrário)
freq4=(-fa/2:fa/lfft5:fa/2-fa/lfft5);            % Eixo de frequência 
Mfft5=fft(demod1,lfft5)/lfft5;                        % Calcula a FFT
M_sig5=fftshift(Mfft5);

lfft6=length(Sq)*10;                         % Comprimento da fft (Arbitrário)
freq5=(-fa/2:fa/lfft6:fa/2-fa/lfft6);            % Eixo de frequência 
Mfft6=fft(Sq,lfft6)/lfft6;                        % Calcula a FFT
M_sig6=fftshift(Mfft6);

lfft7=length(demod2)*10;                         % Comprimento da fft (Arbitrário)
freq6=(-fa/2:fa/lfft7:fa/2-fa/lfft7);            % Eixo de frequência 
Mfft7=fft(demod2,lfft7)/lfft7;                        % Calcula a FFT
M_sig7=fftshift(Mfft7);

figure;
plot(freq3,abs(M_sig4),freq4,abs(M_sig5));
ylabel('Magnitude');
xlabel('Frequencia [Hz]');
legend('Espectro do Sinal em Fase Original','Espectro do Sinal em Fase Demodulado','location','southeast');

figure;
plot(freq5,abs(M_sig6),freq6,abs(M_sig7));
ylabel('Magnitude');
xlabel('Frequencia [Hz]');
legend('Espectro do Sinal em Quadradura Original','Espectro do Sinal em Quadratura Demodulado','location','southeast');








