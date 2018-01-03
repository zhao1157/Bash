#! /usr/local/bin/bash

#This script is to convert the b-b data from FAC to superstructure format
#==========SPECIFY the file names for each run===============
ener_file=$1	#the original energy file
tr_file=$2 	#the original tr file
index_tr_file=$3	#This has to be the 2j value of the upper state

tr_dir=$( echo ${tr_file/'.tr'/}_${index_tr_file} )	#the output directory

if [ ! -d ${tr_dir} ]
then
	mkdir ${tr_dir}
else
	rm -rf ${tr_dir}
	sleep 3
	mkdir ${tr_dir}
fi
#This is the file collecting all the output to screen
if [ -f ${tr_dir}/out_record ]
then
	rm -f ${tr_dir}/out_record
fi

#=========truncate the energy file into a good one===============
ener_file_trunc=${ener_file/'.en'/}_trunc.en	#the energy file containing the useful infor.

sed 1,8d ${ener_file} | sed /'NELE'/d | sed /'NLEV'/d | sed /'ILEV'/d \
					  | sed /^$/d > ${tr_dir}/${ener_file_trunc}

#So far we have truncated the energy file into the one that's convenient for us to program.

#==========Find the maximum 2J value in the upper state in tr file==========
line=( $( sed -n 7p ${tr_file} ) )
nb=${line[2]}	#the number of data blocks in tr file

##Since we have found the maximum value of 2J value, we will skip the following steps.
#line_num=7	#the last line of the head block
#J_MAX=0	#assume the maximum 2J right now is 0
##Start the loop through all the blocks
#for i in $(seq 1 ${nb})
#do
	#line=( $( sed -n $((line_num+3))p ${tr_file} ) )
	#ntrans=${line[2]}	#number of transitions in the current data block
	
	##start the loop through each transition
	#for j in $(seq $((line_num+7)) $((line_num+6+ntrans)))
	#do	
		#line=( $( sed -n ${j}p ${tr_file} ) )
		#val_J=${line[1]}	#The 2J value of the current upper state
		
		#if [ ${J_MAX} -lt ${val_J} ]
		#then
			#J_MAX=${val_J}	#find the new maximum value of 2J
		#fi
	#done
	#line_num=$((line_num+6+ntrans)) #Finish the current data block and move the control 
									##to the end of the block.
#done
 
#echo "J_MAX: " ${J_MAX} >> ${tr_dir}/out_record

##So far we have found the maximum 2J value

#==========loop through 2J values==========
count_lines=0 #This is to record total number of matched transitions.

for J2_up in ${index_tr_file} 	#$(seq 0 2 ${J_MAX}) 	#2j must be even, so the increment is 2
do
	for PI_up in 0 1
	do
		for J2_low in $(seq $((J2_up-2)) 2 $((J2_up+2)))
		do

			if [ ${PI_up} -eq 0 ]
			then
				PI_low=1
			else
				PI_low=0
			fi
			echo ${J2_up}${PI_up}_${J2_low}${PI_low}
            echo "=========="			
			#so far we have got the right 2J and Pi values for upper and lower states
			#now we are going to loop throug again the data blocks.
			if [ -f ${tr_dir}/${J2_up}${PI_up}_${J2_low}${PI_low} ]
			then
				rm -f ${tr_dir}/${J2_up}${PI_up}_${J2_low}${PI_low}
			else
				touch ${tr_dir}/${J2_up}${PI_up}_${J2_low}${PI_low}
			fi
			
			num_matched=0 	#the number of matched transitions in this type
			line_num=7	#the last line of the head block
			for i in $(seq 1 ${nb})
			do
				line=( $( sed -n $((line_num+3))p ${tr_file} ) )
				ntrans=${line[2]}	#number of transitions in the current data block
				#start the loop through each transition
				for j in $(seq $((line_num+7)) $((line_num+6+ntrans)))
				do
					echo $j
					line=( $( sed -n ${j}p ${tr_file} ) )
					if [ ${line[1]} -eq ${J2_up} -a ${line[3]} -eq ${J2_low} ]
					then
						line_up=( $(sed -n $((line[0]+1))p ${tr_dir}/${ener_file_trunc}) )
						line_down=( $(sed -n $((line[2]+1))p ${tr_dir}/${ener_file_trunc}) )
						
						if [ ${line_up[3]} -eq ${PI_up} -a ${line_down[3]} -eq ${PI_low} ]
						then
							#count_lines=$((count_lines+1)) 	#find a matched transition
							#num_matched=$((num_matched+1))	
							
							line_up[2]=${line_up[2]/'E+'/'*10^'}
							line_up[2]=${line_up[2]/'E-'/'*10^-'}
							
							line_down[2]=${line_down[2]/'E+'/'*10^'}
							line_down[2]=${line_down[2]/'E-'/'*10^-'}
							#convert energy in ev to z-scaled Ry
							energy_up=$( echo "(${line_up[2]}-1260.09943)/13.605693/17/17" | bc -l )
							energy_down=$( echo "(${line_down[2]}-1260.09943)/13.605693/17/17" | bc -l )
							
							#The lower state has to be in negative energy
							if (( $(echo "${energy_down} < 0" | bc -l) ))
							then
								num_matched=$((num_matched+1))	#Only now are all the requirements met.
								#now it's ready to write the matched transition data to
								#file ${tr_dir}/${J2_up}${PI_up}_${J2_low}${PI_low}
								energy_up=$( printf "%.6E" ${energy_up} )
								energy_up=${energy_up/'E-0'/'E-'}
								energy_up=${energy_up/'E+0'/'E+'}
								energy_down=$( printf "%.6E" ${energy_down} )
								energy_down=${energy_down/'E-0'/'E-'}
								energy_down=${energy_down/'E+0'/'E+'}
							
								printf "%8s%2s%13s%13s%11.3E%11.3E%11.3E\n" ${num_matched} 1 ${energy_down}\
									${energy_up} ${line[5]} ${line[5]} ${line[6]} >> \
																	${tr_dir}/${J2_up}${PI_up}_${J2_low}${PI_low}
							else
								echo "line $j: the lower state has non-negative energy" >> ${tr_dir}/out_record
							fi
						fi
					fi
				done
				line_num=$((line_num+6+ntrans)) #Finish the current data block and 
												#move the control to the end of the block.
			done	
			
			#if ${J2_up}${PI_up}_${J2_low}${PI_low} is empty, then remove it
			if [ ! -s ${tr_dir}/${J2_up}${PI_up}_${J2_low}${PI_low} ]
			then
				rm -f ${tr_dir}/${J2_up}${PI_up}_${J2_low}${PI_low}
			fi
			
		done
	done
done

#echo "count_lines: " ${count_lines} >> ${tr_dir}/out_record

