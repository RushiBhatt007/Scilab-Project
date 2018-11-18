clc;
close;
clear;

input = "/Users/Siddharth/Desktop/final.wav"

[y,Fs] = wavread(input);Fs
ffty = fftshift(fft(y(1,:)));
//Input signal sound
playsnd(y(1,:),Fs)

//Defining the terms
l = length(y(1,:))
t = (1/Fs):(1/Fs):(l/Fs)
n = length(t)
Ac = 1
fc = 10000
C = cos(2.*%pi.*fc.*t)
fftC = fftshift(fft(C));

df = Fs/n
F = -(Fs/2):df:(Fs/2)-df

//DSB-FC Modulation
Sm = (Ac + y(1,:)).*C
fftS = fftshift(fft(Sm)) 
//Modulated signal sound
//playsnd(Sm,Fs)


//Synchronous Detection
r=rand(1,length(t),"uniform")
y2 = Sm.*C + r/10
ffty2 = fftshift(fft(y2))
//Demodulation without filtering sound
//playsnd(y2,Fs)


//Creating filter
lf = length(ffty2);
filter = zeros(1,lf)

for i=1:1:lf
    if abs(F(1,i)) <= 4000 && abs(F(1,i)) >= 20
        filter(1,i) = 3;
    end
end

//Filtering
final = ffty2.*filter


final_time = ifft(ifftshift(final))
//output sound
playsnd(final_time,Fs)

//original signal in time and frequenc domain
figure
subplot(211)
plot(t,y(1,:))
title("Input in Time Domain")

subplot(212)
plot(F,ffty)
title("Input in Frequency Domain")

//modulated and demodulated signals in time and frequency domain
figure
subplot(411)
plot(t,Sm)
title("Modulated Signal in Time Domain")

subplot(412)
plot(F,fftS)
title("Modulated Signal in Frequency Domain")

subplot(413)
plot(t,y2)
title("Demodulated Signal in Time Domain")

subplot(414)
plot(F,ffty2)
title("Demodulated Signal in Frequency Domain")

//output in time and frequency domain
figure
subplot(211)
plot(t,final_time)
title("Output in Time Domain")

subplot(212)
plot(F,final)
title("Output in Frequency Domain")
