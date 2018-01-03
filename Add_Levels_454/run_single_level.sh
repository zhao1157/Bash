#! /bin/bash

if [ -d bound_topup ]
then
	rm -rf bound_topup
	mkdir bound_topup
else
	mkdir bound_topup
fi

for i in $(seq 1 454)
do
	cat << eof > my_pbs_${i}
#PBS -q bigmem
#PBS -l walltime=10:00:00
#PBS -l nodes=1:ppn=2
#PBS -N FAC_${i}
#PBS -S /bin/ksh
#PBS -j oe

cd \${PBS_O_WORKDIR}

./single_level.sh ${i} bound_topup

eof

qsub my_pbs_${i}

sleep 2

done
