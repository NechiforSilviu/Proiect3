function [y] = CreateFilter(x, fs,filter_type)
%[z,p,y] = create_filter(x, fs)
%z,p - coefficents of the filter
% if no fs is inputed, automatically apply an all pass filter

%coefficents are nserted in b,a vectors as followxs:
%b = [b0,b1,b2...]
%a = [a0,a1,a2..]

if ~exist("filter_type",'var')
    for i = 1:5
        filter_type = 1; %allpass
    end
end

switch filter_type


    case 1 % APF FILTER
        f0 = 1000;
        omega = 2*pi*f0/fs;
        BW =1000;
        Q = 1/(2*sinh(log(2)/2* BW* omega / sin(omega) ));
        alfa  = sin(omega)/(2*Q);
        b = [ 1 - alfa  -2*cos(omega) 1 + alfa ];
        a = [ 1 + alfa  -2*cos(omega) 1 - alfa  ];
        y = filter(b,a,x);
        sos = tf2sos(b,a);
        figure(3);
        plotOnAudibleRange(sos,fs);

    case 2 % LPF FILTER
        A = 10^(20/40);
        S = 1;
        f0 = 500;
        omega = 2*pi*f0/fs;
        alfa = sin(omega)/2 * sqrt((A + 1/A)*(1/S - 1) + 2);
        
        b = [ (1 - cos(omega))/2  1 - cos(omega) (1 - cos(omega))/2 ];
        a = [ 1 + alfa -2 * cos(omega) 1 - alfa  ];
        sos = tf2sos(b,a);
        y = filter(b,a,x);
        figure(3);
        plotOnAudibleRange(sos,fs);


    case 3 % HPF FILTER
        A = 10^(3/40);
        S = 1;
        f0 = 800;
        omega = 2*pi*f0/fs;
        alfa = sin(omega)/2 * sqrt((A + 1/A)*(1/S - 1) + 2);
        
        b = [ (1+cos(omega))/2 -(1+cos(omega)) (1+cos(omega))/2 ];
        a = [ 1 + alfa -2*cos(omega) 1 - alfa ];
        sos = tf2sos(b,a);
        y = filter(b,a,x);
        figure(3);
        plotOnAudibleRange(sos,fs);


    case 4 % BPF FILTER
        f0 = 5000;
        BW  = 1;
        actualBW =  f0 * ( 2^(BW/2) - 1/2^(BW/2) ); % from octaves to HZ
        BWInDB  = log2(actualBW/f0+ 2^(1/2)) / log2(2^(1/2) - 2^(-1/2));
        omega = 2*pi*f0/fs;        
        alfa = sin(omega) * sinh(log(2)/2 * BW * omega/sin(omega));
        b = [ alfa 0 -alfa ];
        a = [ 1 + alfa -2*cos(omega) 1 - alfa];
        y = filter(b,a,x);
        sos = tf2sos(b,a);
        figure(3);
        semilogx((abs(fft(sos,19981))));


    case 5 % BSF FILTER
        f0 = 5000;
        BW  = 2;
        actualBW =  f0 * ( 2^(BW/2) - 1/2^(BW/2) ); % from octaves to HZ
        BWInDB  = log2(actualBW/f0+ 2^(1/2)) / log2(2^(1/2) - 2^(-1/2));
        omega = 2*pi*f0/fs;        
        alfa = sin(omega) * sinh(log(2)/2 * BW * omega/sin(omega));
        b = [ 1 -2*cos(omega) 1 ];
        a = [ 1 + alfa -2*cos(omega) 1 - alfa]; 
        y = filter(b,a,x);
        sos = tf2sos(b,a);
        figure(3);
        plotOnAudibleRange(sos,fs);


end           



% Apply filter

