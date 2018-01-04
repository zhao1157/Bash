#! /bin/bash

#
level_index=$1

output=line_last_region_dir/${level_index}
num_region=$(cat ../generate_topup_3/outfile/${level_index})

#The file contains the level number and its valence electron which is also in the energy file.
level_valence=../../fe17_454_tail/outfile/raw_level_2/454_final

data_line=( $(sed -n ${level_index}p ${level_valence}) )

bound_state=${data_line[0]}

#============================DOING====================
#Deal with the case where num_region is 0

if [ ${num_region} == 0 ]
then
	echo ${bound_state} 0 > ${output}

	exit
fi
#========================END==========================

file_xsectn=../generate_topup_3/outfile/fe17a_${level_index}_${num_region}.rr

line=( $(sed -n 17p ${file_xsectn}) )
max_points=${line[2]}

#The new energy file with topup configurations
file_energy=../../fe17_454_topup/generate_topup_2/outfile/fe17a_trunc.en	
	

##############__1__############
#Correlate the bound level and its valence electron.
line_bound=( $(sed -n $((bound_state+1))p ${file_energy}) )
valence[${bound_state}]=${line_bound[4]}
			
if [ -z ${valence[${data_line[0]}]} ] 
then 
	echo ${level_index} BAD >> line_last_region_dir/record
	exit
fi

##############__2__############
#Scan through the cross section data and store the "free" lines correlated with bound ones.

line=7
data_line=( $(sed -n ${line}p ${file_xsectn}) )
NBlocks=${data_line[2]}

i=0

for j in $(seq 1 ${NBlocks})
do
	line=$((line+3))	#the line where to read the number of transitions.
	data_line=( $(sed -n ${line}p ${file_xsectn}) )
	NTrans=${data_line[2]}
	
	line=$((line+ max_points*2+10 ))	#The line where the first transition data start.

	#hoping to find the transition in this block.
	for k in $(seq 1 ${NTrans})
	do	
echo ${line}	
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

##############__3__############
#print out the "free" line in the bound states order.
#eval num_free='$'{#free_${bound_state}[*]}
eval echo ${bound_state} 1 '$'{free_${bound_state}[*]} > ${output}
