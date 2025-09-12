function xc_modified_knn(K, gamma, dataset_name)


alldata = data_load(dataset_name);
testFeatures = alldata.testFeatures;
numOfTestSamples = size(testFeatures,1); 

% ---- %
trainLabels = alldata.trainLabels; 
numOfLabels = size(trainLabels,2); 
clear alldata testFeatures;

% ---- % 

disp(['Perform kNN -- K=' num2str(K)]); 

predScores = sparse(numOfLabels,numOfTestSamples); 

%Load KNN and Similarity scores
knn_neighbour = read_matrices_gt("DiskANN/build/KNNs.txt",numOfTestSamples);
allCurrTrainIndxSim = read_matrices_gt("DiskANN/build/dist_score.txt",numOfTestSamples);

allCurrTrainIndxSim = exp(gamma*(allCurrTrainIndxSim-1));    % applying kernel function on cosine distances

tic;
for i = 1:K
    currAllKnns = knn_neighbour(:,i)+1;  %add 1 here
    predScores = sparse(predScores + sparse((trainLabels(currAllKnns, :) .* allCurrTrainIndxSim(:, i))'));
end 
predTime = toc; 
% ---- % 
disp(['Prediction time = ' num2str(predTime)])

clearvars -except predScores dataset_name;

% Evaluate performance 

% Add path for the evaluation codes downloaded from http://manikvarma.org/downloads/XC/XMLRepository.html 
% Please compile them before use. 

addpath('XMLPerf_eval/'); 
addpath('XMLPerf_eval/Tools/'); 


A = 0.5; B = 2.6;

alldata = data_load(dataset_name);
trainLabels = alldata.trainLabels;
testLabels = alldata.testLabels;
clear alldata;

trainPropWeights = inv_propensity(spones(trainLabels)',A,B); 

clear trainLabels;


metrics = get_all_metrics(predScores,testLabels',trainPropWeights); 

disp('Prec@1--5'); 
disp(num2str(metrics.prec_k')); 
disp('nDCG@1--5'); 
disp(num2str(metrics.nDCG_k')); 
disp('PSPrec@1--5'); 
disp(num2str(metrics.prec_wt_k')); 
disp('PSnDCG@1--5'); 
disp(num2str(metrics.nDCG_wt_k')); 
 
end
