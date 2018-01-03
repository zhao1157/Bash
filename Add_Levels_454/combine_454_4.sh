#! /usr/local/bin/bash

#This script is to combine the 454 levels in order into one single file both for lines_20
#and lines_11

dir_lines_20=../xsectn_line_3/lines_20
dir_lines_11=../xsectn_line_3/lines_11

file_20=454_points_20
file_11=454_points_11

if [ -f ${file_20} ]
then
	rm ${file_20}
fi

if [ -f ${file_11} ]
then
	rm ${file_11}
fi

for J in $(seq 0 8)
do
	for Pi in 0 1
	do
		cat ${dir_lines_20}/${J}_${Pi}_final >> ${file_20}
		cat ${dir_lines_11}/${J}_${Pi}_final >> ${file_11}
	done
done


