function resultData = apply_filters(audioData, sampleRate, gains, filterClass)
firstFreq  = [0 170 300 610 1005 3000 6000 12000 14000];
secondFreq = [170 300 610 1005 3000 6000 12000 14000 20000];
order = 0;

if filterClass == 0 % FIR
    order = 500;
elseif filterClass == 1 % IIR
    order = 4;
end

[b, a] = low_pass(170, sampleRate, filterClass, order);
y = filter(b, a, audioData);
resultData = y * gains(1);
subplot(9,2,1)
plot(y)
title("y1(n)")
subplot(9,2,2)
wn = linspace(ceil(-(sampleRate)/2),floor(sampleRate/2),length(y));
plot(wn,fftshift(fft(y)/sampleRate))
title("y1(w)")
hold on
pcounter = 3;

for i=2:9
    [b, a] = band_pass(firstFreq(i), secondFreq(i), sampleRate, filterClass, order);
    y = filter(b, a, audioData);
    resultData = resultData + y * gains(i);
    subplot(9,2,pcounter)
    pcounter = pcounter + 1;
    plot(y)
    title(strcat("y",int2str(i),"(n)"))
    subplot(9,2,pcounter)
    pcounter = pcounter + 1;
    plot(wn,fftshift(fft(y)/sampleRate))
    title(strcat("y",int2str(i),"(w)"))
    hold on
end

end
