clc; clear; close all;
no_of_frames = 300;

[x, fs] = audioread("interface.mp3");
buffer = zeros(10,1024);
N = 1024; %samples per frame

% buffer = [ 1 1 1 1 1 1 1 1 1 0]  1 = a frame is in there; 0 - no frame
% yet
for i = 1:9
    buffer(10 - i,:) = x(1+N*(i-1):N*i);
end

for i=10:no_of_frames
    x1=x(1+N*(i-1):N*i);
    buffer = circshift(buffer, [1 0]);
    buffer(1,:) = x1;
    %applyting filtering process
    X = abs(fft(buffer(end,:),19981));
    t = 20:20000;
    %plotiing the result
    subplot(211)
    semilogx(t,X);
    subplot(212)
    plotOnAudibleRange(abs(fft(y)),fs)
    sound(x1,fs);
    pause(0.0213);
end


