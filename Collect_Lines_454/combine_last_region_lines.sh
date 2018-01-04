#! /bin/bash

if [ -f 454_points_last_region ]
then
	rm 454_points_last_region
fi

for i in $(seq 1 454)
do
	cat line_last_region_dir/${i} >> 454_points_last_region 
done

