# Recursion UNZIP script and rename files
_________________________________
Recursion **UNZIP** for zip files from **current folder** and **subfolders** with certain **extension** and **rename** files as *file[**zipName**].extension*

```shell
// ./unzip -e .xml
- zipName.zip
	- file1.xml
	- file2.xml
	- data
		- file3.xml
		...

- result
	- file1[zipName].xml
	- file2[zipName].xml
	- file3[zipName].xml
	
```

__________________
# How to use
Copy [unzip.sh](unzip.sh) and go to cmd.


![](docs/unzip.gif)

For **current** folder (and subfolders) can start unzip like that:
```shell
./unzip.sh 
```
For external folder (and subfolders) can start unzip with **-f**:
```shell
./unzip.sh -f path/to/folder/with/zips/
```

# Unzip and rename result (folder)
After running script will created **/result** folder in **source** folder (where are the files);

Go to **/result** and check **unzipped** and **renamed** files.
_______________
# Use more parameters
For use custom extension can add varibale:
```
./unzip.sh -f path/to/folder/with/zips/ -p one/folder/from/zip -e .file_extension
```

