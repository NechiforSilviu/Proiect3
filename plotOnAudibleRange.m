function [y] = plotOnAudibleRange(y,fs)
% y - the input signal (that is actually the output of the filter) / input
% of the filter before processing
% [y] - not interesting
% just run this function and it will graph


Y = abs(fft(y ,fs * 2));
semilogx(20:20000, 20 * log(Y(20:20000)));
axis([20,20000,-170, 70]);