# LRII

# 3D Simulation of ZTE Dead-Time Gap Infilling

This repository contains a full 3D simulation of the ZTE dead-time gap infilling.

## Methods and Dependencies

### Stoch Olejniczak Method
The method can be found [here](https://github.com/curtcorum/missing_points_phase?tab=readme-ov-file). Note that their license prohibits the distribution of any modifications, so the modified code is not included in this repository.

### CG SENSE Method
The CG SENSE method was downloaded from [gpuNUFFT](https://github.com/andyschwarzl/gpuNUFFT). Specifically, the script used is [cg_sense_3d.m](https://github.com/andyschwarzl/gpuNUFFT/blob/350fc322ce0e259efc8b1dfd49e7339163ca7f2f/matlab/demo/utils/cg_sense_3d.m#L4).

### ESPIRiT
You may also need to install BART for ESPIRiT. Installation instructions can be found [here](https://mrirecon.github.io/bart/).

### ZINFANDEL
An implementation of ZINFANDEL is included in this repository. The original version can be found [here](https://github.com/spinicist/riesling).

### NUFFT Operators
NUFFT operators were downloaded from [nufft_3d](https://github.com/marcsous/nufft_3d). No installation is needed; simply place the folder under this directory, and it should work.

### Parallel MATLAB Files
Some files from the parallel repository (e.g., `pcgpc`, `pcgL1`, `DWT`) are needed. They can be found [here](https://github.com/marcsous/parallel).

## Installation and Setup
1. Download the required repositories and scripts as mentioned above.
2. Place the NUFFT operators folder in this directory.
3. Ensure that the required parallel MATLAB files are in the MATLAB path.
4. Follow the installation instructions for BART if using ESPIRiT.

For any issues or questions, feel free to open an issue in this repository.

![Gap size 2 snr 10](gap_size_2_snr10.jpg)
![Gap size 3 snr 10](gap_size_3_snr10.jpg)
