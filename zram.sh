#!/bin/bash
cores=$(nproc --all)
modprobe zram num_devices=$cores
swapoff -a
totalmem=`free | grep -e "^Mem:" | awk '{print $2}'`
mem=$(( ($totalmem * 2 / $cores)* 1024 ))
modprobe deflate
modprobe zlib
modprobe lz4hc_compress
core=0
while [ $core -lt $cores ]; do
  echo deflate > /sys/block/zram$core/comp_algorithm ||
   echo zlib > /sys/block/zram$core/comp_algorithm ||
   echo lz4hc > /sys/block/zram$core/comp_algorithm ||
   echo lz4 > /sys/block/zram$core/comp_algorithm
# not sure which one this kernel has
  echo $mem > /sys/block/zram$core/disksize
  mkswap /dev/zram$core
  swapon --discard -p 5 /dev/zram$core # reclaim memory better
  let core=core+1
done
