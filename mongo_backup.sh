#!/usr/bin/env bash
set -e
if [ ! -d ~/mongodb_backup/ ]; then
	mkdir ~/mongodb_backup/
fi
cd ~
rsync -rave ssh <hostname>:~/mongodb_backup  .

cd ~/mongodb_backup
filename=`command ls | tail -1`
filename=mongodbBackupsUntil${filename}
for file in `command ls`;do tar cvf  $file.tar $file;done
for file in `command ls *.tar`;do gzip $file;done
mkdir zipped
for file in `ls *tar.gz`;do mv $file zipped/;done
tar cvf  ${filename}.tar zipped
gzip ${filename}.tar

mv  ${filename}.tar.gz ~
rm -rf *
