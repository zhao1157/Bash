#! /bin/bash

cat << eof > my_pbs 
#PBS -q bigmem
#PBS -l walltime=5:00:00
#PBS -l nodes=1:ppn=2
#PBS -N RM_FAC_add
#PBS -S /bin/ksh
#PBS -j oe

cd \${PBS_O_WORKDIR}

if [ -d RM_FAC_add ]
then
	rm -rf RM_FAC_add
	mkdir RM_FAC_add
else
	mkdir RM_FAC_add
fi

for i in $(seq 1 454)
do
	./add_RM_FAC \${i} RM_FAC_add/\${i}
done
eof

qsub my_pbs
