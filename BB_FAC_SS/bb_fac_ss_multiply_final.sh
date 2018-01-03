#! /bin/bash

#This script is to make the reading and processing each line in the file more efficient
#so that we can cut down the time.

data_file=energy_test	#This is the data block we are going to deal with.
en_file=temp	#This is the file which contains the processed energy data

data_dir=${data_file}_dir	#This is the directory we going to store the processed data

if [ -d ${data_dir} ]
then
	rm -rf ${data_dir}
	mkdir ${data_dir}
else
	mkdir ${data_dir}
fi

#This file is to collect all the debug information
touch ${data_dir}/out_record

#In the data_dir, we are going to create all the possible files
for J2_up in $(seq 0 2 24)
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
			echo "check ${PI_up}, can not assign PI_low" >> ${data_dir}/out_record
			exit
		fi
		
		for J2_low in $(seq $((J2_up-2)) 2 $((J2_up+2)))
		do
			if [ ${J2_low} -lt 0 ]
			then
				continue
			fi
			
			#Okay, so far we have reached a point where we have the explicit transition
			#parameters, initialize the number of each transition to 0
			eval index_${J2_up}${PI_up}_${J2_low}${PI_low}=0
		done
	done
done

#Now we are ready to read each line and extract its data to the corresponding file
#first find the total number of lines in the data file
num_lines=$(sed -n "$ =" ${data_file})

#now loop through the lines

for i in $(seq 1 ${num_lines})
do
	
	echo "line:" ${i} > ${data_dir}/out_record	#Only interested in the current line position
	
	line=( $( sed -n ${i}p ${data_file} ) )
	
	line_up=( $(sed -n $((line[0]+1))p ${en_file}) )
	line_down=( $(sed -n $((line[2]+1))p ${en_file}) )
	#now we can increase the index of the current transition
	eval index_${line[1]}${line_up[3]}_${line[3]}${line_down[3]}=$((index_${line[1]}${line_up[3]}_${line[3]}${line_down[3]}+1))

	transition=index_${line[1]}${line_up[3]}_${line[3]}${line_down[3]}
	echo ${!transition}
	
	line_up[2]=${line_up[2]/'E+'/'*10^'}
	line_up[2]=${line_up[2]/'E-'/'*10^-'}
				
	line_down[2]=${line_down[2]/'E+'/'*10^'}
	line_down[2]=${line_down[2]/'E-'/'*10^-'}
	#convert energy in ev to z-scaled Ry
	energy_up=$( echo "(${line_up[2]}-1260.09943)/13.605693/17/17" | bc -l )
	energy_down=$( echo "(${line_down[2]}-1260.09943)/13.605693/17/17" | bc -l )

	energy_up=$( printf "%.6E" ${energy_up} )
	energy_up=${energy_up/'E-0'/'E-'}
	energy_up=${energy_up/'E+0'/'E+'}
	energy_down=$( printf "%.6E" ${energy_down} )
	energy_down=${energy_down/'E-0'/'E-'}
	energy_down=${energy_down/'E+0'/'E+'}
	
	printf "%8s%2s%13s%13s%11.3E%11.3E%11.3E\n" ${!transition} \
			1 ${energy_down} ${energy_up} ${line[5]} ${line[5]} ${line[6]} >> \
								${data_dir}/${line[1]}${line_up[3]}_${line[3]}${line_down[3]}


done







