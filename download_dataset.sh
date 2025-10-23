#!/bin/bash

wget https://splab.hanyang.ac.kr/archive/PG_dataset.tar.gz
wget https://splab.hanyang.ac.kr/archive/spmv_dcsr256_dataset.tar.gz
wget https://splab.hanyang.ac.kr/archive/spmv_dcsr_dataset.tar.gz
wget https://splab.hanyang.ac.kr/archive/spmv_rbdcsr512_dataset.tar.gz
wget https://splab.hanyang.ac.kr/archive/spmv_rbdcsr_dataset.tar.gz

tar -zxvf PG_dataset.tar.gz
tar -zxvf spmv_dcsr256_dataset.tar.gz
tar -zxvf spmv_dcsr_dataset.tar.gz
tar -zxvf spmv_rbdcsr512_dataset.tar.gz
tar -zxvf spmv_rbdcsr_dataset.tar.gz