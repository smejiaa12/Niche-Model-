# Niche-Model-

Incorporation of niche information to improve the identifiability of discrete epidemiological models:

This repository contains five folders, each with `.mlx` MATLAB files that implement different heterogeneity scenarios in an epidemiological model, with and without niche information, as well as the homogeneity scenario. Below is a description of each folder's contents and the included files:

## Folder Contents

Each folder contains the following files:

1. **Heterogeneity scenarios with niche information**
   - `HeteroWithInformation.mlx`: Code corresponding to the heterogeneity scenario with niche information.

2. **Heterogeneity scenarios without niche information**
   - `HeteroWithoutInformation.mlx`: Code corresponding to the heterogeneity scenario without niche information.

3. **Homogeneity scenario**
   - `Homogeneous.mlx`: Code corresponding to the homogeneity scenario.
   - `SIR1.m`: Implementation of the epidemiological model used.

4. **Data and parameters**
   - Contains map information and epidemiological data for each case.

5. **Estimation results**
   - Includes the estimation results for each scenario.

## Execution Requirements

To correctly run the codes, it is necessary to:

1. Download all folders and ensure that the files are in the same location.
2. Run each scenario in MATLAB, where uncertainty, sensitivity, and model identifiability analyses can be found, along with the resulting time series.
3. Have the following MATLAB toolbox installed: [GSUA-CSB](https://la.mathworks.com/matlabcentral/fileexchange/72637-gsua-csb).

## Usage Instructions

1. Ensure that MATLAB is installed on your system.
2. Download and install the toolbox [GSUA-CSB](https://la.mathworks.com/matlabcentral/fileexchange/72637-gsua-csb).
3. Open the `.mlx` files in MATLAB and run the scripts to analyze each scenario.
4. Review the analysis results in the corresponding folders.

If you have any questions or encounter any issues, feel free to contact the code author.

DOI:10.5281/zenodo.15078325
[![DOI](https://zenodo.org/badge/950986055.svg)](https://doi.org/10.5281/zenodo.15078324)

