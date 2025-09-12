function save_randSeed_feat(projFtrDim,randSeed, dataset_name,flag_norm)

% clear all;  
rng(randSeed); 
alldata = data_load(dataset_name);

%--train data--%
trainFeatures = (alldata.trainFeatures); 
numOfFeatures = size(trainFeatures,2);

% random proj  
globalProjMatFtr = normrnd(0,1,projFtrDim,numOfFeatures); 

% ----test data -- % 
testFeatures = alldata.testFeatures;
%--power norm ---%
if flag_norm ==1
    trainFeatures = trainFeatures.^0.5;
    testFeatures = testFeatures.^0.5;     
end
%% Random Projection Step
trainFeatures = trainFeatures*globalProjMatFtr'; 
trainFeatures = normDenseFtrs(trainFeatures); 
testFeatures = testFeatures*globalProjMatFtr';
testFeatures = normDenseFtrs(testFeatures); 
clear globalProjMatFtr;
% ---- %
clear alldata;
name_tr = [num2str(dataset_name) '_learn_proj_norm_' num2str(projFtrDim) '_' num2str(randSeed) '.fvec'];
name_te = [num2str(dataset_name) '_query_proj_norm_' num2str(projFtrDim) '_' num2str(randSeed) '.fvec'];
writeFvecFile(name_tr,trainFeatures');
writeFvecFile(name_te, testFeatures');

end
