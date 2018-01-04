#! /usr/local/bin/bash

#This scirpt is to read the cross section file once and extract all the desired transition
#information.

#NOTE
max_points=20

file_energy=../../fe17_454_topup/generate_topup_2/outfile/fe17a_trunc.en	
															#The new energy file with
															#topup configurations
dir_J_Pi_final=../../fe17_454_tail/outfile/raw_level_2	#Directory in which the bound
															#levels are stored.
file_xsectn=../generate_topup_3/outfile/fe17a_2_1.rr

##############__1__############
#Correlate the bound levels and its valence electron.
for J in $(seq 0 8)
do
	for Pi in 0 1
	do
		num_line=$(sed -n $= ${dir_J_Pi_final}/${J}_${Pi}_final)	#Be sure to put the
																	#curly braces around 
																	#J PI
		for i in $(seq 1 ${num_line})
		do
			data_line=( $(sed -n ${i}p ${dir_J_Pi_final}/${J}_${Pi}_final) )
			line_bound=( $(sed -n $((data_line[0]+1))p ${file_energy}) )
			valence[${data_line[0]}]=${line_bound[4]}
			
			if [ -z ${valence[${data_line[0]}]} ] 
			then 
				echo BAD
				exit
			fi
		done
	done
done

printf "%s\n" ${#valence[*]}	#Verify that we have all the bound states 454.

##############__2__############
#Scan through the cross section data and store the "free" lines correlated with bound ones.

line=7
data_line=( $(sed -n ${line}p ${file_xsectn}) )
NBlocks=${data_line[2]}

i=1

for j in $(seq 1 ${NBlocks})
do
	line=$((line+3))	#the line where to read the number of transitions.
	data_line=( $(sed -n ${line}p ${file_xsectn}) )
	NTrans=${data_line[2]}
	
	line=$((line+ max_points*2+10 ))	#The line where the first transition data start.

	#hoping to find the transition in this block.
	for k in $(seq 1 ${NTrans})
	do
#RECORD	************************
		echo ${line} >> line_right_now
			
		data_line=( $(sed -n ${line}p ${file_xsectn}) )
		
		if [ ! -z ${valence[data_line[0]]} ]
		then
			line_free=( $(sed -n $((data_line[2]+1))p ${file_energy}) )
			if [ ${valence[data_line[0]]} -eq ${line_free[4]} ]
			then
				#eval free_${data_line[0]}+="(${line})"
				eval free_${data_line[0]}[${i}]=${line}
				i=$((i+1))
			fi
		fi
		line=$((line+max_points+2))
	done
	line=$((line-1))
done
echo $((i-1))
##############__3__############
#print out the "free" lines in the bound states order.
for J in $(seq 0 8)
do
	for Pi in 0 1
	do
		num_line=$(sed -n $= ${dir_J_Pi_final}/${J}_${Pi}_final)	#Be sure to put the
																	#curly braces around 
																	#J PI
		for i in $(seq 1 ${num_line})
		do
			data_line=( $(sed -n ${i}p ${dir_J_Pi_final}/${J}_${Pi}_final) )
			
			eval num_free='$'{#free_${data_line[0]}[*]}
			if [ ${num_free} -eq 0 ]
			then
				echo ${data_line[0]} 0 >> lines_20/${J}_${Pi}_final
			elif [ ${num_free} -gt 0 ]
			then
				eval echo ${data_line[0]} 1 '$'{free_${data_line[0]}[*]} >> lines_20/${J}_${Pi}_final
			fi
		done
	done
done

