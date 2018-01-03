#!/usr/local/bin/bash

file_xsectn=RM_FAC_TOPUP_FINAL_correct

if [ -f total.ps ]
then
	rm total.ps
fi

line=0

for i in $(seq 1 454)
do
	echo $i
	
	data_line=($(sed -n $((line+14))p ${file_xsectn}))
	
	J2=${data_line[1]}
	Pi=${data_line[2]}
	Level=${data_line[3]}

	sed -n $((line+17)),$((line+24767))p ${file_xsectn} > RM_FAC_data

	gnuplot <<eof
		set terminal postscript color enhanced
		set out 'tem.ps'
		set title '${J2}\_${Pi}\_${Level}'
		set logscale y
		set format y "%T"
		set ylabel 'log10({/Symbol s} (Mb))'
		set xlabel 'Photon Energy (Ry)' 
		
		plot 'RM_FAC_data' u 1:3 title 'RM\_60cc' with lines lc rgb 'blue',\
			 'RM_FAC_data' u 1:4 title 'RM+FAC' with lines lc rgb 'red'
			 
eof
	cat tem.ps >> total.ps
	line=$((line+24767))

done 
open total.ps
