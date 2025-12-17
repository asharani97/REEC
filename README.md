# REEC: Random Embeddings for Extreme Classification

> **Official Implementation** of the paper **"Random feature embeddings give strong baselines for extreme multi-label text classification"**, published in the *International Journal of Data Science and Analytics (2026)*.

This repository contains the official code for **REEC**, a simple yet powerful baseline technique for Extreme Multi-label Text Classification (XMTC).

[![Paper](https://img.shields.io/badge/Paper-Springer-blue)](https://doi.org/10.1007/s41060-025-00949-y)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

***

## 🛠️ Installation & Requirements

The implementation relies on a hybrid pipeline using **Linux**, **C++**, and **MATLAB**.

### Prerequisites
- **Linux** (Ubuntu 22.04 used)
- **C++ Compiler**
- **MATLAB**
- **DiskANN** (Requires CMake, optional if using `xc_knn.m`)

### Setup DiskANN
We use [DiskANN](https://github.com/microsoft/DiskANN/tree/main) for efficient kNN search in the main pipeline.

To install the required version of **cmake**:
1. Download `cmake-3.30.0-linux-x86_64.sh` from [cmake.org](https://cmake.org/download/).
2. Run the following commands:
   ```bash
   chmod +x cmake-3.30.0-linux-x86_64.sh
   ./cmake-3.30.0-linux-x86_64.sh
   ```

The `DiskANN` folder needs to be built. This step is **already handled** inside the `run_xc.sh` script.


## 📂 Data Preparation

The code is designed to work with datasets from the [Extreme Classification Repository](http://manikvarma.org/downloads/XC/XMLRepository.html).

1.  **Download** your desired dataset (e.g., `Wiki10-31K`).
2.  **Format:** Ensure the dataset is in the `.mat` format expected by the script.
      * **Conversion Tool:** You can use the provided script `convert_sparse_txt_to_mat.m` to convert sparse text files into the required `.mat` format.
3.  **Placement:** Place the dataset file (e.g., `Wiki_10k_original.mat`) in the root directory.

OR
4.  Download our **pre-processed .mat files here [Download via Google Drive](https://drive.google.com/drive/folders/1snqdpwbfDJYsbtHORMHVgeOEp0K8f-v6?usp=sharing)**.
*For reference to the exact filenames and variable names required, please check `data_load.m`.*

-----

## 🚀 Usage

### Option 1: Full Pipeline 

To run the complete pipeline (Feature Projection → Index Building → Search → Evaluation) using DiskANN, run the master script:

```bash
bash run_xc.sh
```

This script runs the code on the **Wiki10-31K** dataset by default.

### Option 2: Simple Version (Without DiskANN)

If you prefer not to use DiskANN, we provide a standalone MATLAB version that uses standard kNN:

  * **Script:** `xc_knn.m`
  * **Usage:** Open MATLAB and run `xc_knn.m`. This version does not require the C++ DiskANN build steps.

### Customization

To use another dataset, modify the `dataset_name` variable inside `run_xc.sh`:

```bash
# Variables in run_xc.sh
dataset_name='YourDatasetName' # Update this to match your .mat file
```

-----

## 📝 Citation

If you use this code or paper in your research, please cite:

```
Rani, A., Dutt, R. & Verma, Y. Random feature embeddings give strong baselines for extreme multi-label text classification. Int J Data Sci Anal 21, 27 (2026). https://doi.org/10.1007/s41060-025-00949-y
```

## Acknowledgment

We use the **DiskANN** code to calculate k-Nearest Neighbors. We thank the authors of DiskANN for open-sourcing their efficient implementation.

## 📬 Contact

For any queries regarding the code, please contact:

  * **Asha Rani**: [rani.1@iitj.ac.in](mailto:rani.1@iitj.ac.in)

