function [txWaveform,sampleRate,numFrames] = helperPACharGenerateTones()
%helperPACharGenerateTones Generate two complex tones
%   [X,R,N] = helperPACharGenerate5GNRTM generates a two tone waveform,
%   X, at a sample rate of R. N is the suggested number of frames.
%
%   See also PowerAmplifierCharacterizationExample.

%   Copyright 2020-2022 The MathWorks, Inc.

fc1 = 1.8e6;
fc2 = 2.6e6;

numFrames = 30;
sampleRate = 15.36e6;
swg = dsp.SineWave([1 1],[fc1 fc2],...
  'ComplexOutput',true,...
  'SampleRate',sampleRate,...
  'SamplesPerFrame',numFrames*81920);

txWaveform = awgn(sum(swg(),2),30);

overSamplingRate = 7;
filterLength = 6*70;
lowpassfilter = firpm(filterLength, [0 8/70 10/70 1], [1 1 0 0]);
firInterp = dsp.FIRInterpolator(overSamplingRate, lowpassfilter);
txWaveform = firInterp([txWaveform; zeros(filterLength/overSamplingRate/2,1)]);
txWaveform = txWaveform((filterLength/2)+1:end,1);      % Remove transients
sampleRate = sampleRate * overSamplingRate;
