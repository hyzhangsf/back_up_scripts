#!/usr/bin/env bash
set -e
if [ ! -d ~/redis_backup/ ]; then
	mkdir ~/redis_backup/
fi
cd ~
rsync -rave ssh <host_address>:~/redis_backup  .
cd ~/redis_backup
filename=`command ls | tail -1`
filename=redisBackupsUntil${filename}
for file in `command ls`;do tar cvf  $file.tar $file;done
echo 'gzipping... each folder'
for file in `command ls *.tar`;do echo gzipping $file; gzip $file;done
rm -rf zipped
mkdir zipped
echo 'moving .tar.gz files to zipped/'
for file in `ls *tar.gz`;do mv $file zipped/;done
echo 'tar zipped'
tar cvf  ${filename}.tar zipped
echo "gzipping ${filename}"
gzip ${filename}.tar
echo 'movining out the final tar.gz file'
mv  ${filename}.tar.gz ~
echo 'cleanning up'
rm -rf ~<username>/redis_backup
mkdir ~<username>/redis_backup
echo 'done'
