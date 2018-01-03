#!/usr/local/bin/bash

line=( $(sed -n 7p fe17a_1.rr) )

#echo ${line[2]}
nblocks=${line[2]}

line_num=7 #the last line number of the header block
if [ -f nb_line_ntrans ]
then
	rm nb_line_ntrans
fi

#sum=0
for nb in $(seq 1 ${nblocks})
do
	echo "nb: " ${nb}
	
	line_num=$((line_num+3))
	#printf "%-10s" ${line_num}
	line=( $(sed -n ${line_num}p fe17a_1.rr) )

	ntrans=${line[2]}
	#printf "%-6s" ${ntrans}
	#sum=$((sum+${ntrans}))
	#echo ${ntrans}
	
	#Here is to execute the scritpt to process the data in each block.
	#Looks like one iteration won't start until the previous one finishes.
	#So I will just do it by hand to execute each iteration.
	
	if [ ${nb} -ge 54 -a ${nb} -le 71 ]
	then
		./combine_nb.sh ${nb} ${line_num} ${ntrans}
	fi
	#echo ${nb} ${line_num} ${ntrans} >> nb_line_ntrans
	
	#Go the end of the current block.
	line_num=$((line_num+49+22*ntrans))
done
#echo ${sum}
echo ${line_num}
