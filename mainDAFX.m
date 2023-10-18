clc; clear; close all;
% TD - case 4
[x, fs] = audioread('sunflower.mp3');
x1 = x(44100* 6: 44100 * 8);
x = x(1:1024);
X = fft(x);
N = length(X);

filter_type = [1 1 1 1 1];
for i = 1:5

    [y] = CreateFilterDAFX(x,fs,i);
    y1 = CreateFilterDAFX(x1,fs,i);
    Y = abs(fft(y));
    X = abs(fft(x));
    
    figure(1)
    subplot(211)
    plotOnAudibleRange(x, fs);
    
    subplot(212);
    plotOnAudibleRange(y, fs);
    sound(y1,fs);
    pause(3);
end




