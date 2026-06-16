# Audio Signal Processing and Compression

![MATLAB](https://img.shields.io/badge/MATLAB-R2012b%2B-0076A8?logo=mathworks&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green)
![Repo Size](https://img.shields.io/github/repo-size/archiskhuspe/audio-signal-processing-compression)

A MATLAB script demonstrating core audio signal processing concepts and lossy frequency-domain compression using the FFT.

---

## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [How It Works](#how-it-works)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Limitations](#limitations)
- [License](#license)

---

## Features

- Playback of a WAV file at normal, double, and half speed
- Time-domain plotting of the audio signal
- Audio reversal and echo-effect generation
- FFT-based lossy compression at 30%, 60%, and 90% reduction
- Frequency-spectrum plots before and after compression
- Export of compressed audio as a new WAV file

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| MATLAB (R2012b or later) | Core runtime — no additional toolboxes required |
| `audioread` / `audiowrite` | WAV file I/O (base MATLAB) |
| `fft` / `ifft` / `fftshift` | Frequency-domain transforms (base MATLAB) |
| `audioplayer` / `sound` | Audio playback (base MATLAB) |

---

## How It Works

### Code I — Basic Audio Operations

Demonstrates fundamental signal manipulation (all sections are commented out by default; uncomment to run):

1. **Speed control** — plays the signal at 1×, 2×, and 0.5× by scaling the sample rate.
2. **Time-domain plot** — plots amplitude vs. time.
3. **Reversal** — flips the sample array with `flipud`.
4. **Echo effect** — adds a half-second delayed copy of each sample to itself, building a simple feedback echo.

### Code II — FFT Compression

1. Reads `audio1.wav` and computes the N-point FFT.
2. Shifts the spectrum so DC is centred (`fftshift`).
3. Plots the original frequency spectrum (magnitude).
4. **Compression** — creates a zeroed-out copy of the spectrum, then copies only the centre _k_% of frequency bins back in. This discards high-frequency energy, equivalent to aggressive low-pass filtering.
   - 30% compression → keeps centre 70% of bins
   - 60% compression → keeps centre 40% of bins
   - 90% compression → keeps centre 10% of bins *(active by default)*
5. Applies inverse FFT (`ifft`) and writes the real part to a new WAV file.

---

## Prerequisites

- MATLAB R2012b or later (base installation — no toolboxes required)

---

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/archiskhuspe/audio-signal-processing-compression.git
   cd audio-signal-processing-compression
   ```

2. Open MATLAB and set the working directory to the repo root:
   ```matlab
   cd('/path/to/audio-signal-processing-compression')
   ```

3. Run the script:
   ```matlab
   run('audio_compression.m')
   ```

4. Expected outputs:
   - **Figure 1** — frequency spectrum of the original signal
   - **Figure 4** — frequency spectrum after 90% compression
   - `audio1_90pct_compressed.wav` — the compressed audio file

To try 30% or 60% compression instead, uncomment the relevant block in `audio_compression.m` and comment out the 90% block.

---

## Project Structure

```
audio-signal-processing-compression/
├── audio_compression.m       # Main MATLAB script
├── audio1.wav                # Sample input audio file
├── project_report.pdf        # Written project report
├── LICENSE
└── README.md
```

---

## Limitations

- **Simplistic compression model** — zeroing FFT magnitude bins is a crude form of low-pass filtering, not a perceptual codec (no psychoacoustic model, no entropy coding). File size on disk is not reduced; only signal fidelity is degraded.
- **Single test file** — only validated on `audio1.wav`; stereo or high-sample-rate files may require index adjustments.
- **No quantitative evaluation** — no SNR or PESQ metrics were computed to measure compression quality objectively.
- **Code I is illustrative** — the basic-operations section is commented out and provided for reference only; it is not part of the compression pipeline.
- **Phase artefacts** — `real(ifft(...))` discards any residual imaginary component from floating-point rounding; this is standard practice but may introduce very minor artefacts on asymmetric spectra.

---

## License

Released under the [MIT License](LICENSE).
