#!/bin/bash
mkdir build;
cd build;
cmake ..;
make -j;

cp api/libdpu.so.0.0 $UPMEM_HOME/lib/
cp api/libdpujni.so.0.0 $UPMEM_HOME/lib/

echo $UPMEM_HOME