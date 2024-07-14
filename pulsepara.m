function para = pulsepara()
% ================================

para.images = '.\images\pepper.png'; 
para.imgName = 'pepper';
% -----  the arguments which descripts the feature of noise ----------
para.missingPixelsRatio = [0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9];
para.missingText = [5, 10, 20, 30, 40, 50, 60, 70, 80, 90];
% % para.missingPixelsRatio = 0.05;
% % para.missingText = 5;

% ------  parameters to detect    --------
para.patchSize = 5;
para.thrVal = 25;
para.numThr = 3;
para.T1 = 150;
para.T2 = 300;

para.initalState = 2024;
para.isCouplingNoise = 0; % '0' components are not coupled; '1' are coupled 
para.isSaltandPepers = 1; % '1' stands for salt-and-pepper, '0' stands for random impulse.

%  ------ parameters to diffusion  --------
para.timestep=0.5;
para.iteration=1000;
