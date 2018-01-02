#!/bin/bash

for m in 300 310 311 320 321 330 331 340 341 350 351 360 361 370 371 380 381 390 391 3100
do

   if [ ${m} -eq 300 ]; then
   	       j=0
           k=11
   elif [ ${m} -eq 310 ]; then
           j=11
           k=8
   elif [ ${m} -eq 311 ]; then
           j=19
           k=18
   elif [ ${m} -eq 320 ]; then
   	       j=37
           k=17
   elif [ ${m} -eq 321 ]; then
           j=54
           k=8
   elif [ ${m} -eq 330 ]; then
           j=62
           k=7
   elif [ ${m} -eq 331 ]; then
           j=69
           k=15
   elif [ ${m} -eq 340 ]; then
           j=84
           k=12
   elif [ ${m} -eq 341 ]; then
           j=96
           k=5
   elif [ ${m} -eq 350 ]; then
           j=101
           k=4
   elif [ ${m} -eq 351 ]; then
           j=105
           k=10
   elif [ ${m} -eq 360 ]; then
           j=115
           k=8
   elif [ ${m} -eq 361 ]; then
           j=123
           k=3
   elif [ ${m} -eq 370 ]; then
           j=126
           k=2
   elif [ ${m} -eq 371 ]; then
           j=128
           k=6
   elif [ ${m} -eq 380 ]; then
           j=134
           k=2
   elif [ ${m} -eq 381 ]; then
           j=136
           k=1
   elif [ ${m} -eq 390 ]; then
           j=137
           k=1
   elif [ ${m} -eq 391 ]; then
           j=138
           k=2
   elif [ ${m} -eq 3100 ]; then
           j=140
           k=1
   fi
   
   line=$((21+5025*${j}))
   
   for i in $(seq 1 1 ${k})
   do
      sed -n ''$((line+1))', '$((line+5004))'p' p2609.tpt.99cc > ${m}_${i}_coarse
   	
   	  line=$((line+5025))
   done
done

mv 3* tpt_coarse




#for j in 0 12 37 59 76
#do
#
#line=$((25+9024*${j}))
#for i in $(seq 1 1 5)
#do
#
#if [ ${j} -eq 0 ]; then
#sed -n ''$((line))','$((line+8999))'p' pt2609.sgt.5 > pt5_sgt_100_${i}
#line=$((line+9024))
#sleep 1
#fi 
#
#if [ ${j} -eq 12 ]; then
#sed -n ''$((line))','$((line+8999))'p' pt2609.sgt.5 > pt5_sgt_120_${i}
#line=$((line+9024))
#sleep 1
#fi 
#
#if [ ${j} -eq 37 ]; then
#sed -n ''$((line))','$((line+8999))'p' pt2609.sgt.5 > pt5_sgt_130_${i}
#line=$((line+9024))
#sleep 1
#fi 
#
#if [ ${j} -eq 59 ]; then
#sed -n ''$((line))','$((line+8999))'p' pt2609.sgt.5 > pt5_sgt_140_${i}
#line=$((line+9024))
#sleep 1
#fi 
#
#if [ ${j} -eq 76 ]; then
#sed -n ''$((line))','$((line+8999))'p' pt2609.sgt.5 > pt5_sgt_150_${i}
#line=$((line+9024))
#sleep 1
#fi 
#
#done
#done
