# Official repository of the sub-challenge 1 of the MEMENTO White Matter challenge (ISBI 2020)
This repository contains files used for preparation and evaluation of the sub challenge 1 of the MEMENTO challenge (https://my.vanderbilt.edu/memento/). The results of the challenge are now published on NeuroImage, see [De Luca et al. 2020](https://www.sciencedirect.com/science/article/pii/S1053811921006431).
This repository contains the data of the challenge as well as evaluation scripts to serve as benchmark for future methods (see [EvaluateSubmissions.m).

# What can be found here?
- The provided (training) and unprovided (prediction) signals acquired with PGSE, DDE and DODE can be found in the *Provided* and *Unprovided* folders, respectively. 
- The signals are located in the files (PGSE_shells/PGSE_grids/DDE/DODE)_(provided/unprovided)_signals.txt. These are plain text files that can be opened, for example, using the *load* command of MATLAB. Each column represents one of the 5 signals, and each row is a measurement.
- The acquisition parameters are located in the files Unprovided/(PGSE/DDE/DODE)_acq_params.txt. A description of each column of the file can be found in the corresponding file Unprovided/(PGSE/DDE/DODE)_ProtocolDescription.txt. Each row represents a diffusion weighted measurement. MATLAB users can use the function *ISBI_LoadSubchallenge1Description.m* to load the measurements description organised in a structure object. 

# The challenge continues
- New predictions can be evaluated using the MATLAB script *EvaluateSubmission.m*. We have no short term plans to convert this script to other languages, but would appreciate if anybody who succeeds in this task would consider sharing the code on this repository.  

# The MEMENTO challenge
Challenge organizers: 
- Bennett A Landman (Vanderbilt University)
- Adam W Anderson (Vanderbilt University)
- Mark Does (Vanderbilt University)
- Kurt Schilling (Vanderbilt University)
- Vishwesh Nath (Vanderbilt University)
- Alexander Leemans (University Medical Center Utrecht)
- Alberto De Luca (University Medical Center Utrecht)
- Daniel Alexander (University College London)
- Tim Dyrby (Danish Research Centre for Magnetic Resonance)
- Martijn Froeling (University Medical Center Utrecht)
- Andrada Ianus (University College London)
- Marco Palombo (University College London)
- Andrada Ianus (University College London)
- Dmitry Novikov (NYU Langone Health)
- Noam Shemesh (Champalimaud Centre for the Unknown)
- Hong-Hsi Lee  (NYU Langone Health)
- Els Fieremans (NYU Longone Health)

The MEMENTO White Matter reconstruction challenge was announced at ISBI 2019 in Venice (April 11 2019). The white matter reconstruction challenge is composed of 4 subchallenges, based on 4 datasets reflecting the same (or similar) underlying biology. We aim to evaluate the ability to predict unseen signal (signal representation; sub-challenge #1), to estimate microstructural measures (signal modeling; sub-challenge #2 and sub-challenge #4), and evaluate sensitivity and specificity of potential biomarkers (biomarker evaluation; sub-challenge #3).

# Sub-challenge 1 - The signal forecast: generalizability of diffusion signal representations
Sub-challenge organizers:
- Alberto De Luca (University Medical Center Utrecht)
- Andrada Ianus (University College London)
- Kurt Schilling (Vanderbilt University)
- Bennett A Landman (Vanderbilt University)
- Alexander Leemans (University Medical Center Utrecht)
- Daniel Alexander (University College London)
- Martijn Froeling (University Medical Center Utrecht)
- Marco Palombo (University College London)
- Noam Shemesh (Champalimaud Centre for the Unknown)
## Purpose and relevance of the challenge

With this challenge we aim to understand the current ability of the field at describing the signal measured in diffusion MRI. The challenge consists of a number of signals sampled from datasets acquired in human and mice with different diffusion sequences. Participants will be provided with a subsampled set of the acquired data and are asked to predict the remaining – unseen – data. The acquired data includes different types of acquisition strategies, such as multi-shell and DSI-like pulsed gradient spin-echo (PGSE) [1], as well as double diffusion encoding (DDE) [2] and double oscillating diffusion encoding (DODE) [3], suitable for a large number of fit approaches. The outcome of this challenge will allow to objectively evaluate the generalizability and appropriateness of current techniques.

## Datasets

The challenge includes in-vivo brain data sampled with PGSE in a human volunteer, and with DDE / DODE in mice, ex-vivo. You can choose which acquisition you would like to predict, and can choose any or all acquisitions strategies.

The two provided datasets are composed as follows:
- PGSE. A subset of the data measured in five voxels, representative of different tissue configurations, extracted from the MASSIVE dataset4 (3820 unique diffusion-weighted volumes). The signals measured in each voxel include 2580 unique data points acquired with a multi-shell strategy, and 1240 data points acquired with a DSI-like strategy. The two acquisitions were collected in 19 separate sessions. The multi-shell and the DSI-like sequence were NOT performed with identical imaging parameters, but with identical diffusion gradients settings. Participants can choose whether they prefer to work with the multi-shell or the DSI-like acquisition.
- DDE and DODE. A subset of the data from five voxels acquired in a mouse brain, representative of different tissue configurations will be provided. The full dataset consists of DDE with 2 different diffusion times and DODE with 5 different frequencies, with 5 b- values and 72 directions each (2520 diffusion weighted volumes in total).

## Data given to the participants
Participants will be provided with part of the measured signals for 5 different tissue configurations. Additionally, they will receive complete details of the acquisition protocol (imaging parameters, diffusion gradients properties) corresponding to the measured data, including both provided and unseen signals. Regarding multi-shell PGSE, we will provide, for each signal, 495 of the 2580 diffusion-weighted measurements, as well as 20 b = 0s/mm2. Regarding DSI-like PGSE, we provide 480 of the 1240 measured points and 20 b = 0s/mm2. The signals will be distributed in text format in separate files for each acquisition strategy, and do not correspond to the same voxels. For the DDE/DODE data we will provide data from 1 DDE and 3 DODE waveforms with 4 b-values and 72 directions each (1152 / 2520 measurements). Each text file will contain the signal in floating format, with each column representing a different signal, and each row a measurement. The acquisitions details of each measurement can be found in a companion text file “*_AcqParams.txt”. Sample scripts to load the data and the acquisitions details will be provided for popular working environments (MATLAB, Python, C/C++).

## Evaluation

Each submission will be evaluated by computing the weighted averaged mean squared error (MSE) between the provided predictions and the corresponding undisclosed data. Three winners will be selected independently for PGSE (shells and grids will be scored together), DDE and DODE.

## References
- [1] Stejskal, E. O. & Tanner, J. E. Spin Diffusion Measurements: Spin Echoes in the Presence of a Time-Dependent Field Gradient. J. Chem. Phys. 42, (1965).
- [2] Shemesh, N., Özarslan, E., Komlosh, M. E., Basser, P. J. & Cohen, Y. From single-pulsed field gradient to double-pulsed field gradient MR: Gleaning new microstructural information and developing new forms of contrast in MRI. NMR Biomed. 23, 757–780 (2010).
- [3] Ianuş, A. et al. Accurate estimation of microscopic diffusion anisotropy and its time dependence in the mouse brain. Neuroimage 183, 934–949 (2018).
- [4] Froeling, M., Tax, C. M. W., Vos, S. B., Luijten, P. R. & Leemans, A. ‘MASSIVE’ brain dataset: Multiple acquisitions for standardization of structural imaging validation and evaluation. Magn. Reson. Med. 77, 1797–1809 (2017).


