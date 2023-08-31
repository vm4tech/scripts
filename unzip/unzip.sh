#!/bin/bash

# https://stackoverflow.com/questions/2664740/extract-file-basename-without-path-and-extension-in-bash
# https://stackoverflow.com/questions/18278990/easiest-way-to-check-for-file-extension-in-bash
# https://askubuntu.com/questions/983944/rename-the-files-as-they-are-extracted-from-the-zip-file-as-the-name-of-the-zip
# https://www.cyberciti.biz/faq/linux-unix-shell-unzipping-many-zip-files/
# https://stackoverflow.com/questions/60928098/how-do-i-assign-filename-to-a-variable-after-unzipping-unknown-zip-file-in-bash
# https://unix.stackexchange.com/questions/382390/unzip-archive-with-single-file-and-rename-output-to-match-archive-name

PATH_TO_FOLDER=".";
PATH_IN_ZIP="";
FILE_EXTENSION=".xml";

while getopts ":h:f:p:e:" arg; do
    case $arg in
    f) if [[ "$OPTARG" != "" ]]; then
            PATH_TO_FOLDER=$OPTARG;
        fi;;
    p) if [[ "$OPTARG" != "" ]]; then
            PATH_IN_ZIP=$OPTARG;
        fi;;
    e)  if [[ "$OPTARG" != "" ]]; then
            FILE_EXTENSION=$OPTARG;
        fi;;
    h|*) 
        printf "Usage: %s: [-f path/to/filder/] [-p path/in/zip] [-e .file_extension (default .xml)] args\n," $0
      exit 0
      ;;
    esac
done


# enable ** for recursion subfolder from ./ (https://askubuntu.com/questions/1287093/bash-recursive-command-to-include-files-of-current-directory-files-as-wel)
shopt -s globstar;
for z in $PATH_TO_FOLDER/**/*.zip; do
    # unzip only data/* folder from zip
    for i in $(unzip $z "$PATH_IN_ZIP*$FILE_EXTENSION" -d "$PATH_TO_FOLDER/result"); do
      FILE=${i##*/};
      FILE_NAME=${FILE%.*};
      EXTENSION=${FILE#*.};
      ZIP=${z##*/};
      ZIP_NAME=${ZIP%%.*};
      PATH_TO_ZIP_FILE=$(dirname $i);
      if [[ $PATH_IN_ZIP != "" ]]; then
        PATH_TO_ZIP_FILE=$PATH_TO_FOLDER/result/$PATH_IN_ZIP;
      fi
      if [[ $FILE =~ $FILE_EXTENSION ]]; then
        # echo "file: $FILE";    
        # echo "file name: $FILE_NAME";
        # echo "path to file: $(dirname $i)"; 
        # echo "path to zip: $z"; 
        # echo "zip: $ZIP"; 
        # echo "extension: $EXTENSION";
        NEW_FILE=$FILE_NAME[$ZIP_NAME].$EXTENSION;
        mv "$PATH_TO_ZIP_FILE/$FILE" "$PATH_TO_FOLDER/result/$NEW_FILE";
        echo "File: $FILE renamed to $NEW_FILE";
      fi
    done;

done
echo "____________________________________________"
echo "all files located in $PATH_TO_FOLDER/result";
echo "____________________________________________"
echo "-f PATH_TO_FOLDER: $PATH_TO_FOLDER";
echo "-p PATH_IN_ZIP: $PATH_IN_ZIP";
echo "-e FILE_EXTENSION: $FILE_EXTENSION";
# clear -j folder
# rm -d -R $PATH_TO_FOLDER/result/$PATH_IN_ZIP;
shopt -u globstar;

