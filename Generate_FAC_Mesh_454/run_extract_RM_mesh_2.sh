#! /bin/bash

if [ -d RM_mesh_dir ]
then
	rm -rf RM_mesh_dir
	mkdir RM_mesh_dir
else
	mkdir RM_mesh_dir
fi

for i in $(seq 1 454)
do
	cat << eof > PBS_$i
#PBS -q bigmem
#PBS -l walltime=1:00:00
#PBS -l nodes=1:ppn=1
#PBS -N RM_mesh_$i
#PBS -S /bin/ksh
#PBS -j oe

cd \${PBS_O_WORKDIR}	
	
python extract_RM_mesh_2.py ${i} 	
eof

	qsub PBS_$i
	sleep 1
done 
