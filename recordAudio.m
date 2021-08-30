function [x, fs] = recordAudio(t_rec)
    recObj = audiorecorder; 

    fs = recObj.SampleRate; 

    recordblocking(recObj, t_rec);


    x= getaudiodata(recObj); 
    x = x./max(x); 

end 