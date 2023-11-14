function [y_out] = CreateFiveFilter(x, fs, filter_type, frequency, bandwidth)
proba 1 2 3 
%[z,p,y] = create_filter(x, fs)
%z,p - coefficents of the filter
% if no fs is inputed, automatically apply an all pass filter

%coefficents are inserted in b,a vectors as follows:
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


    switch filter_type(i,:)
    
    
        case 'APF' % APF 
            omega = 2*pi*frequency(i)/fs;
            Q = 1/(2*sinh(log(2)/2* bandwidth(i) * omega / sin(omega) ));
            alfa  = sin(omega)/(2*Q);
            size(b(i,:)),size([ 1 - alfa  -2*cos(omega) 1 + alfa ])
            b(i,:) = [ 1 - alfa  -2*cos(omega) 1 + alfa ];
            a(i,:) = [ 1 + alfa  -2*cos(omega) 1 - alfa  ];
            y(i,:) = filter (b(i,:),a(i,:),x);
    
        case 'LPF'
            S = 1;
            A = 10^(bandwidth(i)/40);
            omega = 2*pi*frequency(i)/fs;
            alfa = sin(omega)/2 * sqrt((A + 1/A)*(1/S - 1) + 2);
            
            b(i,:) = [ (1 - cos(omega))/2  1 - cos(omega) (1 - cos(omega))/2 ];
            a(i,:) = [ 1 + alfa -2 * cos(omega) 1 - alfa];
            y(i,:) = filter (b(i,:),a(i,:),x);

        case 'HPF' 
        
            S = 1;
            A = 10^(bandwidth(i)/40);
            omega = 2*pi*frequency(i)/fs;
            alfa = sin(omega)/2 * sqrt((A + 1/A)*(1/S - 1) + 2);
            
            b(i,:) = [ (1+cos(omega))/2 -(1+cos(omega)) (1+cos(omega))/2 ];
            a(i,:) = [ 1 + alfa -2*cos(omega) 1 - alfa ];
            y(i,:) = filter (b(i,:),a(i,:),x);
    
        case 'BPF' 
            actualBW =  frequency(i) * ( 2^(bandwidth(i)/2) - 1/2^(bandwidth(i)/2) ); % from octaves to HZ
            BWInDB  = log2(actualBW/frequency(i)+ 2^(1/2)) / log2(2^(1/2) - 2^(-1/2));
            omega = 2*pi*frequency(i)/fs;        
            alfa = sin(omega) * sinh(log(2)/2 * bandwitdh(i) * omega/sin(omega));
            b(i,:) = [ alfa 0 -alfa ];
            a(i,:) = [ 1 + alfa -2*cos(omega) 1 - alfa];
            y(i,:) = filter (b(i,:),a(i,:),x);
    
    
        case 'BSF' 
            actualBW =  frequency(i) * ( 2^(bandwidth(i)/2) - 1/2^(bandwidth(i)/2) ); % from octaves to HZ
            BWInDB  = log2(actualBW/frequency(i)+ 2^(1/2)) / log2(2^(1/2) - 2^(-1/2));
            omega = 2*pi*frequency(i)/fs;        
            alfa = sin(omega) * sinh(log(2)/2 * bandwidth(i) * omega/sin(omega));
            b(i,:) = [ 1 -2*cos(omega) 1 ];
            a(i,:) = [ 1 + alfa -2*cos(omega) 1 - alfa]; 
            y(i) = filter (b(i,:),a(i,:),x);


        case 'PEQ'
            actualBW =  frequency(i) * ( 2^(bandwidth(i)/2) - 1/2^(bandwidth(i)/2) ); % from octaves to HZ
            BWInDB  = log2(actualBW/frequency(i)+ 2^(1/2)) / log2(2^(1/2) - 2^(-1/2));
    
            A = 10^(1/1200);
            omega = 2*pi*frequency(i)/fs;     
    
            alfa = sin(omega) * sinh(log(2)/2 * bandwidth(i) * omega/sin(omega));
            b(i,:) = [ 1 + alfa * A -2 * cos(omega) 1+alfa/A];
            a(i,:) = [ 1 + alfa/A -2 * cos(omega) 1-alfa/A];
            y(i,:) = filter (b(i,:),a(i,:),x);
    
        case 'LSF'
            S = 1000;
            A = 10^(-bandwidth(i)/40);
            omega = 2*pi*frequency(i)/fs;
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
    
        case 'HSL'
            S = 10000;      
            A = 10^(-bandwidth(i)/40);
            omega = 2*pi*frequency(i)/fs;
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

