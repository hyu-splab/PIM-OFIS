# On-the-Fly host-PIM Interaction Scheme (OFIS)
On-the-Fly host-PIM Interaction Schenme (OFIS) that enables PIM applications to use an on-demand data assignment policy, overcoming the constraints of the programming model.
We provide various APIs to facilitate the development of OFIS-enabled applications.

# Overview
This repository includes two applications that demonstrates OFIS capabilities:
1. **PR** (Page Rank graph algorithm)
2. **SpMV** (Sparse Matrix-Vector Multiplication)
Each application provides multiple implementations to compare OFIS against the UPMEM SDK baseline.

## Experimental Environment
- UPMEM PIM DIMMs (paper setup: 10 DIMMs)
- 2-Intel Xeon Gold 6226R CPU
- 256-GB DRAM, 10-PIM DIMMs
- Ubuntu 20.04.6 LTS
- UPMEM SDK ver 2024.2.0 (you can install from `https://sdk.upmem.com/2024.2.0/01_Install.html`)
- **Ensure >= 200 GB of free disk space before running the download.**

## Files
- sdk/      # Modified SDK for OFIS
- SpMV/     # source code for OFIS-enabled spmv
- PageRank/ # source code for 
- README.md # readme file for using OFIS code
- download_dataset.sh
- exp_all.sh   
- gnuplot-script.plt

## Setup & Build OFIS-enabled SDK
```bash
cd sdk/upmem-2024.2.0-Linux-x86_64/
source ./upmem_env.sh                                            
echo $UPMEM_HOME           
cd $UPMEM_HOME/src/backends # sdk/upmem-2024.2.0-Linux-x86_64/src/backends
./load.sh                 
cd $UPMEM_HOME/lib
ln -sfn libdpu.so.0.0 libdpu.so
```
The `upmem_env.sh` script must be sourced in every new terminal session (or add it to your shell profile) before building or running applications.
To use OFIS-api, you must run `load.sh`

## Download Dataset for test
```bash
./download_dataset.sh
```
After download, datasets are placed under `PageRank/dataset` and `SpMV/dataset`
**Note: Ensure >= 200 GB of free disk space before running the download.**

## Experiments (How to Run)
1. PageRank
```bash
cd PageRank
./pg_test_all.sh
```
Raw results: `PageRank/results/...`
Organized results: `PageRank/figures/...`

2. SpMV
```bash
cd SpMV
./spmv_test_all.sh
```
Raw results:
- `SpMV-OFIS/results/...` (IG-unit, Rank-unit)
- `SparseP-ES/results/...`
- `SparseP-EW/results/...`
Organized results: `SpMV/figures/...`

3. Run All
```bash
./exp_all.sh
```
Runs all experiments and generates plots(eps) under `graphs/`