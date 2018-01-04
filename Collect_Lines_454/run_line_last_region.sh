#! /bin/bash

if [ -d line_last_region_dir ]
then
	rm -rf line_last_region_dir
	mkdir line_last_region_dir
else
	mkdir line_last_region_dir
fi

for i in $(seq 1 454)
do
cat << eof > PBS_${i}
#PBS -q bigmem
#PBS -l walltime=2:00:00
#PBS -l nodes=1:ppn=1
#PBS -N xsectn_line_${i}
#PBS -S /bin/ksh
#PBS -j oe

cd \${PBS_O_WORKDIR}	
	
./line_last_region.sh ${i}
eof
	qsub PBS_${i}
	sleep 1
done

