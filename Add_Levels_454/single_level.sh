#! /bin/bash

#Since this script is going to run in arjuna, so I will put the bash interpreter in arjuna
#in the first line.

bound_index=$1	#Receive the bound level from the command line.
data_dir=$2

lines_20=( $(sed -n ${bound_index}p 454_points_20) )
lines_11=( $(sed -n ${bound_index}p 454_points_11) )

#This is to deal with the case where there are no fac for some bound levels.
if [ ${lines_20[1]} == 0  ]
then
	echo ${lines_20[*]:0:2} >> ${data_dir}/${bound_index}
	exit
fi

#This is to deal with the case where there are some fac levels for this level.
num_trans_20=$(( ${#lines_20[*]}-2 ))
num_trans_11=$(( ${#lines_11[*]}-2 ))

if [ ${num_trans_11} != ${num_trans_20} ]
then
	echo "The number of the lines in both files are not the same, exit!"
	exit
fi

echo ${lines_20[*]:0:2} >> ${data_dir}/${bound_index}

#In regions 1-1237, the energy points are 20.
for region in $(seq 1 1237)
do
	#c-program to add these data up. Allocate 20 elements and store the first region,
	#but add all other regions to the first one, finally you get the final result the 
	#moment you finish reading the file.
	
	#1st extract the raw data into file temp_data_${bound_index}
	if [ -f  ${data_dir}/temp_data_${bound_index} ]
	then
		rm ${data_dir}/temp_data_${bound_index}
	fi
	
	for line_level in ${lines_20[*]:2}
	do
		sed -n $((line_level+2)),$((line_level+21))p ../FAC_454_TOPUP/fe17a_${region}.rr \
												>> ${data_dir}/temp_data_${bound_index}
	done
	
	num_lines=$( sed -n $= ${data_dir}/temp_data_${bound_index} )
	
	if (( ${num_trans_20}*20 != ${num_lines} ))
	then
		echo "20: OH SOMETHING WENT WRONG! EXITING"
		exit
	fi
	
	#2nd Ok, now we have collected these data, and we are gonna add them up by a c code,
	#and append them to the end of ${data_dir}/${bound_index}. 
	
	./single_level_add ${data_dir}/temp_data_${bound_index} ${num_trans_20} 20 \
						${data_dir}/${bound_index}
	
	#rm ${data_dir}/temp_data_${bound_index}
done

#In region 1238, the energy points are 11.
for region in 1238
do

	if [ -f  ${data_dir}/temp_data_${bound_index} ]
	then
		rm ${data_dir}/temp_data_${bound_index}
	fi
	
	for line_level in ${lines_11[*]:2}
	do
		sed -n $((line_level+2)),$((line_level+12))p ../FAC_454_TOPUP/fe17a_${region}.rr \
												>> ${data_dir}/temp_data_${bound_index}
	done
	
	num_lines=$( sed -n $= ${data_dir}/temp_data_${bound_index} )
	
	if (( ${num_trans_11}*11 != ${num_lines} ))
	then
		echo "11: OH SOMETHING WENT WRONG! EXITING"
		exit
	fi
	
	#2nd Ok, now we have collected these data, and we are gonna add them up by a c code,
	#and append them to the end of ${data_dir}/${bound_index}. 
	
	./single_level_add ${data_dir}/temp_data_${bound_index} ${num_trans_11} 11 \
						${data_dir}/${bound_index}
done
