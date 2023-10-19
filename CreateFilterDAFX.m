function [y] = CreateFilterDAFX(x, fs,filter_type)
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
        f0 = 800;
        bw = 1000;
        K = tan(pi*f0/fs);
        Q = f0/bw;
        
        b0 = K/(K^2*Q + K + Q);
        b1 = 0;
        b2 = -K/(K^2*Q + K + Q);
        a0 = 1;
        a1 = 2*Q*(K^2-1)/(K^2*Q+K+Q);
        a2 = K^2*Q-K+Q/(K^2*Q+K+Q);
        b = [ b0 b1 b2 ];
        a = [ a0 a1 a2 ];

        y = filter(b,a,x);


    case 2 % LPF FILTER
        f0 = 2000;
        K = tan(pi*f0/fs);
        Q = 1/sqrt(2);
        
        b0 = (K^2*Q)/(K^2*Q + K + Q);
        b1 = 2*K^2*Q/(K^2*Q+ K + Q);
        b2 = (K^2*Q)/(K^2*Q + K + Q);
        a0 = 1;
        a1 = 2*Q*(K^2-1)/(K^2*Q+K+Q);
        a2 = (K^2*Q-K+Q)/(K^2*Q+K+Q);
        b = [ b0 b1 b2 ];
        a = [ a0 a1 a2 ];
        
        y = filter(b,a,x);


    case 3 % HPF FILTER
        f0 = 8000;
        K = tan(pi*f0/fs);
        Q = 1/sqrt(2);
        
        b0 = Q/(K^2*Q + K + Q);
        b1 = -2*Q/(K^2*Q+ K + Q);
        b2 = Q/(K^2*Q + K + Q);
        a0 = 1;
        a1 = 2*Q*(K^2-1)/(K^2*Q+K+Q);
        a2 = (K^2*Q-K+Q)/(K^2*Q+K+Q);
        b = [ b0 b1 b2 ];
        a = [ a0 a1 a2 ];

        y = filter(b,a,x);


    case 4 % BPF FILTER
        f0 = 1000;
        bw = 1800;
        K = tan(pi*f0/fs);
        Q = f0/bw;
        
        b0 = K/(K^2*Q + K + Q);
        b1 = 0;
        b2 = -K/(K^2*Q + K + Q);
        a0 = 1;
        a1 = 2*Q*(K^2-1)/(K^2*Q+K+Q);
        a2 = (K^2*Q-K+Q)/(K^2*Q+K+Q); % SCRIA         a2 = K^2*Q-K+Q/(K^2*Q+K+Q);
        b = [ b0 b1 b2 ];
        a = [ a0 a1 a2 ];

        y = filter(b,a,x);


    case 5 % BSF FILTER
        f0 = 1000;
        bw = 1800;
        K = tan(pi*f0/fs);
        Q = f0/bw;
        
        b0 = K^2*Q-K+Q/(K^2*Q + K + Q);
        b1 = 2*Q*(K^2-1)/(K^2*Q+ K + Q);
        b2 = 1;
        a0 = 1;
        a1 = 2*Q*(K^2-1)/(K^2*Q+K+Q);
        a2 = (K^2*Q-K+Q)/(K^2*Q+K+Q);    %         a2 = K^2*Q-K+Q/(K^2*Q+K+Q);
        b = [ b0 b1 b2 ];
        a = [ a0 a1 a2 ];

        y = filter(b,a,x);


end           



% Apply filter

