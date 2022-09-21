#!/bin/bash

#print service time
date

#virtualenv is now active
source /mnt/e/digitalskola/linux/hadoop_batch_processing/venv/bin/activate

#running etl service
python  /mnt/e/digitalskola/linux/hadoop_batch_processing/app.py

filetime=$(date +"%Y%m%d")
echo "[INFO] Mapreduce is Running ....."
#running mapreduce on local
python /mnt/e/digitalskola/linux/hadoop_batch_processing/mapReduceOrderSum.py /mnt/e/digitalskola/linux/hadoop_batch_processing/local/dim_orders_$filetime.csv > /mnt/e/digitalskola/linux/hadoop_batch_processing/output/ordercount_output_local_map.txt
#running mapreduce hadoop
python /mnt/e/digitalskola/linux/hadoop_batch_processing/mapReduceOrderSum.py -r hadoop hdfs:///digitalskola/project/dim_orders_$filetime.csv > /mnt/e/digitalskola/linux/hadoop_batch_processing/output/ordercount_output_hadoop_map.txt

echo "[INFO] Mapreduce is Done ....."