#!/bin/bash

# Make sure github is trusted
cat /root/spark-ec2/github.hostkey >> /root/.ssh/known_hosts

# Checkout prober-bench branch

pushd /root/pipelines

git checkout -- .
git pull
git checkout prober-bench

sbt/sbt clean assembly

popd

# Build BLAS for this machine
# TODO: Copy this from s3 ?
#pushd /root/OpenBLAS
#make clean
#make -j4
#rm -rf /root/openblas-install
#make install PREFIX=/root/openblas-install
#
## Build JBLAS for this machine
## TODO: Copy this from s3 ?
#pushd /root/jblas
#make clean
#./configure --static-libs --libpath="/root/openblas-install/lib/" --lapack-build
#make
#cp src/main/resources/lib/static/Linux/amd64/sse3/libjblas.so /root/pipelines/lib/
#popd

s3_bucket_name=`ec2-metadata | grep instance-type | awk '{print $2}'`
s3cmd get s3://jblas/$s3_bucket_name /root/pipelines/lib/libjblas.so  
