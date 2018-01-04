#! /usr/local/bin/bash

if [ -d FAC_mesh_dir ]
then 
	rm -rf FAC_mesh_dir
	mkdir FAC_mesh_dir
else
	mkdir FAC_mesh_dir
fi

for i in $(seq 1 454)
do
	./generate_FAC_mesh_2 ${i}
done

