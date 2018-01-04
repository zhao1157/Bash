#! /bin/bash

cat << eof > line_20_pbs
#PBS -q bigmem
#PBS -l walltime=6:00:00
#PBS -l nodes=1:ppn=1
#PBS -N line_20
#PBS -S /bin/ksh
#PBS -j oe

cd \${PBS_O_WORKDIR}    
        
./line_20.sh
eof

qsub line_20_pbs

