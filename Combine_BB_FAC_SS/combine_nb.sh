#!/usr/local/bin/bash

nb=$1
line_num0=$2
ntrans=$3

if [ -f combine_nb/out_${nb}_${line_num0}_${ntrans} ]
then
	rm combine_nb/out_${nb}_${line_num0}_${ntrans}
fi

echo ${nb} ${line_num0} ${ntrans} >> combine_nb/out_${nb}_${line_num0}_${ntrans}
echo "==========" >> combine_nb/out_${nb}_${line_num0}_${ntrans}

if [ -f combine_nb/combine_nb_${nb} ]
then
	rm combine_nb/combine_nb_${nb}
fi 

line_num=$((line_num0+49))	#move the control to the line just before the data block

#This is going to be a loop through all the number of transitions.
for i in $(seq 1 ${ntrans})
do
	echo ${i} >> combine_nb/out_${nb}_${line_num0}_${ntrans}
	
	sed -n 1,13p format_60cc.txt >> combine_nb/combine_nb_${nb}
	
	printf "%5s%5s%5s%5s\n" 0 $((nb+20)) 0 ${i} >> combine_nb/combine_nb_${nb}
	
	#going to read the energy of the bound state, but first the index of the bound state
	line=( $(sed -n $((line_num+1))p fe17a_1.rr) )
	#printf "%5s: " ${line[0]}
	line=( $(sed -n $((line[0]+1))p fe17a_trun.en) )
	#printf "%15s\n"	${line[2]}
	line[2]=${line[2]/E+/*10^}
	line[2]=$( echo "scale=11; (${line[2]}-1260.09943)/13.605693"|bc )
	printf "%14.5E%7s\n" ${line[2]} 100 >> combine_nb/combine_nb_${nb}
	#bc can not do 1-(-2), so we have to remove - in front of -2 and do 1+2 instead.
	energy_ioniz=${line[2]/-/}
	
	#echo "energy_ionize: " ${energy_ioniz}

	sed -n 16p format_60cc.txt >> combine_nb/combine_nb_${nb}
	
	#read 100 lines (20 lines in each file) of data and convert them to RM style
	for file in $(seq 1 5)
	do
		for j in $(seq 3 22)
		do
			line=( $(sed -n $((line_num+j))p fe17a_${file}.rr) )
			line[0]=${line[0]/E+/*10^}
			line[0]=${line[0]/E-/*10^-}
			line[0]=$( echo "scale=11; ${line[2]}/13.605693"|bc )
			
			energy_phto=$( echo "${line[0]}+${energy_ioniz}"|bc -l )
			
			line[0]=$( echo "${line[0]}"|bc -l)
			
			printf "%17.9E%17.9E%13.3E%11.3E\n" ${energy_phto} ${line[0]} ${line[2]} \
												${line[2]} >> combine_nb/combine_nb_${nb}
		done
	done
	#move the control to the end of the current block and prepare for the next iteration.
	line_num=$((line_num+22))
done 
