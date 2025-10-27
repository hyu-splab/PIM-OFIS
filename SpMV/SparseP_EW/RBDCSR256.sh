#!/bin/bash

if [ ! -d "./bin" ]; then
    mkdir ./bin
fi

if [ ! -d "./results" ]; then
    mkdir ./results
fi

dpu-upmem-dpurte-clang -DTYPE=FP32 -DNR_TASKLETS=16 -o ./bin/spmv_dpu CSR_dpu.c
gcc --std=c99 -fopenmp CSR_host.c -o ./bin/CSR_host `dpu-pkg-config --cflags --libs dpu` -DTYPE=FP32 -DNR_TASKLETS=16

num_iter=$1
# ----------------------------------------------------------------------------------------------------

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_100" -s"16" -d"64" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_100" -s"16" -d"128" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_100" -s"16" -d"256" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_100" -s"16" -d"512" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_100" -s"16" -d"1024" -v"256"
done

# ----------------------------------------------------------------------------------------------------

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_200" -s"16" -d"64" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_200" -s"16" -d"128" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_200" -s"16" -d"256" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_200" -s"16" -d"512" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_200" -s"16" -d"1024" -v"256"
done

# ----------------------------------------------------------------------------------------------------

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_400" -s"16" -d"64" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_400" -s"16" -d"128" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_400" -s"16" -d"256" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_400" -s"16" -d"512" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_400" -s"16" -d"1024" -v"256"
done

# ----------------------------------------------------------------------------------------------------

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_600" -s"16" -d"64" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_600" -s"16" -d"128" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_600" -s"16" -d"256" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_600" -s"16" -d"512" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_600" -s"16" -d"1024" -v"256"
done

# ----------------------------------------------------------------------------------------------------

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_800" -s"16" -d"64" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_800" -s"16" -d"128" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_800" -s"16" -d"256" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_800" -s"16" -d"512" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_800" -s"16" -d"1024" -v"256"
done

# ----------------------------------------------------------------------------------------------------

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_1000" -s"16" -d"64" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_1000" -s"16" -d"128" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_1000" -s"16" -d"256" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_1000" -s"16" -d"512" -v"256"
done

for ((i=1;i<=num_iter;i++))
do
    sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./bin/CSR_host -f"../dataset/rbdcsr256_1000" -s"16" -d"1024" -v"256"
done


