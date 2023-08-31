#!/bin/bash

# https://stackoverflow.com/questions/2664740/extract-file-basename-without-path-and-extension-in-bash
# https://stackoverflow.com/questions/18278990/easiest-way-to-check-for-file-extension-in-bash
# https://askubuntu.com/questions/983944/rename-the-files-as-they-are-extracted-from-the-zip-file-as-the-name-of-the-zip
# https://www.cyberciti.biz/faq/linux-unix-shell-unzipping-many-zip-files/
# https://stackoverflow.com/questions/60928098/how-do-i-assign-filename-to-a-variable-after-unzipping-unknown-zip-file-in-bash
# https://unix.stackexchange.com/questions/382390/unzip-archive-with-single-file-and-rename-output-to-match-archive-name

# if [[ "$path" != "" ]]; then
#     PATH_IN_ZIP="$path"
# else
#     PATH_IN_ZIP="data"
# fi

# enable ** for recursion subfolder from ./ (https://askubuntu.com/questions/1287093/bash-recursive-command-to-include-files-of-current-directory-files-as-wel)
shopt -s globstar;
for z in **/*.zip; do
    # unzip only data/* folder from zip
    for i in $(unzip $z "data/*"); do
      s=${i##*/};
      zNoFolder=${z##*/};
      if [[ $s =~ \.xml$ ]]; then
        echo "file: ${i##*/}";
        echo "file name: ${s%.*}";
        echo "path to file: $i"; 
        echo "path to zip: $z"; 
        echo "zip: $zNoFolder"; 
        echo "extension: ${i#*.}";

        mv "data/${i##*/}" "data/${s%.*}[${zNoFolder%%.*}].xml";
        echo "successed unzip file $s";
        echo "                                                           "; 
        echo "                                                           "; 
      fi
      
    done;
    echo "__________________"; 

done
shopt -u globstar;