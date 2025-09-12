#!/bin/bash
#Step 1 : Loading and processing of feature set
# Variables
projFtrDim=1000
randSeed=1
dataset_name='wiki10k'
flag_norm=1
K=15
gamma=20


echo "Running MATLAB script to save projected feature set based on the random seed"
matlab -nodisplay -r "try, save_randSeed_feat($projFtrDim, $randSeed, '$dataset_name', $flag_norm); catch ME, disp(ME.message); end; exit;"


# Step 2: Change directory and process .fvec file to .fbin
cd DiskANN
#Before that we need to compile DiskANN folder
mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make -j 
echo "-------------------------- Build Complete --------------------------------"
cd build
./apps/utils/fvecs_to_bin float ../../${dataset_name}_learn_proj_norm_${projFtrDim}_${randSeed}.fvec ${dataset_name}_learn_proj_norm_${projFtrDim}_${randSeed}.fbin
./apps/utils/fvecs_to_bin float ../../${dataset_name}_query_proj_norm_${projFtrDim}_${randSeed}.fvec ${dataset_name}_query_proj_norm_${projFtrDim}_${randSeed}.fbin 


# Step 3: Computing KNN and Similarity Score
echo "Computing KNN and Similarity Score"
./apps/utils/compute_groundtruth --data_type float --dist_fn mips --base_file ${dataset_name}_learn_proj_norm_${projFtrDim}_${randSeed}.fbin --query_file ${dataset_name}_query_proj_norm_${projFtrDim}_${randSeed}.fbin --gt_file ${dataset_name}_query_learn_gt25 --K 25


# Step 4
echo "Prediction Score Calculation and Evaluation"
cd ../../
matlab -nodisplay -r "try, xc_modified_knn($K,$gamma,'$dataset_name'); catch ME, disp(ME.message); end; exit;"

echo "Completed."

