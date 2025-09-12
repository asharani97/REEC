# REEC: Random Embeddings for Extreme Classification

## Requirements
- Linux  
- C++  
- MATLAB  

## DiskANN
We use [DiskANN](https://github.com/microsoft/DiskANN/tree/main) to calculate kNN.  
DiskANN requires **cmake**.  

To install cmake:  
Download `cmake-3.30.0-linux-x86_64.sh` from [cmake.org](https://cmake.org/download/) and run:  
```bash
chmod +x cmake-3.30.0-linux-x86_64.sh
./cmake-3.30.0-linux-x86_64.sh
````

The `DiskANN` folder needs to be built. This step is already handled inside the script.

## Usage

Run:

```bash
bash run_xc.sh
```

This script runs the code on the **Wiki10-31K** dataset.
All steps are included in the script.

**Using Other Datasets**
To use another dataset, change the dataset_name variable in run_xc.sh.
For reference to the exact filenames, see data_load.m.

## Acknowledgment

We use **DiskANN** code to calculate kNN.

## Citation

Our paper describing this work has been accepted (venue details will be updated once published).
Citation information will be added here when available.
