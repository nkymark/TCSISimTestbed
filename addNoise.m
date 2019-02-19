% Adds white Gaussian signal noise to sensor measurements. 
%
%           y = addNoise( u, SNR )
% 
% 
% This function adds white Gaussian noise to the signal 'u' with a signal-to-noise ratio of SNR, 
% which is measured in dB. The resultant output is the signal 'y'.
% 
% (C) Mark Ng, 2019
% Ulster University, UK
%
function y = addNoise( u, SNR )
    rng default;              
    signalSize = length( u );
    SNR        = 10^( SNR/10 ); 
    eSym       = sum( abs( u ).^2 ) / signalSize;
    NSD        = eSym / SNR;
    if isreal( u )
        noiseSigma  = sqrt( NSD );
        noiseSignal = noiseSigma * randn( 1, signalSize );
    else
        noiseSigma  = sqrt( NSD / 2 );
        noiseSignal = noiseSigma * ( randn( 1, signalSize ) + 1i * randn( 1, signalSize ) );
    end    
    y = u + noiseSignal';
end

%-------------------------------------------------------------------------%