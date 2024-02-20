#!/bin/bash

for d in *
do
    for f in $d/*
    do
        echo "Oldname: $f";
        if [[ $f != *"."* ]]; then
            continue
        fi
        if [[ $f == *".sh"* ]]; then
            continue
        fi
        #newname=$(cut -c 6-15 (echo $f));
        newname="new_archive/"
        newname+=${f:5:10}
        newname+=${f: -4};
        echo "Newname: $newname";
        echo "mv $f $newname";
    done;
done