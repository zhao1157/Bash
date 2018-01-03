#! /bin/bash
#This script is to combine all the data blocks in a single one

num_nb=$1	#This inputs the number of blocks in the current directory
index=$2
total_file=M_${index}_total

#================================
if [ -f ${total_file} ]
then
	rm -f ${total_file}
fi

for nb in $(seq 1 ${num_nb})
do
	#initialize the data file counter for each directory
	num_data_files=0
	
	data_dir=nblock_${nb}_dir
	
	#In each data block directory, we are going to deal with all the data files
	#Keep the maximum value of J2_up in a reasonably large value, so that we can be confident
	#that all the data files are processed.
	for J2_up in $(seq 0 2 40)
	do
		for PI_up in 0 1
		do
		
			if [ ${PI_up} -eq 0 ]
			then
				PI_low=1
			elif [ ${PI_up} -eq 1 ]
			then
				PI_low=0
			else
				echo "Something wrong about PI_up value. Exiting~"
				exit
			fi
			
			for J2_low in $(seq $((J2_up-2)) 2 $((J2_up+2)))
			do
				#First check if the file exists
				data_file=${data_dir}/${J2_up}${PI_up}_${J2_low}${PI_low}
				if [ ! -f ${data_file} ]
				then
					continue
				fi
				
				num_data_files=$((num_data_files+1))
				
				#find the total number of lines and check with the first number in the last line
				num_lines=$(sed -n "$ =" ${data_file})
				line=( $(sed -n ${num_lines}p ${data_file}) )
				if [ ${num_lines} -ne ${line[0]} ]
				then
					echo "${data_file} has issue of lines."
					exit
				fi
				
				#now it's ready to combine the current data file to the total one in ss format
				printf "%5s%5s%5s%10s%5s%5s\n" 0 ${J2_up} ${PI_up} 0 ${J2_low} ${PI_low} >> ${total_file}
				printf "%8s%2s%        RE1          RE2     GFL  -  E1  -  GFV    A(E1)*S"\
						${num_lines} 1 >> ${total_file}
				
			 

			done
		done
	done
	echo "${data_dir} has ${num_data_files} files."
done
