#!/bin/bash

# https://stackoverflow.com/questions/2664740/extract-file-basename-without-path-and-extension-in-bash
# https://stackoverflow.com/questions/18278990/easiest-way-to-check-for-file-extension-in-bash
# https://askubuntu.com/questions/983944/rename-the-files-as-they-are-extracted-from-the-zip-file-as-the-name-of-the-zip
# https://www.cyberciti.biz/faq/linux-unix-shell-unzipping-many-zip-files/
# https://stackoverflow.com/questions/60928098/how-do-i-assign-filename-to-a-variable-after-unzipping-unknown-zip-file-in-bash
# https://unix.stackexchange.com/questions/382390/unzip-archive-with-single-file-and-rename-output-to-match-archive-name
for z in *.zip; do 
    for i in $(unzip $z "data/*"); do
      s=${i##*/};
      echo "f: ${i##*/}";
      echo "i: $i"; 
      echo "z: $z"; 
      echo "{i#*.}: ${i#*.}";
      echo "FileNmae: ${s%.*}";
      if [[ $s =~ \.xml$ ]]; then
        mv "data/${i##*/}" "${s%.*}[${z%%.*}].xml";
        echo "PRINT**************"
      fi
      echo "                                                           "; 
      echo "                                                           "; 
    done;
    echo "__________________"; 
done;
