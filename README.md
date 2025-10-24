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
- sdk/      # SDK includes OFIS-API
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

## OFIS-API
OFIS-APIs are packed in libdpu.so
- Rank-unit DPU Management
    - `OFIS_get_rank()` returns a virtual DPUset containing only the specified rank.
    - `OFIS_dpu_launch()` boots DPUs in a givnen rank w/o Polling threads
    - `OFIS_parallel_exec()` create and execute per-rank OFIS threads, in parallel
- DPU Monitoring
    - `OFIS_get_finished_dpu()`
    - `OFIS_get_finished_ig()`
    - `OFIS_get_finished_rank()`
    Monitoring DPU state by using direct WRAM access to bypass Job threads and reduce overhead
- Binary Triggering
    - `OFIS_set_state_dpu()`
    - `OFIS_set_state_ig()`
    - `OFIS_set_state_rank()`
    set OFIS state value, implemented via direct WRAM access
- MUX control for M-OFIS
    - `OFIS_set_mux_ig()`
    - `OFIS_set_mux_rank()`
    switch MUX to access MRAM for an IG or Rank-unit
- Multi-granular Data Transfers
    - `OFIS_prepare_xfer_dpu()`
    - `OFIS_prepare_xfer_ig()`
    alloc buffers **only** to marked DPUs/IGs
    Then transfer data with standard parallel trasnfer API (`dpu_push_xfer()`)
By parallelizing the aggregation of interim results and re-transfering data, OFIS can reduce overhead

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
./pg_test_all.sh $(num_iter) # e.g. ./pg_test_all.sh 1
```
Raw results: `PageRank/results/...`
Organized results: `PageRank/figures/...`


2. SpMV
```bash
cd SpMV
./spmv_test_all.sh $(num_iter) # e.g. ./spmv_test_all.sh 1
```
Raw results:
- `SpMV-OFIS/results/...` (IG-unit, Rank-unit)
- `SparseP-ES/results/...`
- `SparseP-EW/results/...`
Organized results: `SpMV/figures/...`

3. Run All
```bash
./exp_all.sh $(num_iter) # e.g.. ./exp_all.sh 1
```
Runs all experiments and generates plots(eps) under `graphs/`