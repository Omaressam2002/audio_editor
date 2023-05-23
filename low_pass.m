function [b, a] = low_pass(Fc, sampleRate, filterClass, order)
% This function returns the numerator and denominator of the low-pass filter
% @filterClass = 0 : FIR , @filterClass = 1 : IIR

Fm = sampleRate/2; % Nyquist Freq

if(filterClass == 0) % FIR
    [b, a] = fir1(order, Fc/Fm, 'low');
    [b, a] = eqtflength(b, a);
elseif(filterClass == 1) % IIR
    [b, a] = butter(order, Fc/Fm, 'low');
    [b, a] = eqtflength(b,a);
end

end
