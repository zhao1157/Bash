#! /bin/bash

sed -n 1,23p stg2.inp.bp.fe18 > stg2.inp

parity_core=('place-holder' 0 1 0 1 0 1 1 0 1 0 1 0 0)

ssout=fe19_ss.en
line_begin=2
line_end=138

for i in $(seq ${line_begin} ${line_end})
do
	line=( $(sed -n ${i}p ${ssout}) )
	
	S_CORE=${line[3]}
	S_CORE=${S_CORE/-/}	#remove the negative sign in front of S value
	L_CORE=${line[4]}
	P_CORE=${parity_core[${line[5]}]}

	printf "%5s%5s%5s\n" ${L_CORE} ${S_CORE} ${P_CORE} >> stg2.inp
done


sed -n 30,128p stg2.inp.bp.fe18 >> stg2.inp

cat core_e_lsp >> stg2.inp

#sed -n 174,377p stg2.inp.bp.fe18 >> stg2.inp
