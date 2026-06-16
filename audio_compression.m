% Set MATLAB's working directory to the repo root before running.

% Code I — Basic Audio Operations (illustrative; uncomment individual sections to run)
[sis, fs] = audioread('audio1.wav');
% % 1 — Playback at different speeds
% sound(sis, fs);    % Normal (1x)
% sound(sis, fs*2);  % Fast (2x)
% sound(sis, fs/2);  % Slow (0.5x)
%
% % 2 — Time-domain plot
% time = (1/fs) * length(sis);
% t = linspace(0, time, length(sis));
% plot(t, sis, 'k');
%
% % 3 — Reversal
% rev_b = flipud(sis);
% sound(rev_b, fs);
% soundsc(rev_b, fs);
% b = sis(1:fs*10);
% rev_b = flipud(b);
% time = (1/fs) * length(b);
% t = linspace(0, time, length(b));
%
% % 4 — Echo effect
% nSec = 2;
% b = sis(1:fs*nSec);
% b_echo = b;
% N = fs/2;
% for n = N+1:length(b)
%     b_echo(n) = b(n) + b(n-N);  % add N-sample delayed copy
% end
% time = (1/fs) * length(b);
% t = linspace(0, time, length(b));
% plot(t, b, 'k', t, b_echo, 'r');
% xlabel('Time (sec)');
% ylabel('Signal Strength');
% title('Echo Effect');

% Code II — FFT-Based Compression
[x, fs] = audioread('audio1.wav');
N = length(x);
vlcplayer = audioplayer(x, fs);
vlcplayer.play()

% Frequency spectrum of original signal
t = fft(x, N);
X = fftshift(t);
f = -fs/2 : fs/N : (fs/2 - fs/N);
figure(1)
plot(f, abs(X))
title('Original Signal')
xlabel('Freq (Hz)'); ylabel('Magnitude');

% % 30% compression — zeroes outer 30% of frequency bins, retains centre 70%
% Xr = zeros(1, N);
% Xr((N*((30/100)/2))+1 : N*(1-(30/100)/2)) = X((N*((30/100)/2))+1 : N*(1-(30/100)/2));
% figure(2)
% plot(f, abs(Xr));
% xr = real(ifft(fftshift(Xr)));
% audiowrite('audio1_30pct_compressed.wav', xr, fs);
% title('30% Compressed')
% xlabel('Freq (Hz)'); ylabel('Magnitude');

% % 60% compression — zeroes outer 60% of frequency bins, retains centre 40%
% Xr = zeros(1, N);
% Xr((N*((60/100)/2))+1 : N*(1-(60/100)/2)) = X((N*((60/100)/2))+1 : N*(1-(60/100)/2));
% figure(3)
% plot(f, abs(Xr));
% xr = real(ifft(fftshift(Xr)));
% audiowrite('audio1_60pct_compressed.wav', xr, fs);
% title('60% Compressed')
% xlabel('Freq (Hz)'); ylabel('Magnitude');

% 90% compression — zeroes outer 90% of frequency bins, retains centre 10%
Xr = zeros(1, N);
Xr((N*((90/100)/2))+1 : N*(1-(90/100)/2)) = X((N*((90/100)/2))+1 : N*(1-(90/100)/2));
figure(4)
plot(f, abs(Xr));
xr = real(ifft(fftshift(Xr)));
audiowrite('audio1_90pct_compressed.wav', xr, fs);
title('90% Compressed')
xlabel('Freq (Hz)'); ylabel('Magnitude');
