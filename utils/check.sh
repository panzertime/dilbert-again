for f in *
do
    
    len=${#f}
    if [[ $len == 14 ]]; then
        continue
    fi
    
    echo "Check: $f";

done