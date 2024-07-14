clear all; close all; clc;

% Get the arguments
para = pulsepara();
Img = double(imread(para.images));

cardMiss = length(para.missingPixelsRatio);
fp = fopen('vecorDiffspResultMTV.txt','at+');
fp1 = fopen('vecorDiffspPSNRMTV.txt','at+');
fp2 = fopen('vecorDiffspSSIMMTV.txt','at+');
fp3 = fopen('vecorDiffspFSIMMTV.txt', 'at+');
fprintf(fp, '%-15s', para.imgName);
fprintf(fp1,'%-15s', para.imgName);
fprintf(fp2,'%-15s', para.imgName);
fprintf(fp3,'%-15s', para.imgName);

for k = 1:cardMiss
    [noisyImg, maskImg] = addnoise(Img, para.isCouplingNoise, para.isSaltandPepers, para.missingPixelsRatio(k), para.initalState);
    
    detectMask =  zeros(size(Img));    
    for ka = 1:3
        componentNoise = noisyImg(:,:,ka);
        detectMask(:, :, ka) = detectnoise(componentNoise, para.thrVal, para.numThr, para.patchSize, para.isSaltandPepers, para.T1, para.T2);
    end    
    
    resultImg = vectorDiffusion(noisyImg, para.timestep, para.iteration, detectMask);

    PSNR   = hyCSNR(Img, resultImg, 0, 0);
    SSIM   = hyMetricSSIM(Img, resultImg, 0, 0);
    [FSIM, FSIMc] = FeatureSIM(Img, resultImg);

    imwrite(uint8(resultImg), strcat('.\outimages\', 'vectorDiff-', para.imgName, num2str(para.missingText(k)), '.png'));
    
    fprintf(fp, '%7.2f/%-7.2f/%-7.2f', PSNR, SSIM, FSIMc);
    fprintf(fp1, '%9.2f', PSNR);
    fprintf(fp2, '%9.2f', SSIM);  
    fprintf(fp3, '%9.2f', FSIMc);
 end
fprintf(fp,'\n'); fprintf(fp1,'\n'); fprintf(fp2,'\n'); fprintf(fp3,'\n');
fclose(fp);       fclose(fp1);       fclose(fp2);       fclose(fp3);  

