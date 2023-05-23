function [b, a] = band_pass(Fc1, Fc2, sampleRate, filterClass, order)
% This function returns the numerator and denominator of the bandpass filter
% @filterClass = 0 : FIR , @filterClass = 1 : IIR

Fm = sampleRate/2; % Nyquist freq

if(filterClass == 0) % FIR
    [b, a] = fir1(order, [Fc1 Fc2]/Fm, 'bandpass');
    [b, a] = eqtflength(b, a);
elseif(filterClass == 1) % IIR
    [b, a] = butter(order, [Fc1 Fc2]/Fm , 'bandpass');
    [b, a] = eqtflength(b,a);
end

end

