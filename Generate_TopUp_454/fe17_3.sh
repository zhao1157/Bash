#! /bin/bash
#This script is to run FAC calculation for each energy range as in RM calculation.
level_index=$1

energy_file='../generate_mesh_2/FAC_mesh_dir/'${level_index}
num_lines=$( sed -n $= ${energy_file} )
num_lines=$((num_lines-1))
printf "num_lines=%d\n" ${num_lines}
max_points=20	#The maximum number of points can be done in FAC without any problem.

if (( num_lines % max_points == 0 ))
then
	iteration=$((num_lines/max_points))
else
	iteration=$((num_lines/max_points+1))
fi

echo ${iteration} >> outfile/${level_index}

printf "num_energy_region=%d\n" ${iteration}

line=$(sed -n 1p ${energy_file})

if [ ${line} == 0 ]
then
	exit
fi

#Create a function that creates the FAC code for each energy range, with grid g and index i
function create_run_FAC ()
{
	gg=$1
	index=$2
	cat << eof > test_${level_index}_${index}.py
from pfac import fac

fac.SetAtom('Fe')
g = [ ${gg[*]:0} ]
fac.Closed('1s')    #1s is shell is closed, and in the following it will be
                    #neglected.
fac.Config('T1', '2s2 2p5')     #Target 1
fac.Config('T2', '2s1 2p6')     #Target 2

fac.Config('T1.2p', '2s2 2p6')      #Ground state
fac.Config('T1.3*', '2s2 2p5 3*1')      #Valence electron in n=3 shell
fac.Config('T1.4*', '2s2 2p5 4*1')      #Valence electron in n=4 shell
fac.Config('T1.5*', '2s2 2p5 5*1')      #Valence electron in n=5 shell
fac.Config('T1.6*', '2s2 2p5 6*1')      #Valence electron in n=6 shell
fac.Config('T1.7*', '2s2 2p5 7*1')      #Valence electron in n=7 shell
fac.Config('T1.8*', '2s2 2p5 8*1')      #Valence electron in n=8 shell
fac.Config('T1.9*', '2s2 2p5 9*1')      #Valence electron in n=9 shell
fac.Config('T1.10*', '2s2 2p5 10*1')      #Valence electron in n=10 shell

fac.Config('T2.3*', '2s1 2p6 3*1')      #Valence electron in n=3 shell
fac.Config('T2.4*', '2s1 2p6 4*1')      #Valence electron in n=4 shell
fac.Config('T2.5*', '2s1 2p6 5*1')      #Valence electron in n=5 shell
#The following configurations are used for configuration interaction, not want
#their rr data.
fac.Config('T2.6*', '2s1 2p6 6*1')      #Valence electron in n=6 shell, for CI
fac.Config('T2.7*', '2s1 2p6 7*1')      #Valence electron in n=7 shell, for CI
fac.Config('T2.8*', '2s1 2p6 8*1')      #Valence electron in n=8 shell, for CI
fac.Config('T2.9*', '2s1 2p6 9*1')      #Valence electron in n=9 shell, for CI
fac.Config('T2.10*', '2s1 2p6 10*1')      #Valence electron in n=10 shell, for CI

#=========IONIZED TOPUP CONFIGURATIONS=======================
#The following are the ionized configurations from L-shell.==
fac.Config('T3.3*', '2s2 2p4 3*1')                      #====
fac.Config('T3.4*', '2s2 2p4 4*1')                      #====
fac.Config('T3.5*', '2s2 2p4 5*1')                      #====
fac.Config('T3.6*', '2s2 2p4 6*1')                      #====
fac.Config('T3.7*', '2s2 2p4 7*1')                      #====
fac.Config('T3.8*', '2s2 2p4 8*1')                      #====
fac.Config('T3.9*', '2s2 2p4 9*1')                      #====
fac.Config('T3.10*', '2s2 2p4 10*1')                    #====
                                                        #====
fac.Config('T4.3*', '2s1 2p5 3*1')                      #====
fac.Config('T4.4*', '2s1 2p5 4*1')                      #====
fac.Config('T4.5*', '2s1 2p5 5*1')                      #====
fac.Config('T4.6*', '2s1 2p5 6*1')                      #====
fac.Config('T4.7*', '2s1 2p5 7*1')                      #====
fac.Config('T4.8*', '2s1 2p5 8*1')                      #====
fac.Config('T4.9*', '2s1 2p5 9*1')                      #====
fac.Config('T4.10*', '2s1 2p5 10*1')                    #====
                                                        #====
fac.Config('T5.3*', '2p6 3*1')                          #====
fac.Config('T5.4*', '2p6 4*1')                          #====
fac.Config('T5.5*', '2p6 5*1')                          #====
fac.Config('T5.6*', '2p6 6*1')                          #====
fac.Config('T5.7*', '2p6 7*1')                          #====
fac.Config('T5.8*', '2p6 8*1')                          #====
fac.Config('T5.9*', '2p6 9*1')                          #====
fac.Config('T5.10*', '2p6 10*1')                        #====
#========IONIZED TOPUP CONFIGURATIONS DONE=================== 

fac.ConfigEnergy(0)
fac.OptimizeRadial(['T1.2p'])
fac.ConfigEnergy(1)

filename = 'outfile/fe17b_'+str(${level_index})+'_'+str(${index})+'.en'
fac.Structure(filename, ['T1', 'T2'])     #Target
fac.Structure(filename, ['T1.2p', 'T1.3*', 'T2.3*']) #grnd and 1st ex
fac.Structure(filename, ['T1.4*', 'T2.4*'])
fac.Structure(filename, ['T1.5*', 'T2.5*'])
fac.Structure(filename, ['T1.6*', 'T2.6*'])
fac.Structure(filename, ['T1.7*', 'T2.7*'])
fac.Structure(filename, ['T1.8*', 'T2.8*'])
fac.Structure(filename, ['T1.9*', 'T2.9*'])
fac.Structure(filename, ['T1.10*', 'T2.10*'])

#==========IONIZED TOPUP CONFIGURATIONS ======================
fac.Structure(filename, ['T3.3*', 'T4.3*', 'T5.3*'])    #=====
fac.Structure(filename, ['T3.4*', 'T4.4*', 'T5.4*'])    #=====
fac.Structure(filename, ['T3.5*', 'T4.5*', 'T5.5*'])    #=====
fac.Structure(filename, ['T3.6*', 'T4.6*', 'T5.6*'])    #=====
fac.Structure(filename, ['T3.7*', 'T4.7*', 'T5.7*'])    #=====
fac.Structure(filename, ['T3.8*', 'T4.8*', 'T5.8*'])    #=====
fac.Structure(filename, ['T3.9*', 'T4.9*', 'T5.9*'])    #=====
fac.Structure(filename, ['T3.10*', 'T4.10*', 'T5.10*']) #=====
#=========IONIZED TOPUP CONFIGURATIONS DONE===================

#print the energy table.
fac.MemENTable(filename)
fac.PrintTable(filename, 'outfile/fe17a_'+str(${level_index})+'_'+str(${index})+'.en', 1)

##(test-only)Now we are ready to print the rr table for the topup configurations.
#g = range (100, 1000, 100)  #The range() function can only take care of
                            #integers, not float, which can be delt with
                            #by numpy.linspace(2, 4, 100), where 2-start,
                            #4-end, 100-number_of_points.

filename = 'outfile/fe17b_'+str(${level_index})+'_'+str(${index})+'.rr'

fac.SetPEGrid(g)
fac.RRTable(filename, ['T1.3*'], ['T4.3*'])

fac.SetPEGrid(g)
fac.RRTable(filename, ['T1.4*'], ['T3.4*', 'T4.4*'])

fac.SetPEGrid(g)
fac.RRTable(filename, ['T1.5*'], ['T3.5*', 'T4.5*'])

fac.SetPEGrid(g)
fac.RRTable(filename, ['T1.6*'], ['T3.6*', 'T4.6*'])

fac.SetPEGrid(g)
fac.RRTable(filename, ['T1.7*'], ['T3.7*', 'T4.7*'])

fac.SetPEGrid(g)
fac.RRTable(filename, ['T1.8*'], ['T3.8*', 'T4.8*'])

fac.SetPEGrid(g)
fac.RRTable(filename, ['T1.9*'], ['T3.9*', 'T4.9*'])

fac.SetPEGrid(g)
fac.RRTable(filename, ['T1.10*'], ['T3.10*', 'T4.10*'])

fac.SetPEGrid(g)
fac.RRTable(filename, ['T2.3*'], ['T4.3*', 'T5.3*'])

fac.SetPEGrid(g)
fac.RRTable(filename, ['T2.4*'], ['T4.4*', 'T5.4*'])

fac.SetPEGrid(g)
fac.RRTable(filename, ['T2.5*'], ['T4.5*', 'T5.5*'])


#print the rr table
fac.PrintTable(filename, 'outfile/fe17a_'+str(${level_index})+'_'+str(${index})+'.rr', 1)
eof

	#Execute the FAC python script in this energy range
	python test_${level_index}_${index}.py
	sleep 1
	rm test_${level_index}_${index}.py
	rm outfile/fe17b_${level_index}_${index}.rr
	rm outfile/fe17b_${level_index}_${index}.en
	rm outfile/fe17a_${level_index}_${index}.en
}


#Now we are ready to step into creating the list for each energy range with 20 elements
if (( num_lines % max_points == 0 ))
then
	for i in $(seq 1 ${iteration})
	do
		printf "region: %d\n" ${i}
		for j in $(seq 1 ${max_points})
		do
			line=( $(sed -n $(( (i-1)*max_points+j+1 ))p ${energy_file}) )
			g[$((j-1))]=${line[0]},
		done
		create_run_FAC "${g[*]}" $i
		sleep 1
	done
else
	for i in $(seq 1 $((iteration-1)) )	
	do
		printf "region: %d\n" ${i}
		for j in $(seq 1 ${max_points})
		do
			line=( $(sed -n $(( (i-1)*max_points+j+1 ))p ${energy_file}) )
			g[$((j-1))]=${line[0]},
		done
		create_run_FAC "${g[*]}" $i
		sleep 1
	done
	unset g
	
	#Deal with the last region
	for j in $( seq 1 $(( num_lines-(iteration-1)*max_points )) )
	do
		line=( $(sed -n $(( (iteration-1)*max_points+j+1 ))p ${energy_file}) )
		g[$((j-1))]=${line[0]},
	done
	printf "The second last region is %d\n" ${i}
	printf "region: %d\n" $((i+1))
	create_run_FAC "${g[*]}" $iteration
fi
