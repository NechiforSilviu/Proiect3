afr = dsp.AudioFileReader('interface.mp3','SamplesPerFrame',1024,'ReadRange',[1 20*22050]);

adw = audioDeviceWriter('SampleRate', afr.SampleRate );
i = 1;
bufferstereo = zeros(1024,10);



while ~isDone(afr)
    audio = afr();
    %audio = applyLowPassFilter(step(afr),afr.SampleRate,1000);
    %audio = CreateFilter(audio,Fs,2);
    if i < 10
        
        bufferstereo(:,i)= audio(:,1);
        %bufferstereo(:,i) = CreateFilter(bufferstereo(:,i),afr.SampleRate, 3 );
        i = i+1;
    else
        bufferstereo(:,10)= audio(:,1);
        %bufferstereo(:,10) = CreateFilter(bufferstereo(:,10),afr.SampleRate, 3 );
        adw(bufferstereo(:,1));
        bufferstereo = circshift(bufferstereo, [0 1]);
    end

end

release(afr); 
release(adw);