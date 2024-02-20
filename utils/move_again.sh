#!/bin/bash

for f in *
do
    
    len=${#f}
    if [[ $len == 14 ]]; then
        continue
    fi
    if [[ $f == *".sh"* ]]; then
        continue
    fi
    #newname=$(cut -c 6-15 (echo $f));
    #newname="new_archive/"
    newname=${f:0:10}
    newname+=${f: -4};
    echo "Oldname: $f";
    echo "Newname: $newname";
    mv "$f" "./$newname";
done