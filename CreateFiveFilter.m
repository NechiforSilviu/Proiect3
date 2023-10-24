function [y_out] = CreateFiveFilter(x, fs,filter_type)
%[z,p,y] = create_filter(x, fs)
%z,p - coefficents of the filter
% if no fs is inputed, automatically apply an all pass filter

%coefficents are nserted in b,a vectors as followxs:
%b = [b0,b1,b2...]
%a = [a0,a1,a2..]

if ~exist("filter_type",'var')
    for i = 1:5
        filter_type(i) = 1; %allpass
    end
end
b = zeros(5,3);
a = zeros(5,3);
y = zeros(5,length(x));


for i = 1:5  %loop through filters
    switch filter_type(i)
    
    
        case 1 % APF 
            f0 = 1000;
            omega = 2*pi*f0/fs;
            BW =1000;
            Q = 1/(2*sinh(log(2)/2* BW* omega / sin(omega) ));
            alfa  = sin(omega)/(2*Q);
            size(b(i,:)),size([ 1 - alfa  -2*cos(omega) 1 + alfa ])
            b(i,:) = [ 1 - alfa  -2*cos(omega) 1 + alfa ];
            a(i,:) = [ 1 + alfa  -2*cos(omega) 1 - alfa  ];
            y(i,:) = filter (b(i,:),a(i,:),x);
    
        case 2 % LPF 
            A = 10^(20/40);
            S = 1;
            f0 = 500;
            omega = 2*pi*f0/fs;
            alfa = sin(omega)/2 * sqrt((A + 1/A)*(1/S - 1) + 2);
            
            b(i,:) = [ (1 - cos(omega))/2  1 - cos(omega) (1 - cos(omega))/2 ];
            a(i,:) = [ 1 + alfa -2 * cos(omega) 1 - alfa  ];
            y(i,:) = filter (b(i,:),a(i,:),x);
        case 3 % HPF 
        
            S = 1;
            f0 = 800;
            omega = 2*pi*f0/fs;
            A = 10^(3/40);
            alfa = sin(omega)/2 * sqrt((A + 1/A)*(1/S - 1) + 2);
            
            b(i,:) = [ (1+cos(omega))/2 -(1+cos(omega)) (1+cos(omega))/2 ];
            a(i,:) = [ 1 + alfa -2*cos(omega) 1 - alfa ];
            y(i,:) = filter (b(i,:),a(i,:),x);
    
        case 4 % BPF 
            f0 = 5000;
            BW  = 1;
            actualBW =  f0 * ( 2^(BW/2) - 1/2^(BW/2) ); % from octaves to HZ
            BWInDB  = log2(actualBW/f0+ 2^(1/2)) / log2(2^(1/2) - 2^(-1/2));
            omega = 2*pi*f0/fs;        
            alfa = sin(omega) * sinh(log(2)/2 * BW * omega/sin(omega));
            b(i,:) = [ alfa 0 -alfa ];
            a(i,:) = [ 1 + alfa -2*cos(omega) 1 - alfa];
            y(i,:) = filter (b(i,:),a(i,:),x);
    
    
        case 5 % BSF 
            f0 = 5000;
            BW  = 2;
            actualBW =  f0 * ( 2^(BW/2) - 1/2^(BW/2) ); % from octaves to HZ
            BWInDB  = log2(actualBW/f0+ 2^(1/2)) / log2(2^(1/2) - 2^(-1/2));
            omega = 2*pi*f0/fs;        
            alfa = sin(omega) * sinh(log(2)/2 * BW * omega/sin(omega));
            b(i,:) = [ 1 -2*cos(omega) 1 ];
            a(i,:) = [ 1 + alfa -2*cos(omega) 1 - alfa]; 
            y(i) = filter (b(i,:),a(i,:),x);
        case 6 % PEAKING EQ
            f0 = 1000;
            BW  = 1;
            actualBW =  f0 * ( 2^(BW/2) - 1/2^(BW/2) ); % from octaves to HZ
            BWInDB  = log2(actualBW/f0+ 2^(1/2)) / log2(2^(1/2) - 2^(-1/2));
    
            A = 10^(1/1200);
            omega = 2*pi*f0/fs;     
    
            alfa = sin(omega) * sinh(log(2)/2 * BW * omega/sin(omega));
            b(i,:) = [ 1 + alfa * A -2 * cos(omega) 1+alfa/A];
            a(i,:) = [ 1 + alfa/A -2 * cos(omega) 1-alfa/A];
            y(i,:) = filter (b(i,:),a(i,:),x);
    
        case 7 % lowShelf
            f0 = 1000;
            S = 1000;
            A = 10^(-20/40);
            omega = 2*pi*f0/fs;
            alfa = sin(omega)/2 * sqrt((A + 1/A)*(1/S - 1) + 2);
    
            b0 = A * ((A+1) - (A-1) * cos(omega) + 2 * sqrt(A) * alfa);
            b1 = 2* A * ((A-1) - (A+1)*cos(omega));
            b2 = A * ((A+1) - (A-1)*cos(omega) - 2*sqrt(A) * alfa);
            a0 = (A+1) + (A-1) * cos(omega) + 2 * sqrt(A) * alfa;
            a1 = -2*((A-1) + (A+1) * cos(omega));
            a2 = (A+1) + (A-1) * cos(omega) - 2 * sqrt(A) * alfa;
    
            b(i,:) = [b0 b1 b2];
            a(i,:) = [a0 a1 a2];
            y(i,:) = filter (b(i,:),a(i,:),x);
    
        case 8 % high shelf
            f0 = 10000;
            S = 10000;      
            A = 10^(-20/40);
            omega = 2*pi*f0/fs;
            alfa = sin(omega)/2 * sqrt((A + 1/A)*(1/S - 1) + 2);
    
            b0 = A * ((A+1) + (A-1) * cos(omega) + 2 * sqrt(A) * alfa);
            b1 = -2* A * ((A-1) + (A+1)*cos(omega));
            b2 = A * ((A+1) + (A-1)*cos(omega) - 2*sqrt(A) * alfa);
            a0 = (A+1) - (A-1) * cos(omega) + 2 * sqrt(A) * alfa;
            a1 = 2*((A-1) - (A+1) * cos(omega));
            a2 = (A+1) - (A-1) * cos(omega) - 2 * sqrt(A) * alfa;
    
            b(i,:) = [b0 b1 b2];
            a(i,:) = [a0 a1 a2];
            y(i,:) = filter (b(i,:),a(i,:),x);
    
    end           
    
end    % stop looping through filters
y_out = sum(y);
% Apply filter

