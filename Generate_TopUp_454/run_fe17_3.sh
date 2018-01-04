#! /bin/bash

if [ -d outfile ]
then
	rm -rf outfile
	mkdir	outfile
else
	mkdir outfile
fi

for i in $(seq 1 3)
do
cat << eof > PBS_${i}
#PBS -q bigmem
#PBS -l walltime=1:00:00
#PBS -l nodes=1:ppn=1
#PBS -N generate_topup_${i}
#PBS -S /bin/ksh
#PBS -j oe

PYTHONPATH=/home/zhao.1157/fac-master/lib64/python2.3/site-packages
export PYTHONPATH

cd \${PBS_O_WORKDIR}	
	
./fe17_3.sh ${i}
eof
	qsub PBS_$i
	sleep 1
done 
