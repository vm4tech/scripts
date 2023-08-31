#!/bin/bash

# https://stackoverflow.com/questions/2664740/extract-file-basename-without-path-and-extension-in-bash
# https://stackoverflow.com/questions/18278990/easiest-way-to-check-for-file-extension-in-bash
# https://askubuntu.com/questions/983944/rename-the-files-as-they-are-extracted-from-the-zip-file-as-the-name-of-the-zip
# https://www.cyberciti.biz/faq/linux-unix-shell-unzipping-many-zip-files/
# https://stackoverflow.com/questions/60928098/how-do-i-assign-filename-to-a-variable-after-unzipping-unknown-zip-file-in-bash
# https://unix.stackexchange.com/questions/382390/unzip-archive-with-single-file-and-rename-output-to-match-archive-name

if [[ "$1" != "" ]]; then
    PATH_TO_ZIP=$1;
else
    PATH_TO_ZIP="*";
fi
if [[ "$2" != "" ]]; then
    PATH_IN_ZIP=$2;
else
    PATH_IN_ZIP="*";
fi

if [[ "$3" != "" ]]; then
    FILE_EXTENSION=$3;
else
    FILE_EXTENSION=".*";
fi


echo "PATH_IN_ZIP: $PATH_IN_ZIP";
echo "PATH_TO_ZIP: $PATH_TO_ZIP";

# enable ** for recursion subfolder from ./ (https://askubuntu.com/questions/1287093/bash-recursive-command-to-include-files-of-current-directory-files-as-wel)
shopt -s globstar;
for z in **/*.zip; do
    # unzip only data/* folder from zip
    for i in $(unzip $z "*$FILE_EXTENSION" -d data); do
      s=${i##*/};
      zNoFolder=${z##*/};
      echo "file: ${i##*/}";    
      echo "file name: ${s%.*}";
      echo "path to file: $i"; 
      echo "path to zip: $z"; 
      echo "zip: $zNoFolder"; 
      echo "extension: ${i#*.}";
      if [[ $s =~ $FILE_EXTENSION ]]; then
        mv "data/${i##*/}" "data/${s%.*}[${zNoFolder%%.*}]$FILE_EXTENSION";
        echo "successed unzip file $s";
        echo "                                                           "; 
        echo "                                                           "; 
      fi
      
    done;
    echo "__________________"; 

done
shopt -u globstar;