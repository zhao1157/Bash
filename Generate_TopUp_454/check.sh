#! /bin/bash
for i in $(seq 1 454)
do
	if [ $(ls outfile/fe17a_${i}_* | wc -l) != $(cat outfile/${i}) ]
	then
		echo ${i}       
    fi

done
