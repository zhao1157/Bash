#! /bin/bash

#Since FAC requires at least 4 points in the energy mesh, thus we need to extend the region
#where there are less than 4.

function extend()
{
	fn=$1
	iteration=$2
	
	end_value=$(sed -n '$p' ${fn})
	
	for i in $(seq 1 $((4-iteration)))
	do
		echo "${end_value}+10*${i}"|bc -l >> ${fn}
	done 
}


for i in $(seq 1 3)
do	
echo $i
	file_name='../generate_mesh_2/FAC_mesh_dir/'${i}
	num_line=$(sed -n $= ${file_name})

	if [ ${num_line} == 1 ]
	then
		continue
	fi
	
	num_last=$(( (num_line-1)%20 ))
	
	case ${num_last} in
		1)
			extend ${file_name} 1
		;;
		
		2)
			extend ${file_name} 2
		;;
		
		3)
			extend ${file_name} 3
		;;
	esac

done 
