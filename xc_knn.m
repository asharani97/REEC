clear; clc; close all;

projFtrDim = 1000;         
randSeed = 1;            
K = 100;          
gamma_val = 10;  % = 2 x actual_gamma          

rng(randSeed); 
alldata = load('Wiki_10k_original.mat'); %change based on dataset
% ---- % 
trainFeatures = alldata.trainFeatures; 
numOfFeatures = size(trainFeatures,2);

% random proj  
globalProjMatFtr = normrnd(0,1,projFtrDim,numOfFeatures); 
numOfTrainSamples = size(trainFeatures,1); 

% ----test data -- % 
testFeatures = alldata.testFeatures;

numOfTestSamples = size(testFeatures,1); 

%PowerNorm of data
trainFeatures = trainFeatures.^0.5;
testFeatures = testFeatures.^0.5; 

%% Random Projection Step
% ---- % 
trainFeatures = trainFeatures*globalProjMatFtr'; 
trainFeatures = normDenseFtrs(trainFeatures); 
testFeatures = testFeatures*globalProjMatFtr'; 
testFeatures = normDenseFtrs(testFeatures); 
clear globalProjMatFtr;
% ---- %
trainLabels = alldata.trainLabels; 
numOfLabels = size(trainLabels,2); 

% ---- % 
disp(['Perform kNN -- K=' num2str(K)]); 


allCurrTrainIndxSim = zeros(numOfTestSamples, K);
knn_neighbour = zeros(numOfTestSamples, K);
allTrainIndx = [1:numOfTrainSamples]'; 

predScores = sparse(numOfLabels,numOfTestSamples); 
tic;
for i = 1:numOfTestSamples
    currTrainIndxSim = [allTrainIndx trainFeatures*testFeatures(i,:)'];
    currTrainIndxSim = sortrows(currTrainIndxSim,-2);
    currTrainIndxSim = currTrainIndxSim(1:K,:);
    currTrainIndxSim(:,2) = exp(gamma_val*(currTrainIndxSim(:,2)-1));
    predScores(:,i) = (sparse(sum(trainLabels(currTrainIndxSim(1:K,1),:).*currTrainIndxSim(1:K,2)) ))';  

    %to save knn and similarity scores
    %knn_neighbour(i,:) = currTrainIndxSim(:,1)';
    %allCurrTrainIndxSim(i,:) = currTrainIndxSim(:,2)';    
end
predTime = toc; 

disp(['Prediction time = ' num2str(predTime)]);

% ---- % 
% Evaluate performance 

% Add path for the evaluation codes downloaded from http://manikvarma.org/downloads/XC/XMLRepository.html 
% Please compile them before use. 

addpath('~/XMLPerf_eval/'); 
addpath('~/XMLPerf_eval/Tools/'); 

A = 0.5; B = 2.6;

testLabels = alldata.testLabels;
clear alldata;

trainPropWeights = inv_propensity(spones(trainLabels)',A,B); 

 
tic; 

metrics = get_all_metrics(predScores,testLabels',trainPropWeights); 

disp('Prec@1--5'); 
disp(num2str(metrics.prec_k')); 
disp('nDCG@1--5'); 
disp(num2str(metrics.nDCG_k')); 
disp('PSPrec@1--5'); 
disp(num2str(metrics.prec_wt_k')); 
disp('PSnDCG@1--5'); 
disp(num2str(metrics.nDCG_wt_k')); 
evalTime = toc; 
