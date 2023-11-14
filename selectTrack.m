function [y] = selectTrack(i)
    if strcmp(i, "Exemplu7")
        y = "audio_files/Exemplu7.wav";
    elseif strcmp(i, "interface")
        y = "audio_files/interface.mp3";
    elseif strcmp(i, "Baby again")
        y = "audio_files/Baby again.mp3";
    elseif strcmp(i, "Bamboleo")
        y = "audio_files/Bamboleo.mp3";
    elseif strcmp(i, "Professional")
        y = "audio_files/Professional.wav";
    elseif strcmp(i, "What is love")
        y = "audio_files/What is love.wav";
    else
        y = "audio_files/Exemplu7.wav";
    end
end