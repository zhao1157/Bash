#!/bin/bash

#This script is to collect all the grades of the students and give the final letter grades

#qnum=( [1]=1 ) 
qnum=( [1]=1 [2]=2 [3]=3 [4]=4 [5]=5 )  #5 is for final exam.

sect=( 1140 1143 ) #the class sections
for sect in ${sect[0]} #choose which class to deal with or both/all of them
do

for i in ${qnum[*]}
do
   file=exam${i}_${sect}
   #tput bold
   #echo "##################################"
   #echo "Reading file $file ..."
   #echo "##################################"
   #tput sgr0
   
   line16=( $( sed -n 16p $file ) )
   #echo "The number of students taking the quiz${i} is ${line16[3]}"
   
   for j in $(seq 26 $(( ${line16[3]}+25 )) )
   do
      grdstu=( $( sed -n ${j}p $file ) )
      grdstu[0]=$( echo ${grdstu[0]/,/_} )
      
      #Add the curve to the original scores.
      if [ $i -eq 1 ]
      then
         grdstu[3]=$(echo "${grdstu[3]}+2+3.6"|bc)
      fi
      
      if [ $i -eq 2 ]
      then
         grdstu[3]=$(echo "${grdstu[3]}+0.8"|bc)
      fi
      
      #if [ $i -eq 3 ]
      #then
         #grdstu[3]=$(echo "${grdstu[3]}+2+3.6"|bc)
      #fi
      
      #if [ $i -eq 4 ]
      #then
         #grdstu[3]=$(echo "${grdstu[3]}+1"|bc)
      #fi
      
      #if [ $i -eq 5 ]
      #then
         #grdstu[3]=$(echo "${grdstu[3]}+5"|bc)
      #fi
      
      eval ${grdstu[0]}${grdstu[1]}[${i}]=${grdstu[3]}
      #eval grdstu3_temp='$'{${grdstu[0]}${grdstu[1]}[${i}]}
      #printf "%-25s%-10s\n" ${grdstu[0]}${grdstu[1]} $grdstu3_temp
   done
   
   #tput bold
   #echo "Finished reading file ${file} ..."
   #tput sgr0
done
#Finished reading all the grades for one lecture section. Going to read
#the names from the roster and print all the grades for each student.
   
   if [ -f pro_grades_$sect ]
   then
      rm -f pro_grades_$sect
   fi
   
   while read name
   do 
      name=${name/,/_}
	  #Assign all the grades to grdsstu
      eval grdsstu[1]='$'{${name}[1]}
      eval grdsstu[2]='$'{${name}[2]}
      eval grdsstu[3]='$'{${name}[3]}
      eval grdsstu[4]='$'{${name}[4]}
      eval grdsstu[5]='$'{${name}[5]}
      
      #Some students did not take the final exam.
      if [ -z ${grdsstu[5]} ]
      then
		 eval ${name}[5]=0
	  fi
	  
      #Some students missed one or more exams, so assgin NULL as the grade.
      for index_emp in $(seq 1 5)
      do
         if [ ${#grdsstu[${index_emp}]} -eq 0 ]
         then
            grdsstu[${index_emp}]=NULL	#a place holder.
         fi
      done
   
      printf "%-25s%6s%6s%6s%6s\n" $name  ${grdsstu[1]} ${grdsstu[2]} ${grdsstu[3]} ${grdsstu[4]} >> pro_grades_$sect

   done < rost_${sect}
   
   #Remove NULL
   sed "s/NULL/    /g" pro_grades_$sect > pro_grades_${sect}_temp
   mv pro_grades_${sect}_temp pro_grades_${sect}
   
#Find out the 3 highest scores if the student took 4 quizzes. Only 
#calculate the scores of a student who took at least 3 tests.
   while read -a line
   do
	  echo ${line[0]}
      numele=${#line[*]}
      #echo $numele
      if [ $numele -eq 5 ]
      then
         indmin=1
         for i in $(seq 2 4)
         do
            com1=$(echo "${line[$indmin]} > ${line[$i]}" | bc)
            if [ $com1 -eq 1 ]
            then
               indmin=$i
            fi
         done
      eval ${line[0]}[$indmin]=${line[$indmin]}X
      unset line[$indmin]
      fi
      
      if [ $numele -eq 4 -o $numele -eq 5 ]
      then
         line_tmp=( ${line[1]} ${line[2]} ${line[3]} ${line[4]} )
         eval ${line[0]}[6]=$(echo "${line_tmp[0]}+${line_tmp[1]}+${line_tmp[2]}"|bc) 
      elif [ $numele -eq 3 ]
      then
		 line_tmp=( ${line[1]} ${line[2]} ${line[3]} ${line[4]} )
         eval ${line[0]}[6]=$(echo "${line_tmp[0]}+${line_tmp[1]}"|bc)
      elif [ $numele -eq 2 ]
      then 
		 line_tmp=( ${line[1]} ${line[2]} ${line[3]} ${line[4]} )
         eval ${line[0]}[6]=$(echo "${line_tmp[0]}"|bc)
      else
		 eval ${line[0]}[6]=0
	  fi
      #printf "%-25s%-6s%-6s%-6s%-6s\n" ${line[*]}
   
   done < pro_grades_${sect}

   if [ -f grades_${sect} ]
   then
      rm -f grades_${sect}
   fi
   echo "********************"
######################################################################  
   tput bold
   echo "*********************************************************************************" >>grades_${sect}
   echo "               The grades of students in the $sect section">>grades_${sect}
   echo "                      (X: Lowest Grade of 4 quizzes)">>grades_${sect}
   echo "*********************************************************************************">>grades_${sect}
   printf "Name                  LetGrd AveRod AveGrd Quiz1 Quiz2 Quiz3 Quiz4 Final 3QuizTot\n">>grades_${sect}
   tput sgr0
   while read name
   do 
      name=${name/,/_}
	  echo ${name}
	  
      eval grdsstu[1]='$'{${name}[1]}
      eval grdsstu[2]='$'{${name}[2]}
      eval grdsstu[3]='$'{${name}[3]}
      eval grdsstu[4]='$'{${name}[4]}
      eval grdsstu[5]='$'{${name}[5]} #This is for final exam.
      eval grdsstu[6]='$'{${name}[6]} #This is the sum of all three quizzes.
      
##This addition of 60 to quiz 5 is only for test. Comment it out when the
##real final grades are available.
      #if [ ! ${#grdsstu[5]} -eq 0 ]
      #then
         #grdsstu[5]=$(echo "${grdsstu[5]}+5"|bc)
      #fi
      #########
      
      ##Calculate the averaged total grades.
      #if [ ! ${#grdsstu[5]} -eq 0 -a ! ${#grdsstu[6]} -eq 0 ]
      #then
         #ave_total=$(echo "${grdsstu[5]}*0.4+${grdsstu[6]}*0.5"|bc)
      #fi
      
      #if [ ${#grdsstu[5]} -eq 0 -a ! ${#grdsstu[6]} -eq 0 ]
      #then
         #ave_total=$(echo "${grdsstu[6]}*0.5"|bc)
      #fi
      
      #if [ ! ${#grdsstu[5]} -eq 0 -a ${#grdsstu[6]} -eq 0 ]
      #then
         #ave_total=$(echo "${grdsstu[5]}*0.4"|bc)
      #fi
      
      #if [ ${#grdsstu[5]} -eq 0 -a ${#grdsstu[6]} -eq 0 ]
      #then
         #ave_total=NULL
      #fi
      #60% of the 3 quizzes and 40% of the final exam.
      ave_total=$(echo "${grdsstu[5]}*0.4+${grdsstu[6]}*0.5"|bc)
#Rounding off to the nearset integer.      
      if [ "${ave_total}" = NULL ]
      then
         ave_total_rond=NULL
      elif [ "${ave_total:2:2}" = .5 ] #-a ${ave_total} = 100 -o ${ave_total} = 100.0 ]  
      then
         #echo ${ave_total:2:2}
         ave_total_tmp=$(echo "${ave_total}+0.1"|bc)
         #echo ${ave_total_tmp}
         ave_total_rond=$(printf "%.0f" ${ave_total_tmp})
      else
         ave_total_rond=$(printf "%.0f" ${ave_total})
      fi
#Assigning letter grades.
      if [ ${ave_total_rond} = NULL ]
      then
         grdlet=NULL
      elif [ ${ave_total_rond} -le 49 ]
      then
         grdlet=E
      elif [ ${ave_total_rond} -le 56 ]
      then
         grdlet=D
      elif [ ${ave_total_rond} -le 59 ]
      then
         grdlet=D+
      elif [ ${ave_total_rond} -le 62 ]
      then
         grdlet=C-
      elif [ ${ave_total_rond} -le 71 ]
      then
         grdlet=C
      elif [ ${ave_total_rond} -le 74 ]
      then
         grdlet=C+
      elif [ ${ave_total_rond} -le 77 ]
      then
         grdlet=B-
      elif [ ${ave_total_rond} -le 83 ]
      then
         grdlet=B
      elif [ ${ave_total_rond} -le 86 ]
      then
         grdlet=B+
      elif [ ${ave_total_rond} -le 89 ]
      then
         grdlet=A-
      elif [ ${ave_total_rond} -ge 90 ]
      then
         grdlet=A
      fi
#Assigning NULL to empty elements.
      for index_emp in $(seq 1 6)
      do
         if [ ${#grdsstu[${index_emp}]} -eq 0 ]
         then
            grdsstu[${index_emp}]=NULL
         fi
      done
      
      printf "%-25s%-6s%-6s%-6s%-6s%-6s%-6s%-6s%-6s%6s\n" $name ${grdlet} ${ave_total_rond} ${ave_total} ${grdsstu[1]} ${grdsstu[2]} ${grdsstu[3]} ${grdsstu[4]} ${grdsstu[5]} ${grdsstu[6]} >>grades_${sect}
   done < rost_${sect}
########################################################################
   if [ -f tmp ]
   then
      rm -f tmp
   fi
   sed "s/NULL/    /g" grades_${sect} > tmp
   mv tmp grades_${sect} 
done

