# diff_tool.py

import argparse
import difflib
import sys
import glob
from pathlib import Path
import os

# firstpath - source path, where takes files
# secondpath - second path, where finds equals name files
# context - if true write only context diff (not all file)  
# delta - diff variable, where kept all diffs
# args - start arguments
# output_file - path to output file (with .html)
# reverse - check files on presence from secondpath in firstpath  
def findDiff(firstpath, secondpath, context, delta, args, output_file, reverse):
    
    NotFound = '/home/masedar/NotFound.txt'

    # Loop through all files
    # files = glob.glob(firstpath + '/**/*', recursive=True)
    # print(files)
    for file in glob.iglob(firstpath + '/**/*.*', recursive=True):
        old_file = Path(file)
        print(old_file.name)
        new_file = None
        
        for root, dir, files in os.walk(secondpath):
            if old_file.name in files:
                # print(files)
                new_file_path = os.path.join(root, old_file.name)
                # Дополнительная проверка родителя (папки, в которой лежит файл, a/b.js != b/b.js)
                # Если без неё, то он просто ищет файл по названию во всех директориях с secondpath
                if args.mode:
                    if str(old_file.parent.stem) not in firstpath: 
                        if os.path.basename(old_file.parent) in os.path.basename(root):
                            new_file = Path(new_file_path)
                            break
                    else:
                        print(firstpath + "has files")
                        return 1
                else: 
                    new_file = Path(new_file_path)
        
        file_1 = open(old_file).readlines()
        if new_file == None:
            with open(NotFound, "w") as f:
                f.write("Not found. it's new file!!!\n")
            file_2 = open(NotFound).readlines()
        else:
            if reverse != 0:
                continue
            file_2 = open(new_file).readlines()
        if context:
            delta += difflib.HtmlDiff().make_file(file_1, file_2, old_file, new_file, True) if reverse == 0 else difflib.HtmlDiff().make_file(file_2, file_1, new_file, old_file, True)
        else :
            delta += difflib.HtmlDiff().make_file(file_1, file_2, old_file, new_file) if reverse == 0 else difflib.HtmlDiff().make_file(file_2, file_1, new_file, old_file)

        # Записывает ответ
        with open(output_file, "w") as f:
            f.write(delta)
    return delta

def script(): 
    parser = argparse.ArgumentParser()
    parser.add_argument("-first", help="full path to sources files")
    parser.add_argument("-second", help="full path to other files")
    parser.add_argument("-html", help="specify html to write to")
    parser.add_argument('-c', help="use context for output")
    parser.add_argument('-mode', help="search name by name with equal directory [use only from a dir containing other dirs] (a/b.js != b/b.js)")
    # parser.add_argument('-cli', help="choose mode cli: web/model/react")
    args = parser.parse_args()

    firstpath = args.first  
    secondpath = args.second
    mode = args.mode
    context = args.c

    DiffFile = '/home/masedar/diff.html'

    # default
    if args.first:
        firstpath = args.first    
    else: 
        print("Write first path (-first ~/*) or use -h for more information")
        return
    if args.second:
        secondpath = args.second
    else:   
        print("Write second path (-second ~/*)")
        return

    if args.html:
        output_file = Path(args.html)
        print (output_file)
    else:
        output_file = Path(DiffFile)

    delta = difflib.HtmlDiff().make_file('', '')
    
    res = findDiff(firstpath, secondpath, context, delta, args, output_file, 0)
    if res == 1:
        return
    # delta = res since give delta value and not link
    res = findDiff(secondpath, firstpath, context, res, args, output_file, 1)
    if res == 1:
        return

    print("-------END----------")
    print ("Context enabled" if context else "Context disabled")
    print ("src path:" + str(firstpath))
    print ("other path:" + str(secondpath))
    print("Output file: " + str(output_file))
    if mode: 
        print("Mode: active")  
    
script()    
