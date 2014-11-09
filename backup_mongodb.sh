#/usr/bin/env bash
TIME=$(date +"%Y-%m-%d-%H-%M-%S")
BACK_UP_FOLDER='/home/<username>/redis_backup/'


dump_file=$BACK_UP_FOLDER$TIME
mkdir $dump_file && cp /home/<username>/redis/dump.rdb $dump_file
scp -r  $dump_file host_address:/home/<username>/redis_backup