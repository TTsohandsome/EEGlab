在运行PlotFigure.m之前要先运行根目录下的installer.m
在运行PlotAccuracy.m之前要先运行eeglab/eeglab.m

This folder contains 22 functions. Install the following libraries before running the function.

Install MATLAB library:
	https://sccn.ucsd.edu/eeglab/index.php

Install Covariance Toolbox：
	https://github.com/alexandrebarachant/covariancetoolbox

Usage:	
	Running the "PlotFigure.m" function to plot ERP、TimeFrequency and BEAM figure

	Running the "PlotAccuracy.m" function to calculate classification accuracy



List of functions:

	BandpassFilter.m: This function is BandPass Filter function. [Y] = BandpassFilter(X,Fs,Fl,Fh,N,type).

	NotchFilter.m: This function is Notch filter function. [Y] = NotchFilter(X,Fs,Fa).

	filter_param.m：This function is Filter function. filterdata=filter_param(data,low,high,sampleRate,filterorder)
	
	FFT2.m: Fourier transform algorithm, [Y] = FFT2(X, Fs)
	
	CSP.m: Common Spatial Pattern, [cspfeature, cspw] = CSP(eeg,label,m)

	CSPFilter.m: Extract features from an EEG data set using the Common Spatial Patterns (CSP) algorithm, features = CSPFilter(eeg,cspw,csp_para)

	CSP_LDA.m: Common Spatial Pattern + Linear Discriminant Analysis, [acc,left_num,right_num] = CSP_LDA(MIEEGData,label,Fs,LowFreq,UpFreq)

	FBCSP.m:Call the function FBCSP, perform CSP for each frequency band in the bands, and then concatenate features.[fbcspfeature,fbcspw] = FBCSP(eeg,label,m,bands,fs,filterorder)

	FBCSPFilter.m: extract features from an EEG data set using the Filter Bank Common Spatial Patterns (CSP) algorithm. features = CSPFilter(eeg,cspw,csp_para)

	FBCSP_SVM.m: Filter Bank Common Spatial Pattern + Support Vector Machine, [acc,left_num,right_num] = FBCSP_SVM(MIEEGData,label,Fs,LowFreq,UpFreq)

	TSLDA_DGFMDM.m: Tangent Space Linear Discriminant Analysis +  Fisher discriminan geodesic filtering followed by MDRM classification. [acc,left_num,right_num] = TSLDA_DGFMDM(MIEEGData,label,Fs,LowFreq,UpFreq)

	TWFB_DGFMDM.m:  the optimal time window and filter bank with theFisher discriminan geodesic filtering followed by MDRM classification. [acc,left_num,right_num] = TWFB_DGFMDM(MIEEGData,label,Fs,LowFreq,UpFreq)

	plotERDERS.m, PlotEvent.m, PlotERP.m: plot ERD/ERS image

	PlotTimeFrequency.m:plot time-frequency mapping, PlotTimeFrequency(data,label,Fs,LowFreq,HighFreq)

	PlotBEAM.m:plot brain electrical activity mapping, PlotBEAM(MIEEGData,label,Fs,LowFreq,HighFreq)

	PlotConfusionMatrix.m: plot the confusion matrix figure, PlotConfusionMatrix(data)

	CalEvaluateIndex.m: calaulate the classification method index, [Kappa,Sensitivity,Precision] = CalEvaluateIndex(data)























	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	