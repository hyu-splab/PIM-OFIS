# On-the-Fly host-PIM Interaction Scheme (OFIS)
On-the-Fly host-PIM Interaction Scheme (OFIS) that enables PIM applications to use an on-demand data assignment policy, overcoming the barrier synchronization of the Bulk-Synchronous Parallel (BSP) programming model used in the current commercial PIM system (UPMEM PIM).

**libofis** provides various APIs to facilitate the development of OFIS-enabled applications.

## APIs for OFIS
libofis, currently integrated with the libdpu.so in the standard UPMEM SDK, provides various APIs to facilitate the development of OFIS-enabled PIM applications:

- APIs for Rank-unit DPU Management
    - `OFIS_get_rank()` returns a virtual DPUset containing only the specified rank.
    - `OFIS_dpu_launch()` boots DPUs in a givnen rank w/o creating Polling threads
    - `OFIS_parallel_exec()` create and execute per-rank OFIS threads, in parallel

- DPU Monitoring APIs: monitor DPU states in a given rank using WRAM Parallel Access feature
    - `OFIS_get_finished_dpu()` returns finished DPUs in a given rank in a bitmap format
    - `OFIS_get_finished_ig()` returns finished IGs (interleaving group) in a given rank in a bitmap format
    - `OFIS_get_finished_rank()` returns 1 only if all DPUs in a given rank have finished

- APIs for DPU Binary Triggering: inform the DPU binary of the future action to take by setting the state variable
    - `OFIS_set_state_dpu()` sets the state variable in a given DPU
    - `OFIS_set_state_ig()` sets the state variables of all DPUs in a given IG
    - `OFIS_set_state_rank()` sets the state variables of all DPUs in a given rank

    DPU Bunary Triggering APIs also use the WRAM Parallel Access feature
- MUX control APIs for MRAM data transfers: set MUX bits in an IG or rank to a specific value
    - `OFIS_set_mux_ig()` allows either CPU or DPU to access MRAMs in a given IG exclusively
    - `OFIS_set_mux_rank()` allows either CPU or DPU to access MRAMs in a given rank exclusively

- APIs for Multi-granular Data Transfers: allocate buffers **only** to specified DPUs/IGs in a rank
    - `OFIS_prepare_xfer_dpu()` prepares a parallel transfer to/from marked DPUs in the bitmap
    - `OFIS_prepare_xfer_ig()` prepares a parallel transfer to/from marked IGs in the bitmap
    
    When the standard parallel transfer API (`dpu_push_xfer()`) is called after allocating buffers using the above APIs, a parallel data transfer is performed only to the specified DPUs or IGs in a rank.

# Example Applications
This repository includes two OFIS-enabled PIM applications to deliver use cases of libofis:
1. **SpMV** (Sparse Matrix-Vector Multiplication)
2. **PR** (Distributed PageRank Computation)
   
Each application provides multiple implementation versions to compare the OFIS-enabled case with OFIS-oblivious cases.
1. **SpMV**
   - SparseP-ES: OFIS-oblivious version with 2D equally-sized data partitioning
   - SparseP-EW: OFIS-oblivious version with 2D equally-wide, load-balanced data partitioning
   - SpMV-OFIS: OFIS-enabled version with 2D equally-sized data partitioning
2. **PR**
   - PR-WRAM: OFIS-oblivious version that uses WRAM for a node information store
   - PR-OFIS: OFIS-enabled version of the PR-WRAM 

## System Requirements
- UPMEM PIM DIMMs (at least ten PIM DIMMs)
- Two Intel Xeon Gold 6226R CPUs
- 256 GB DRAM
- Ubuntu 20.04.6 LTS
- UPMEM SDK ver 2024.2.0 (you can install it from `https://sdk.upmem.com/2024.2.0/01_Install.html`)
- **>= 200 GB of free disk space**

## Files
- ofis/      # **ofis.h** and **libofis.so**
- ofis-source/    # source code for libofis
- SpMV/     # source code for SpMV applications (both OFIS-enabled and OFIS-oblivious versions)
- PageRank/ # source code for PR applications (both OFIS-enabled and OFIS-oblivious versions)
- README.md # readme file for using OFIS
- download_dataset.sh    # Script file for downloading datasets for applications
- exp_all.sh    # Script file for executing all applications
- gnuplot-script.plt    # Script file for plotting graphs (gnuplot)

## Install and Setup libofis
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
**Note: Ensure >= 200 GB of free disk space before downloading.**

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
