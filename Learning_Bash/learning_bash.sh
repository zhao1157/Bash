#! /usr/local/bin/bash

#=======152======
#This is to test the emptyness of a variable
a=""
if [ -z ${a+x} ]
then
	echo "empty"
fi


##==========151==========
##This script is to practice for loop
#j=3
#for ((i = j ; i <= 4; i++))
#{
	
	#printf  "%d\n" $i
	
	
#}





##========150=======
#for i in $(seq 1 10)
#do
	#if [ $i -lt 10 ]
	#then
		#line_start=$(( (i-1)*5000+1 ))
		#line_end=$(( i*5000 ))
	#else
		#line_start=$((9*5000+1))
		#line_end=50938
	#fi
	
	#if [ -d run_${i} ]
	#then
		#rm -rf run_${i}
	#fi
	
	#mkdir run_${i}

#done 





##======149======
##This script is to practice for loop
#for ((i = 1; i <= 4; i ++))
#do
	#printf "%i " $i

#done 

#printf "\n"




##======148======
##Again this is to verify that variables are global in shell script
#function test_func()
#{
	#echo "In the function: " $a
	#a=3sd
#}

#a=3

#test_func

#echo "outside of the function: " $a




##========147==========
#cat << eof > RM_FAC_data
#1 2 3 4
#2 3 4 5
#3 8 48 89
#eof


#J2=2
#gnuplot -p <<eof
		#plot 'RM_FAC_data' u 1:3 with lines lc rgb 'blue', \
		 #'RM_FAC_data' u 1:4 title 'RM+FAC' with lines lc rgb 'red'
#eof

##open tem.ps





##======146======
##This script is to verify that the variables in shell script is global by default
#function test_func()
#{
	#a=$1
	#echo In the function ${a}
#}

#b=x

#test_func ${b}

#echo Out of the function ${a}




##========145=========
#function test_func()
#{
	#g=$1
	#echo ${g[*]}	
#}

#a=(2, 3, 4,)

#test_func "${a[*]}"



##=======144=======
#for i in $(seq 1 4)
#do
	#if [ ${i} == 2 ]
	#then
		#continue
	#fi
	
	#echo $i


#done 
#a=2
#for i in $(seq 1 $((4-a)))
#do
	#echo $i

#done 

#a++
#echo $a




##=======143======
##This script is to practice ==
#cat << eof > a143
#0
#eof

#line=$(sed -n 1p a143)

#echo ${line} $((line+1))

#if [ ${line} == 0 ]
#then
	#echo exiting 
	##exit
	#echo good
#else 
	#echo bad
#fi

#if ((0 % 20 == 0))
#then
	#echo $((0/20))
#else
	#echo 1
#fi





##=======142======
#a='love'
#b='you'

#c='x''me'
#echo $c

#a=23

#if (((a-1) % 2 == 0))
#then
	#echo 0
#else
	#echo 1
#fi

#echo $(((a-1)%2))

#a=22
#a=$((a-1))
#echo $a


##======141=====
#i=1
#j=3
#gnuplot << eof
#set terminal postscript color enhanced
#set output "tem.ps"
#set title '${i}\_${j}'
#set ylabel '{/Symbol s}PI'
#plot sin(x)
#eof

#open tem.ps





##======140=======
##This script is to practice local keyword
#for i in 1
#do
	##local j=3	 #wrong, as keyword local can only be used in a function.
	#j=3	#Usually variable is global.
#done
#echo $j



##======139======

#if ! [ 3 == 3 -a 2 == 3  ]
#then
	#echo no
#fi



##========138========
#cat << eof > a138.sh
#sleep 5
#echo "end"
#eof

#chmod u+x a138.sh

#for i in $(seq 1 4)
#do
#./a138.sh & 	#This is show that & can be useful if you want to submit one than one job
				##in the same node.
#done




##=====137======
#cat << eof > a137
#printf "before exit command\n"
#exit 
#printf "after"
#eof

#chmod u+x a137

#./a137

#echo a137



##======136======
##This script is to practice something below.
#i=2
#eval a_${i}=23

#eval echo sd '$'{a_${i}}

#j=2
#eval b_${j}+='($((i+23)))'
#eval b_${j}+='($((i*23)))'
#echo ${b_2[*]}


##======135======
##This script is to parctice creating a list and assigning it to a variable by here document.
#cat << eof > a135
#line 1 2.3E-3
#line 2 2.34E-1
#line 3 2.34E0
#line 4 2.10E2
#line 5 2.39e3
#eof

#num_lines=$(sed -n $= a135)

#printf "num_lines=%d\n" ${num_lines}

#declare -a g

#for i in $(seq 1 ${num_lines})
#do
	#line=( $( sed -n ${i}p a135 ) )
	#g[$((i-1))]="${line[2]} ,"	#Here the RHS is string literal which does not need + to 
								##concatenate. Different from other language, like python.
	
#done

#echo ${g[*]}
##creat_file g	#The definition of a function has to be in front of its being called.
#function creat_file()
#{
	#echo "In the function, test_value = " ${test_value}
	#declare -n gg=$1
	#cat << eof > data 
#g=[${gg[*]:0}]
#eof
#}

#test_value=135	#This is used to test that the variables in the function is by default 
				##global.

#creat_file g
#cat data 
#rm a135


##=======134=======
##This script is to practice feeding arguments into python program
#cat << eof > test.py
##! /usr/bin/python
#import sys 
#print "love " + sys.argv[0]
#eof

#chmod u+x test.py 
#./test.py 




##=======133======
#function test_func ()
#{
	#declare -n a b
	#a=$1
	#b=$2
	#c=23s
	#echo ${a[name]} $b
	#a[name]=dog	#When variables are referenced, the modifications made will be reflected
				##back to its original copy. In other words we are making changes directly
				##to the original variable.
#}

#declare -A bb

#bb=([name]="zhao Lianshui" [2]=2)
#love=l
#test_func bb love

#echo ${bb[*]} $c



##=====132=====
##This is to test the if statement when the value has spaces in it
#a="my love"

#if [[ $a == "my love" ]]	#[[]] has to be used, nor [] or (()), only [[]]. What's the 
							##difference among [], (()), [[]]?
#then
	#echo x
#fi

#echo "$BASH_VERSION $POSIXLY_CORRECT"



##=====131=====
##This script is to practice the space in the key of an associative array
#declare -A a

#a=([xy]="XY" [x2]="m n")
#echo ${!a[*]} ${a[x y]}
#b="X Y"
#if [[ ${a[xy]} == $b ]] #As long as the value of the variable has a space in it, then
						##double square brackets should be used. If "X Y" is used directly
						##used in the statement, then no need double square brackets.
#then
	#echo god
#fi

#if [[ ${a[x2]} == "m n" ]]
#then
	#echo xx
#fi


#b=s
#if [ $b == "s" ]
#then 
	#echo good
#fi

#if (( 2/3 == 0 ))	#If the expression needs to be evaluated, use (())
#then
	#echo __
#fi


##=====130======
##If you want to use an associative array, then you have to declare it. Also associative 
##array does not exist in old version of bash, but exists in new bash-4. Thus even though 
##you are using the bash-4 version, you still need to declare it with option -A (-a just
##means a ordinary array).
#declare -A a
#a=([fn]=lianshui [xsfsdf1]=info [ln]=Xhao)
#echo ${!a[*]}
#index=( $(echo ${!a[*]}) )
#for i in ${index[*]}
#do
	#echo $i ${a[$i]}

#done



##=====129=======
#cat <<eof > a.sh
#echo \$0
#for i in \$@
#do
	#echo \$i
#done
#eof

#chmod u+x a.sh

#./a.sh sd sd f 2


##=====128=======
#a=2
##Here '-n' makes the next prompt continues at the end of previous output line.
#echo -n a = 
#echo $a





##======127==========

##!/usr/local/bin/bash	#This is calling bash 4.
#a=69

#if [ $a -ge 1 -a $a -le 2 -o $a -ge 54 -a $a -le 68 ]
#then
	#echo eq
#fi



##==========126=========
##This script is to practice awk
#cat << eof >a126
#hi xx00
#l o
#voe
#xxoo 2 3 4
#eof

#awk /hi/ a126	#By default, the action is to print the line that matches with the pattern
#awk /xx/ a126
#awk '/ /' a126
#echo "======" 
#awk {print} a126	#Here the action has to be in curly braces
#echo "========"
#awk /^x/ a126	#just like sed, ^ means the beginning
#awk /o$/ a126	#again, $ means the end of the line
#echo "========="
##column=3	
#awk '/^x/{print $3;}' a126	#be advised that you should keep '', here $3 mean the third 
							##column, but how to use a variable to represent it?


##=======125=========
##This is test the absolute value function
#a=2
#b=3
#c=$((a-b))

#echo $c

##basically this is the abbreviation of if else statement.
#c=$([ $c -lt 0 ] && echo $((-c)) || echo $c)

#echo $c


#d=(1 2 32s)
#echo ${d[$(( ${#d[*]}-1 ))]}



##======124======
##This is to test -gt
#if [ 2 -gt 10 ]
#then
	#echo greater
#fi

#a=2
#b=93
#c=$(echo $((a-b)))
#echo $c
#c=${c/-/}

#echo $c



##======123==========
##This is to test if an array can be overwritten
#a=(0 1 2 3)
#a=(xsdfsd x s)	#afte testing, I found the array is completely overwritten. GOOD.
#a[1]=xx	#This only change the value of one element.
#echo ${a[*]} ${#a[*]} ${a[3]}



##========122==========
##This is to practice mod operator
#a=$(( 5%2 ))	#even or odd parity
#echo $a

#echo $((4%2))


##=========121========
#for i in $(seq 2 4) $(seq 12 20)
#do
	#echo $i
#done

#printf "%d\n"  $(( abs(-10) ))


##=======120========
#a=b
#c=32
#eval ${a}=8
#echo $b

#a=sd3.23sd
#echo ${a/.2/}

#a=3
#while [ ${a} -le 5 ]
#do
	#echo $((a++))
	
#done

#echo "==="  $a


#a=2
#b=3
#eval c${a}${b}=23
#d=c${a}${b}
#eval echo ${!d}

#a=sdf3sd
#if [ $a = 'sdf3sd' ]
#then
	#echo good
#fi

#echo "=============="
#if [ 2 -ne 2 ]
#then
	#echo noequal
#fi
#echo "==========="

#a=2
#b=${a}.txt
#echo $b


##======119=========
##This script is to practice exit from a shell

#if [ 28 -eq 2 ]
#then
	#echo "equal"
	#exit
#elif [ 2 -eq 2 ]	#No else if, only elif
#then
	#echo hi
#fi

#echo "out"

#a=2
#echo $((a\
  #+ 2))
#echo $a



##======118========
##break
#for j in 1 2
#do
	#echo "j: " $j
	#for i in $(seq 1 3)
	#do

		#if [ ${i} -eq 2 ]
		#then
			#continue 
		#fi

		#echo $i
	#done
#done
#echo "end"



##=======117========

#for index in $(seq 1 2 3)
#do
#cat > a117 << eof
       ##PBS -l walltime=20:00:00
       ##PBS -l nodes=1:ppn=1
       ##PBS -N bb_fac_ss_K_${index}
       ##PBS -j oe
       ##PBS -S /bin/ksh
##
#cd /users/PAS0578/osu2225/LZ/fac-master/fe17_2/bb_multiply/K
#./bb_fac_ss_modified.sh fe17a_K_shell.en fe17a_K_shell.tr ${index}
##========
#eof
#cat a117

#done




##=========116=======
#a=3
#for i in $a
#do
	#echo $i
#done


##========115=======
#a=0.0023243

#a=$( printf "%.4E" $a)
#echo $a
#a=${a/'E-0'/'E-'}
#echo $a

#b=2.3234232432423343434E-02
#printf "%.8E\n" $b


##=======114========
#a=-0.23
#b=${a/'E-'/'*10^-'}

#echo $b
#echo "${b}" | bc -l


#if (( $(echo "scale=11; ${b} <= 0" | bc) )) 	#when the number is very small, use -l so that
										##the tiny number is interpreted as non-zero, or
										##use scale=11 etc.
#then
	#echo "<0"
#fi

#c=$(echo "0.0001/3" | bc -l )
#echo $c

##========113========
##This script is to practice the algebra

#a=3

#for i in $( seq $((a+2)) 2 $((a+8)) )
#do
	#echo $i
#dones

#for i in 1 0 
#do
	#echo $i
#done

#touch a113
##echo "hi" > a113
#if [ -f a113 ]
#then
	#echo "a1113 exists"
#fi

#if [ ! -s a113 ]	#see man test, which says -s verifies whether the file is empty is not.
#then
	#echo "a113 is empty"
#fi
#rm a113



##=======112========
#A=--2.3E-03--
#echo ${A/#-/n}	#here # is the front end
#echo ${A/%-/E}	#here % is the back end


##=======111==========
#cat > a111 << eof
#0
#hi MIKE
#3s
##sd'3s.3 *.x'
#end mike

#END
#eof


#sed /'*'/d a111




##=======110========
#a=2.3*10^0
#b=-2.1*10^-0
#b=${b/-/}71 1237916 2657
#echo $b
#echo "${a}+${b}"|bc

#if [ 2 -le -22 ]	 #-ge
#then
	#echo "true"

#fi



##=========109============
#mkdir d109

#touch d109/a.txt

#if [ -f d109/a.txt ]
#then
	#echo "Exist"
#fi

#rm -rf d109



##==========108========
#cat > a108 << eof
#hi wold
#Hi wold
#eof

#sed  s/'hi wold'/'HI WORLD'/ a108 > temp

#cat temp


##=======107=======
##Test the scale in bc

#echo "scale=1; 2.323/23"|bc



##=======106========
##test the array
#a=([0]=1 [1]=2 [2]=3 [2]=33 [xx]=hi [yy]=HI)

#echo ${a[0]} ${a[xx]} ${a[yy]}


##=======105======
##test the scale in bc
##scale set the precision
#echo "20/3"|bc 



##======104========
##This script is to distinguish a variable of length of 0 and an unset variable

#b=''

#if [ -z "${b+x}" ]	#it's true only if b does not exist.
#then
	#echo "b is not existing"
#fi

#if [ -z "${b}" ]	#it's true if b is empty or not existing
#then
	#echo "b is empty"
#fi



##======103===========
#for i in $(seq 1 3) 5 $(seq 8 10)
#do
	#echo $i
#done



##========102===========
#cat <<eof >a102
#1 2
#2 4
#3 6
#4 10
#3 8
#2 7
#1 2

#eof

#gnuplot -p <<eof 
#plot 'a102' with lines
#eof


##==============101===========
#gnuplot -p << eof 
#plot sin(x) lt -1
#eof

##=========100=========
##This program is to test the command = to find the line number in which some pattern is 
##found.
#cat << eof >a100
#Seth
#s d
#Se thhizsd
#sdfsd

#eof

#sed -n /' '/= a100

#sed -n /^$/= a100


##===========99==============
#i=1
#j=3
#gnuplot << eof
#set terminal postscript color enhanced
#set output "tem.ps"
#set title '${i}\_${j}'
#set title "{/Symbol s}PI"
#plot sin(x)
#eof

#open tem.ps


##==========98===========
#a=-223.34*10^-2

#if (( $(echo "$a < 0"|bc -l) ))
#then 
	#echo ${a/-/}
#fi


##============97==========
#a=(2  4)
#echo $((a[0]+2))

#printf "%2s%2s\n" ${a[*]:0}

#b=${a[1]/4/sdfwerwerw}

#echo $b



##=============96============
#cat <<eof >a96
  #-0.929251E+02      24652
  #-0.929251E+02      24652
  #-0.929251E+02      24652
#eof

#sed s/24652/24751/ a96 > tem
#cat tem



##===========95============
#cat << eof >a95
#a9
#a9

#a95
#eof

#cat << eof >a95_1
#a5
#a5

#a51

#eof

#cat <<eof >a95_2
#Muzi
#zli

#end
#eof
#cat a95 a95_2 a95_1 >a95total #They are in order.
#cat a95total


##=========94=========
#a=2.23432342342
#printf "%11.4E\n" $a

#a=2.34E-1
#b=$(echo ${a/E-/*10^-})

#printf "%.4E\n" $(echo "0.1+$b"|bc -l)
#echo $"0.3222234234234234234234234231111111112"|bc -l
#echo "1/3"|bc -l
#printf "%.4E\n" $(echo "0.323432+1.342"|bc -l)
#printf "%11s\n" NONE
#a=3sses
#echo ${a//s/!}

##=========93============
##This program is to practice the break in the loop.
#for ((i=1; i<=4; i++))
#do
	#echo $i
	#if [ $i = 3 ]
	#then
		#break
	#fi
#done


##============92============
##This program is to practice the exit in a function.
#function	test_func(){
	
	#echo "before breaking ..."
	#exit  
	#echo "after breaking ..."
	
#}
#test_func
#echo "out"


##============91=============
##This program is to test the exit command in the script. It will terminate the whole
##script when exit is encountered.
#a=2
#if [ $a = 2 ]
#then 
	#echo "exiting"
	#exit
#fi

#echo 'end' 


##===========90==============
##This program is to test that = is good in any case, while -eq is only valid in integer
##case.
#a=2

#if [ $a = 2 ] #[ $a -eq sd]
#then
	#echo equal
#fi


##=======89==========
##This program is to practice the associative array that we do not need ${ref} to refer 
##to the original variable, but ref is sufficient. $ref=${ref[0]}
#function test_func(){
	#declare  -n ref=$1
	#echo '$ref ' $ref 
	#keys=( $(echo ${!ref[*]}) )
	#local i
	#for ((i=0; i<${#keys[*]}; i++))
	#do
		#printf "%4s %4s\n" ${keys[$i]} ${ref[${keys[$i]}]}
	#done
#}

#declare -A data=( [0]=value_at_the_point [2_3]=3 [2]=4 )

#test_func data 



##==========88============
##One of the advantages of using associative array to find the minimum value is that 
##it can save the original index without being destroyed when piped into an array.

#function inde_mini(){	#a function to find the key of the minimum element in an 
						##associative array.
	#declare -n ref=$1
	
	#echo "inside ref= " $ref 
	
	#local i
	#keys=( $(echo ${!ref[*]}) )
	
	#index=${keys[0]}
	#mini=${ref[${index}]} #{${keys[0]}}
	
	#for ((i=1; i<${#keys[*]}; i++))
	#do
		
		#if (( $(echo "${mini} > ${ref[${keys[${i}]}]}"|bc) ))
		#then
			#index=${keys[${i}]}
			#mini=${ref[${keys[${i}]}]}
		#fi
	#done
	##echo $index $mini	
	##unset ref[$index]
#}

#declare -A data=( [0]=0 [1]=323.2 [2]=24.3 [3]=242.1 [4]=890.3 )

#iteration=${#data[*]}

#for ((i=1; i<=${iteration}; i++))
#do
	#inde_mini data 
	#echo $index $mini
	#unset data[$index]
#done


##========87==========
#function test_func(){
	#var=$1
	
	#eval echo '$'{#$var[*]}
	
	#eval echo '$'{$var[*]:2}
	#eval ${var}[2]=sd
	#eval echo '$'{${var}[2]} "in"
	#local c=3
	
#}

#a=(2 3 7 4)
#test_func a

#echo ${a[*]} out $c

##========86==========
#test_func(){
	#declare -n ref 		#nameref is local. It can indirectly change the value of the
						##variable.
	##local -n ref
	#ref=$1
	
	#echo $ref 
	
	#ref=22	
	#echo $ref in	
#}
#a=3
#test_func a

#echo $a out $ref 

##===========85=============
#test_func(){
	#ref=$1
	#eval echo '$'$ref
	#ref=322
	
	
#}

#a=2
#echo $ref #Before the function is called, ref is not declared yet.
#test_func a
#printf "%2s\n" $ref 	#After the function is called, ref is declared and treated as
						##a global variable.



##=============84==========
#declare -A data84
#data84=( [Tom]=23 [Lucy]=32 )
#echo "The keys of data84 are" ${!data84[*]}

#function test_func()
#{
	###Create a name reference -n
    ##local -n data=$1
	##echo ${data[Tom]}
	##data[Tom]=$((data[Tom]+1))
	##echo ${data[Tom]}
	
	#data=$1
	#eval echo '$'{${data}[*]}
	#keys=( $(eval echo '$'{!${data}[*]}) )
	#echo ${keys[*]}
	#echo ${#keys[*]}	
#}

#test_func data84

#eval echo '$'{${data}[Tom]}


##============83==============
##This is to practice the test option -n and -z to find if a variable exists, be sure to
##include +x and "".
#a=''
#s=2		#Here it does not matter what x is.
#if [ -z "${a+x}" ]	#True if the length of the string is zero, but it does NOT 	distinguish
					##an unset variable and an empty variable, but "+x" does the trick
#then
	#echo "unset"
#fi

#if [ -n "${a+s}" ]	#True if the length of the string non-zero, but it does not distinguish
					##an empty variable, but "+x" does the trick.
#then
	#echo "set"
#fi


##================82=================
##This is to practice the associative array.
#declare -A Score
#Score=( [Tom]=89 [Lucy]=90 )
#echo ${Score[Tom]} ${Score[Lucy]}

#declare -A data82
#num_row=4
#num_column=3

#for ((i=1; i<=${num_row}; i++))
#do
	#for ((j=1; j<=${num_column}; j++))
	#do
		#data82[$i, $j]=$( echo "$i*1.2"|bc )
		#printf "data82[$i, $j]=%4s" ${data82[$i, $j]}
		#printf "%4s\n" ${data82[1, 1]}
	#done
#done

#if (( $(echo "${data82[2, 1]} < ${data82[3, 1]}"|bc) ))
#then
	#echo less
#fi

#echo ${data82[2, 2]} ${data82[2, 3]}
#unset data82["2, 2"] data82["2, 3"]
#echo After unsetting data82[2, 2], now it is ${data82[2, 2]} ${data82[2, 3]}

#echo ${!data82[*]} #output all the keys of the associative array.

##if [ ${data82[1, 1]} -lt ${data82[2, 1]} ]
##then
	##echo less
##fi


##==========81==============
##This is to test -ne, which is right

#if [ 2 -ne 1 ]
#then
	#echo "noequal"
#fi
	
#if [ ! 2 -eq 1 ]
#then 
	#echo "noequal"
#fi


##=============80==============
##This is to test the float number comparison using bc.
#a=$(echo "1.0878 < 0" | bc)
#echo $a

#if (( $(echo "1 > 0"|bc) ))
#then
	#echo  wsdfs232
#fi

##==========79==============
##This is to test printf of array elements.

#a=(2.3 34.2 1e3)
#printf "%6.2f\n" ${a[*]}	#This will output all the elements in the format of %6.2f\n.
#printf "%6s %6s %6s\n" ${a[*]}	#This will output this array horizontally.

##==============78=============
##This is just to test how to do not equal 
#if [ ! 2 -eq 1 ]
#then
	#echo "2 is not equal to 1"
#fi


##===========77==========
##There is no else if [], use elif instead.
#a=8
#if [ $a -eq 2 ]
#then
	#echo 2
#elif [ $a -eq 3 ]
#then	
	#echo 3
#else 
	#echo no
#fi

##==============76==========
#cat << eof >a76
#This is the first line
#2
#sdf
#gf
#eof
#a=2
#sed '/f/ c \
#$(pwd)
#' a76

#rm a76

##============75==========
#echo "scale=7; 2.3/2.1"\
                       #| bc


##============74==========
##practice deleting the lines starting with one or more spaces, upper
##case letters or digits. Note '-ibak' is the option to edit in the original
##file.
#cat << eof >a74
#Hi
 #My
  #Name
 
  #1234 56789
    #Mi

#isd
#d
#sw
#23sd
#* sd
#eof
#sed -ibak /'  [[:upper:]]'/d a74
##sed /^[[:upper:]]/d a74
##echo 
##sed /^[[:digit:]]/d a74
##echo "======delete space=========="
##sed /^[[:space:]]/d a74
##echo "=======delete empty line========"
##sed /^$/d a74
##echo "======Edit in the file directly========"
##sed -ibak /"* "/d a74


##=========73==========
#cat << eof >a74
#hi my
#name is
#seth zhao
#eof
#i=1
#sed -n 1,$((i+2))p a74
#rm a74


##=========72==========
#cat <<eof >a72
#hi
#H
 #23 sd

#1
#eof
#sed '/^$/d' a72
#sed '/^[a-z, A-Z]/d' a72
#sed '/[a-z]$/d' a72


##=========71========
#cat << eof >  a71
#hi
#we
#hi
#eof

#sed 's/^h/#h/' a71

##========70========= 
#for log in set unset 
#do 
#gnuplot -p <<eof
#${log} logscale
#set xrange [2:3]
#plot sin(x)+23

#eof
#done

##=============69==============
#cat <<eof >a69
#100 1
#1000 10
#10000	1000
#eof

##xstics: only labeled where it's specified. 0 for major and 1 for minor.
#gnuplot -p <<eof 
#set logscale
#set ticscale 2
#set xtics 10
#set ytics 100
#set xtics ("2.0" 100 0,500 1, "3.0" 1000 0, 5000 1, "4.0" 10000 0)
#set yrange [1:1000]
#set format "%T"
#set xrange [100:10000]
#set title 'a69\_plot'
#plot 'a69' u 1:2 with lines title "a69"


#eof



##10^{%L}: 10^2, etc. %T: only the power. %t: only the mantissa
##%g: 1000. ticscale: change the size of the ticks.
#gnuplot -p <<eof 
#set format y "T"
#set format y "%g"
#set format y "%t"
#set format  "10^{%L}"
#set ticscale  2
#set style line 1 lw 2 lt 3 lc rgb 'red' pt 10 ps 2
#plot 'a69' using 1:2 with linespoints ls 1 title "a69"

#eof




##===========68==========
##This is an example of do-while loop.
#while 
#read -p "i: " i
#((i < 12))
	
#do :; done


##==========67===========
#rm 67.eps
#for i in $(seq 1 3)
#do 
#gnuplot << eof
#set terminal postscript enhanced color
#set output "${i}.eps"
#plot x**${i} lc rgb "red"
#eof
#cat ${i}.eps >> 67.eps
##echo "false 0 startjob pop" >> 67.eps     #There is no need.
#done
#open 67.eps


##===========66=============
##When setting the terminal for postscript, NOT NOT add eps behing postscript.
#rm 66.eps
#for i in $(seq 1 4)
#do
#gnuplot << eof
#set terminal  postscript enhanced color
#set output "${i}.eps"
#set style line 1 lt 9 lw 2 lc rgb 'blue' pt 0 
#plot x**${i} with linespoints ls 1
#eof

#cat ${i}.eps >> 66.eps
#echo "false 0 startjob pop" >> 66.eps
#done

#open 66.eps

##===========65==========
#m=100
#K=2

#if [ $m -eq 100 -a -f sgt_combine_600_ry.eps ]
#then
        #rm -f sgt_combine_600_ry.eps
#fi

#for k in $(seq 1 ${K})
#do
        #if [ ${k} -gt 9 ]
        #then
                #gnuplot  <<eof
                #set terminal postscript enhanced color
                #set output '${m}_${k}.eps'
                #set title '${m}\_${k}'
                #set xlabel 'Photon Energy (ev)'
                #set ylabel 'Photoionization Cross Section (Mb)'
                #set logscale y
                #set format y '%.1e'
                #set style line 1 lt 1 lw 2 lc rgb 'red' pt 0
                #unset key
                #plot "${m}\_${k}" using 1:3 with linespoints ls 1
#eof
#else
                #gnuplot  <<eof
                #set terminal postscript enhanced color
                #set output '${m}_${k}.eps'
            
                #set style line 1 lt 1 lw 2 lc rgb 'red' pt 0
              
                #plot "${m}\_0${k}" using 1:3 with linespoints ls 1
#eof
        #fi
#cat ${m}_${k}.eps >>sgt_combine_600_ry.eps
#echo "false 0 startjob pop" >> sgt_combine_600_ry.eps
#rm ${m}_${k}.eps
#done
#open sgt_combine_600_ry.eps




##==========64===========
#if [ -f 64.eps ]
#then
    #rm 64.eps
#fi

#for i in $(seq 1 4)
#do
#cat << eof >data64
#1 ${i}
#2 $((i**2))
#3 $((i**3))
#4 $((i**4))
#eof

#gnuplot << eof
#set origin 0,0
#set terminal postscript eps enhanced color
#set output "${i}.eps"
#set style line 1 lt 1 lw 2 lc rgb 'red' pt 0 ps 0
#plot 'data64' with linespoints ls 1
#eof
#cat ${i}.eps >>64.eps
#echo "false 0 startjob pop" >> 64.eps
#done
#open 64.eps



##=========63==========
#gnuplot -p << eof
#set ylabel '{/Symbol s}_{PI}'
#plot sin(x)
#eof

##==========62==========
#cat << eof > data62
 #x y x y x
#1 13 -2e-1  1e-1  1e0
#3 23 3e-1   1e2  1e+1
#4 33 4e-1   1e-7  1e+2
#5 03 5e-1   1e6  1e+3
#eof

#gnuplot -p << eof
#set logscale xy
#set format xy '%.1e'
#set xtic(1,10,100,1000,1500)
#set ytic(1e-6, 1e-2)
#set style line 1 lc rgb 'red' lt 9 lw 2 pt 0 ps 0
#set style line 2 lt 2 lw 2 lc rgb 'black' pt 7 ps 1
#set title 'PLOT'
#set xlabel 'X\_X'
#set ylabel 'Y\_Y'
#unset key 
#plot 'data62' using 5:4 with linespoints ls 2
#eof
#cat data62


##=============61=============
#i=3
#gnuplot -p  << eof
    #plot x**${i}
#eof


##============60===========
##When _ is needed, just put _ to where it's wanted in the name of the
##name of the file, but \_ inside of the graph, where LaTex is applied.
##And in both cases, single quotes are needed in here-document.
#num=60
#for i in $(seq 1 2)
#do
    #gnuplot <<eof
        #set terminal png
        #set output 'a${num}_${i}.png'
        #set title 'PLOT\_${i}'
        #set xrange [-pi:pi]
        #set yrange [-1:1]
        #set zeroaxis
        #set xlabel 'x\_x\_${i}'
        #set ylabel 'y\_y\_${i}'
        #plot sin(x)/x*${i}
#eof
#open a${num}_${i}.png
#done


##===========59===============
#cat << eof >a591
#2
#3
#3
#eof

#cat << eof > a592
#11
#11
#1
#eof

#cat a591 a592 > a59
#cat a59 

##============58==========

#cat << eof > a58
     #sd
#eof
#sed -n "1p" a58 #Will print out exact the same thing in the file.
#rm -f a58


##========57=============
#cat << eof > a57
#1 
#2
#3
#eof
#line=0
#sed -n $((++line))p a57
#echo $line 
#rm a57

##===========56==============
##gnu-parallel does not work on my mac.
#cat << eof >a56.sh

    #echo hi!
#eof
#chmod u+x a56.sh

#export OMP_NUM_THREADS=2
#module load gnu-parallel/20140622
#parallel -j 2 << eof
#cd /Users/lianshuizhao/Box\ Sync/Shell_Scripting_Learning; ./a56.sh
#cd /Users/lianshuizhao/Box\ Sync/Shell_Scripting_Learning; ./a56.sh
#eof


##===========55===============
##This program is to test output from loops.
#for i in $(seq 3)
#do
    #echo $i
#done > a55

#for i in $(seq 4 6)
#do
    #echo $i
#done >> a55
#cat a55



##============54===============
#cat << eof >a54
   #26    9   99 LS-states      IPRINT,IBUT = -3  0     20161219 014418.998
  #0.000000E+00  0.970230E+01  0.571243E+02  0.572239E+02  0.583350E+02
  #0.591195E+02  0.594258E+02  0.596219E+02  0.596449E+02  0.597874E+02
  #0.597874E+02  0.599167E+02  0.603357E+02  0.606260E+02  0.612987E+02
  #0.616305E+02  0.624950E+02  0.626988E+02  0.627470E+02  0.630026E+02
  #0.633085E+02  0.633310E+02  0.633969E+02  0.636831E+02  0.639190E+02
  #0.642474E+02  0.642531E+02  0.653703E+02  0.653886E+02  0.659729E+02
  #0.673893E+02  0.680906E+02  0.682955E+02  0.683678E+02  0.684983E+02
  #0.692508E+02  0.704924E+02  0.706600E+02  0.708574E+02  0.708574E+02
  #0.709908E+02  0.710023E+02  0.711536E+02  0.712210E+02  0.712935E+02
  #0.718104E+02  0.736710E+02  0.738362E+02  0.739253E+02  0.739253E+02
  #0.767595E+02  0.769821E+02  0.770944E+02  0.778886E+02  0.779477E+02
  #0.779748E+02  0.780480E+02  0.780956E+02  0.780956E+02  0.782150E+02
  #0.788973E+02  0.789922E+02  0.789971E+02  0.790291E+02  0.790952E+02
  #0.791086E+02  0.791663E+02  0.791929E+02  0.793258E+02  0.793309E+02
  #0.793807E+02  0.800064E+02  0.801199E+02  0.801244E+02  0.801779E+02
  #0.801856E+02  0.803414E+02  0.814802E+02  0.819343E+02  0.852799E+02
  #0.854663E+02  0.861248E+02  0.862493E+02  0.863378E+02  0.863474E+02
  #0.863821E+02  0.867315E+02  0.872811E+02  0.873380E+02  0.874504E+02
  #0.875102E+02  0.875594E+02  0.877969E+02  0.881816E+02  0.891217E+02
  #0.891760E+02  0.892127E+02  0.902265E+02  0.903133E+02
 #IPRINT=-3: mirror-XSECTN
    #1    0    0    1 /12
 #-0.932579E+02    7
    #0.000000
 #1.23536E+3-2.46059E+0  3.94347E-01 0.00000E+00 3.94347E-01 9.99999 9.99999  1
 #1.23570E+3-2.43599E+0  3.96978E-01 0.00000E+00 3.96978E-01 9.99999 9.99999  1
 #1.23603E+3-2.41138E+0  3.99170E-01 0.00000E+00 3.99170E-01 9.99999 9.99999  1
 #1.23636E+3-2.38677E+0  4.01017E-01 0.00000E+00 4.01017E-01 9.99999 9.99999  1
 #1.23670E+3-2.36217E+0  4.02587E-01 0.00000E+00 4.02587E-01 9.99999 9.99999  1
 #1.26850E+3-2.46059E-2  4.04527E-01 0.00000E+00 4.04527E-01 9.99999 9.99999  1
 #1.26884E+3 0.00000E+0  4.04398E-01 0.00000E+00 4.04398E-01 9.99999 9.99999  1
    #26    9   99 LS-states      IPRINT,IBUT = -3  0     20161219 014418.998
  #0.000000E+00  0.970230E+01  0.571243E+02  0.572239E+02  0.583350E+02
  #0.591195E+02  0.594258E+02  0.596219E+02  0.596449E+02  0.597874E+02
  #0.597874E+02  0.599167E+02  0.603357E+02  0.606260E+02  0.612987E+02
  #0.616305E+02  0.624950E+02  0.626988E+02  0.627470E+02  0.630026E+02
  #0.633085E+02  0.633310E+02  0.633969E+02  0.636831E+02  0.639190E+02
  #0.642474E+02  0.642531E+02  0.653703E+02  0.653886E+02  0.659729E+02
  #0.673893E+02  0.680906E+02  0.682955E+02  0.683678E+02  0.684983E+02
  #0.692508E+02  0.704924E+02  0.706600E+02  0.708574E+02  0.708574E+02
  #0.709908E+02  0.710023E+02  0.711536E+02  0.712210E+02  0.712935E+02
  #0.718104E+02  0.736710E+02  0.738362E+02  0.739253E+02  0.739253E+02
  #0.767595E+02  0.769821E+02  0.770944E+02  0.778886E+02  0.779477E+02
  #0.779748E+02  0.780480E+02  0.780956E+02  0.780956E+02  0.782150E+02
  #0.788973E+02  0.789922E+02  0.789971E+02  0.790291E+02  0.790952E+02
  #0.791086E+02  0.791663E+02  0.791929E+02  0.793258E+02  0.793309E+02
  #0.793807E+02  0.800064E+02  0.801199E+02  0.801244E+02  0.801779E+02
  #0.801856E+02  0.803414E+02  0.814802E+02  0.819343E+02  0.852799E+02
  #0.854663E+02  0.861248E+02  0.862493E+02  0.863378E+02  0.863474E+02
  #0.863821E+02  0.867315E+02  0.872811E+02  0.873380E+02  0.874504E+02
  #0.875102E+02  0.875594E+02  0.877969E+02  0.881816E+02  0.891217E+02
  #0.891760E+02  0.892127E+02  0.902265E+02  0.903133E+02
 #IPRINT=-3: mirror-XSECTN
    #1    0    0    1 /12
 #-0.932579E+02    7
    #0.000000
 #1.23536E+3-2.46059E+0  3.94347E-01 0.00000E+00 3.94347E-01 9.99999 9.99999  1
 #1.23570E+3-2.43599E+0  3.96978E-01 0.00000E+00 3.96978E-01 9.99999 9.99999  1
 #1.23603E+3-2.41138E+0  3.99170E-01 0.00000E+00 3.99170E-01 9.99999 9.99999  1
 #1.23636E+3-2.38677E+0  4.01017E-01 0.00000E+00 4.01017E-01 9.99999 9.99999  1
 #1.23670E+3-2.36217E+0  4.02587E-01 0.00000E+00 4.02587E-01 9.99999 9.99999  1
 #1.26850E+3-2.46059E-2  4.04527E-01 0.00000E+00 4.04527E-01 9.99999 9.99999  1
 #1.26884E+3 0.00000E+0  4.04398E-01 0.00000E+00 4.04398E-01 9.99999 9.99999  1
    #26    9   99 LS-states      IPRINT,IBUT = -3  0     20161219 014418.998
  #0.000000E+00  0.970230E+01  0.571243E+02  0.572239E+02  0.583350E+02
  #0.591195E+02  0.594258E+02  0.596219E+02  0.596449E+02  0.597874E+02
  #0.597874E+02  0.599167E+02  0.603357E+02  0.606260E+02  0.612987E+02
  #0.616305E+02  0.624950E+02  0.626988E+02  0.627470E+02  0.630026E+02
  #0.633085E+02  0.633310E+02  0.633969E+02  0.636831E+02  0.639190E+02
  #0.642474E+02  0.642531E+02  0.653703E+02  0.653886E+02  0.659729E+02
  #0.673893E+02  0.680906E+02  0.682955E+02  0.683678E+02  0.684983E+02
  #0.692508E+02  0.704924E+02  0.706600E+02  0.708574E+02  0.708574E+02
  #0.709908E+02  0.710023E+02  0.711536E+02  0.712210E+02  0.712935E+02
  #0.718104E+02  0.736710E+02  0.738362E+02  0.739253E+02  0.739253E+02
  #0.767595E+02  0.769821E+02  0.770944E+02  0.778886E+02  0.779477E+02
  #0.779748E+02  0.780480E+02  0.780956E+02  0.780956E+02  0.782150E+02
  #0.788973E+02  0.789922E+02  0.789971E+02  0.790291E+02  0.790952E+02
  #0.791086E+02  0.791663E+02  0.791929E+02  0.793258E+02  0.793309E+02
  #0.793807E+02  0.800064E+02  0.801199E+02  0.801244E+02  0.801779E+02
  #0.801856E+02  0.803414E+02  0.814802E+02  0.819343E+02  0.852799E+02
  #0.854663E+02  0.861248E+02  0.862493E+02  0.863378E+02  0.863474E+02
  #0.863821E+02  0.867315E+02  0.872811E+02  0.873380E+02  0.874504E+02
  #0.875102E+02  0.875594E+02  0.877969E+02  0.881816E+02  0.891217E+02
  #0.891760E+02  0.892127E+02  0.902265E+02  0.903133E+02
 #IPRINT=-3: mirror-XSECTN
    #1    0    0    1 /12
 #-0.932579E+02    7
    #0.000000
 #1.23536E+3-2.46059E+0  3.94347E-01 0.00000E+00 3.94347E-01 9.99999 9.99999  1
 #1.23570E+3-2.43599E+0  3.96978E-01 0.00000E+00 3.96978E-01 9.99999 9.99999  1
 #1.23603E+3-2.41138E+0  3.99170E-01 0.00000E+00 3.99170E-01 9.99999 9.99999  1
 #1.23636E+3-2.38677E+0  4.01017E-01 0.00000E+00 4.01017E-01 9.99999 9.99999  1
 #1.23670E+3-2.36217E+0  4.02587E-01 0.00000E+00 4.02587E-01 9.99999 9.99999  1
 #1.26850E+3-2.46059E-2  4.04527E-01 0.00000E+00 4.04527E-01 9.99999 9.99999  1
 #1.26884E+3 0.00000E+0  4.04398E-01 0.00000E+00 4.04398E-01 9.99999 9.99999  1
#eof

#line=1
#for i in $(seq 3)
#do  
#data=( $(sed -n ${line}p a54) )
#printf "%5s%5s%5s\n" ${data[0]} ${data[1]} ${data[2]}
#for j in $(seq $((++line)) $((line+19)))
#do
#sed -n ${j}p a54 
#done
#line=$((line+22))
#data=( $(sed -n ${line}p a54) )
#printf "%5s%5s%5s%5s\n" ${data[0]} ${data[1]} ${data[2]} ${data[3]}
##sed -n $((++line))p a54
#((line++))
#data=( $(sed -n ${line}p a54) )
#printf "%14s%5s\n" ${data[0]} ${data[1]}
#num_xse=${data[1]}
#sed -n $((++line))p a54
#to=$((line+num_xse-1))
#from=$((++line))
#for line in $(seq ${from} ${to})
#do
#data=( $(sed -n ${line}p a54) )
#data[0]=${data[0]:0:10}
#data=( ${data[*]//E+/*10^} )
#data=( ${data[*]//E-/*10^-}  )
#printf "%17.9E" $(echo "${data[0]}/13.60569"|bc -l ) 
##printf "%17.9E" $( echo "${data[1]}"|bc -l ) 
#printf "%17.9E" 0
#printf "%13.3E" $( echo "${data[1]}"|bc -l ) 
#printf "%11.3E\n" $( echo "${data[3]}"|bc -l ) 
#done
#((line++))

#data=( $(sed -n ${line}p a54) )
#data=( ${data[*]//E+/*10^} )
#data=( ${data[*]//E-/*10^-}  )
#printf "%17.9E" $(echo "${data[0]}/13.60569"|bc -l ) 
#printf "%17.9E" $( echo "${data[1]}"|bc -l ) 
##printf "%17.9E" 0
#printf "%13.3E" $( echo "${data[2]}"|bc -l ) 
#printf "%11.3E\n" $( echo "${data[4]}"|bc -l ) 
#echo $line 
#((line++))
#done 

#rm a54


##=============53============
#awk '{print $2 $3}' << eof
#1 
#2 
#30 31 32 33 34
#4
#eof


##=============52==============
#sed -n "/^$/=" <<eof
#12 34
#sdf s
#23f

#s
#eof


##========51=============
##This program is to test the wc (word count), which prints out the 
##newline, word, and bytes counts of a file. 
#cat <<eof > a51
#1 2 3
#a b

#1
#eof

#wc a51
#wc -m a51   #BYTES
#wc -l a51   #LINE NUMBER    sed -n "$ =" a51
#sed -n "$ =" a51
#wc -w a51   #Word counts.
#echo 

#awk '{print $1}' a51

#echo end
#rm -f a51

##===========50==================
#printf "%-3.1dsdf\n" 32 #The integer behind . specifies the minimum 
                        ##number of characters to be printed.
#printf "%8.3f %-3ss\n" 2.34 hi  #The integer behind . specifies
                                ##the precision.
#printf "%6.2s\n" hihi      #Here the integer behind . specifies the 
                      ##maximum number of characters to be printed.
        
        
#printf "%3.2ddu\n" 2 #here u means unsigned decimial number.
#printf "%9.2e\n" 2
#printf "%%\"'\`'\n"
#printf "%6.5s xd\n" 123456789
#a=4
#b=2
#printf "%*.*f\n" $a $b 2.345

#printf "%.0f %.0f\n" 9.5  72.5 #The rounding schemes of the floating
                               ##numbers are different or random for .5.
#printf "hi\vhi\vhi\n" 
#printf "hi \a hi \a \n"

#printf "%b" 'hi\vhi\n'

#printf "%5.2f x \n" 1 2 3 

#printf "a\vb\tc"


##================49================
#a=32.5

#echo ${a:2:2}

#if [ ${a:2:2} = .5 -a 3 = 2 -o 3 = 3.0 ]
#then
    #echo no
#fi



##=============48==================
#a=2

#case $a in
    #1)
    #echo 1
    #;;
    #2)
    #echo 2
    #;;
    #3)
    #echo 3
    #;;
    #*)
    #echo NO_MATCH
    #;;
#esac
    


##================47===============
#if [ ! 2 -eq 1 ]
#then
    #echo unequal
#else
    #echo equal
#fi


##==============46=============
#cat << eof > a46
#2.0 1.0 4.0 5.0
#eof

#while read -a a
#do
#echo ${a[*]}

#numele=${#a[*]}
#echo $numele

#if [ $numele -eq 4 ]
#then
    #indmin=0
    
    #for i in $(seq 1 3)
    #do
        #com1=$(echo " ${a[$indmin]} > ${a[$i]} " | bc)
        #if [ $com1 -eq 1 ]
        #then
            #indmin=$i
        #fi
    #done
#fi
#unset a[$indmin]
#echo $indmin ${a[1]} #$((a[1]+a[2]+a[3]+a[0]))
##a[$indmin]=${a[$indmin]}X

##printf "%-3s%-3s%-3s%-3sTYPEHERE\n" ${a[*]}
#echo "${a[0]}+${a[1]}+${a[2]}+${a[3]}"|bc

#done < a46

##===========45===============
#a=4.0
#b=3.0

#c=$(echo "$a < $b" |bc)
#echo $c

#if [ $c -eq 1 ] #Here you can not use < to represent -lt.
#then
    #echo less
#fi


##==============44============
##a=( [1]=2 [3]=3 )

##printf "%1s%3s%1s\n" ${a[1]} ${a[2]} ${a[3]}

#c=3
#printf "%-2s%-3s%-3s%-2s\n" $c $a $a $c
#printf "%2s\n" hihihi #If the specifier is less than the actual length,
                      ##then it will go ahead to print all of it.

##===========43===========
#a=2
#if [ 2 -lt 3 -a 2 -gt $((a-1)) ]
#then
    #echo between
#fi



##==========42========
#cat << eof > a42
#1 2 
#2 3f
#eof
##declare -a line 
#while read -a line 
#do
#echo ${line[*]}

#done < a42

#read -p "prompt: " -a b
#echo ${b[*]}

##==============41=======
#cat <<eof >a40



    #1 2
    #3 4
    #5 6
    #7 8



#eof
##vi a40





##=========40==========
#cat << eof > a40
#Hi
#Muzi Li!

#Good morning!

#I hope you will receive my present today!

#Have a nice day!

#0200003003 
#eof

##sed /^$/d a40
##sed "s/^/*/g" a40 | sed "s/$/#/g"
##sed "s/^/: /" a40
##sed s/^$/E/ a40
##sed "/ $/d" a40
##sed "s/ $/./" a40
##sed "s/i/I/g" a40
##sed "s/!/ &&&/g" a40 #Here & represents !.
##sed "s/003$/*/" a40 #Wildcards do not work in sed substitution or
                     ##in sed printing or deleting. Pattern matching.
##sed "s/4*/*/g" a40 #So weird of *.
##sed "s/0/O/6" a40   #We can specify which matched pattern to be 
                    ##substituted by changing /g to /6 for example.

##+++++++++++++++INSERT (i) & APPEND (a)+++++++++++++++++++++
##sed "s/^   */\/1" a40  #Weird again that I could not figure it out.
##sed '1i\
##        sd' a40    ##In Linux system, just put the command in one line 
                    ###and the inserted or appended line will be in a new
                    ###line. But it's a bit weird that in Mac it has to 
                    ###broken into two lines, and the output is not as 
                    ###good as in Linux system.
##sed '/ /i\
##        end' a40
##sed '2a\
##        end' a40
##sed '/Li/a\
##           LiEND' a40
##sed '$a\
##        $END' a40 
##sed '$i\
##$END' a40

##++++++++++++++REPLACE (c-cover)+++++++++++++
##sed '3c\
##        Seth\' a40
##sed '2,$c\
##          seth' a40    #1 to 3 lines are covered by seth.
                        ##Also everything behind \ will be written.
##sed '=' a40                        





##=========39===========
#cat << eof > a39
#Hello, 
#My Love, 
#Muzi Li!

#Please let's reunite!

#I deserve another chance!

#I love you!

#!  1

#2 

#3 
#eof

##sed  /o/p a39 | sed /!$/d #Each line of input is echoed.
##sed -n /o/p a39 #That each line of input is echoed is depressed.
                 ##By default it is not depressed.
##sed -n 2,4p a39
##sed -n /^$/,/^$/p a39
##sed -n 1,/!$/p a39
##sed -n /i!$/,/u!$/p a39
##sed -n 2p a39
##sed -n /^M/p a39
##sed -n /!$/p a39
##sed -n /o/p a39
##sed -n "/ /p" a39



##==========38==============
#cat << eof >a38
#Hi,
#Muzi Li.

#Can you forgive my silliness?
#Please!

#I'm in love with you now!
#eof

#cat a38
#echo ++++++++++
##sed '/^$/d' a38 #Just like in VI, ^ and $ represent the beginning and
                 ##the end of a line. So ^$ mean nothing in a line, i.e
                 ##empty.
##sed /^$/d a38   #It also works without the quote.
##sed "/^$/d" a38
##sed /o/d a38

##When multiple commands are needed we can pipe the output of the 
##previous command to the input of the next command using '|'
##sed -e '/^$/d' a38 |sed /o/d | sed /i/d |sed /!/d
##sed /^M/d a38  | sed /?$/d | sed /^$/d 
##sed 1d a38 | sed 3d | sed /e!$/d 
##sed 1,3d a38 | sed /^$/,4d
##sed /^$/,/^$/d a38
##sed "/ you /d" a38
##sub='you'
##sed "/${sub}/d" a38



##==========37============
#a=( $(cat $0) )
##b=' '
#for i in $(seq $(( ${#a[*]} -1)) -2 0 )
#do
    #b=${b}${a[$i]}
#done

#echo $b ${#b[*]}



##========36==========
#a=( [2]=2 [3]=3 [4]=4 )
#b=( ${a[*]} )
##b=( "${a[*]}" )

#echo ${#b[*]}
##echo ${b[1]}



##========35==========
##Remember if you want to use array, be sure to use ${}
#a=(1 2 3 4)
#echo ${#a[*]}

#b=${a[*]}
#echo ${#b[*]}


##============34===========
##This script is to test the remove operation in strings.
##Remove the substring from the front of the string, # (short match)
##and ##(long match); from the end of the string, % (short match)
##and %% (long match).
#a=(ssddff ssddff)
#echo ${a[*]}

#echo ${a[*]#s*d}
#echo ${a[*]##s*d}

#echo ${a[*]%d*f}
#echo ${a[*]%%d*f}





##==========33===========
##This script is to test the effect of double quotes in
##b=( "${a[*]}", and it turns out the empty element is deleted
##in the new array.
#a=( "hel hel my" " " "my")
#echo ${#a[1]}

#b=( "${a[*]}" )
#echo ${b[*]}


##=========32==========
##This program is to test ?
#a=(2newmend2 3nwnend3 4newsend4)

#echo ${a[*]}
#echo ${a[*]/#?new/*}
#echo ${a[*]/%end*/}

#echo ${a[*]#?new} #This is short of ${a[*]/#?new/}
#echo ${a[*]%end?} #This is short of ${a[*]/%end?/}



##=======31==========
##This program is to test the wildcards used in substitution of 
##substrings.
#a=( {a..f} "my love" "ssmmdd" )
#echo ${a[*]}

#echo ${a[*]/*//}
#echo ${a[*]/ss*/begin}
#echo ${a[*]/' '/S}
#echo ${a[*]/my???/}

##==========30=============
##This program is to test the  substitution of a substring 
##at the beginning or end of each element. We can also use this
##to delete some parts in the element. Anyways, it's basically
##string operation.
#a=( ssddmm ssddmm )
#echo ${a[*]}

#echo ${a[*]/d/*}
#echo ${a[*]/d/}
#echo ${a[*]/#s/}
#echo ${a[*]/%m/*}


##==========29================
##This program is to test the substitution of elements of an array.
##Basically it is string operation. ${a[*]/e/m} for the first e occurance
##in each element, while ${a[2]//e/m} for all e occurances in each 
##element.
#a=( [2]="helloo my love!" 3 3)

#echo ${a[3]}

#echo ${a[*]:3:1}
#echo ${a[*]/h/H}
#echo ${a[*]//o/O}

#b=${a[*]:3:2}
#c=( ${b[*]//3/three} )
#echo ${#c[*]}
#echo ${c[*]//e/3}

#d=(${a[*]})
#echo ${#d[*]}
#echo ${d[*]/o/O}


##=============28=============
##This program is to test extracting elements from an array.
##newarray=( ${a[*]:2:2} ) which creates a new array of elements a[2] 
##a[3].
#a=( {a..f} )
#echo ${a[*]}

#echo ${a[*]:2} #Here 2 is the index number
#echo ${a[*]:2:1} #Here 2 is the index number, 1 the number of elements
                 ##following element of index 2 including itself.

##=========27================
##To include the quotes? Use double quotes to contain them along with \.
##To extend an array, put the old array ${a[*]} into the new array 
##definition. If the old array has empty element, then it will be deleted
##in the extended array. If the old array has elements that have 
##whitespace, then in the extended one it will be treated as a space
##which will break the old element into two new elements.
#a2=( '' "\"hell lleh\"" 'he my')
#echo ${a2[0]}

#a3=( ${a2[*]} )
#echo ${a3[0]}


##=============26============
#a=12

#case $a in
    #1) 
    #echo 1
    #;;
    #*) 
    #echo S
    #;;
#esac



##==========25=============
##declare -a color

#read -a color
#echo ${#color[*]}
#for i in $(seq 0 $((${#color[*]}-1)))
#do
    #echo -n "${color[$i]}  "
#done

##================24==============
##The difference between a23 and a24 is that in a23, the element of the
##array is one line, while in a24 the element is one piece that is 
##seperated by space.
#cat << eof > a24
#My Love,
#Muzi Li.
#Can you feel my heart?
#eof

#cont=( $(cat a24) )

#for i in $( seq 0 $((${#cont[*]}-1)) )
#do
    #echo -n "${cont[$i]}    "
#done


#printf "${cont[*]}"

##====================23==============
#cat <<eof > a23
#Hello, my
#Muzi Li! 
#Can you forgive me? 
#I would love you through all my heart. 



#end
#eof

#i=1
#while read line
#do
    #line[$i]=$line 
    #((i++))
#done <a23
#((i--))

#tput bold

#for j in $(seq 1 ${i})
#do
    #echo ${line[${j}]}
    ##printf  "   %s\n" "${line[$i]}"
#done 

#echo !


##===================22=================
##This program is to 
#i=1

#while read line
#do
        #a[$i]=$line
        #echo a[$i]=$line
        #((i++))
#done < a.txt
#((i--))
#for j in $(seq 1 $i )
#do
        #jj=$((j+1))
        #if [ $jj -lt $i ]
        #then
                #for m in $(seq $jj $i)
                #do
                        #if [ ${a[$j]} = ${a[$m]} ]
                        #then
                                #echo a[$j]=a[$m]
                        #fi
                #done
        #fi

#done


##=======================21=================
##This script includes function, while loop, case structure,
##read from prompt and here document. Very solid programming.
#valid='F'

#cont()
#{       
        #read -p "Do you want to quit? F/T: " valid
#}


#while [ $valid = 'F' -o $valid = 'f' ]
        #do

        #cat << eof
        #1. Show disk usage.
        #2. Show system uptime.
        #3. Show the users logged into the system.
        #q. Quit the system.
#eof

        #read -p "Enter the number in front of the task you want to perform: " index

        #case $index in
                #1)
                        #echo The task you want to do is: 1. Show disk usage.
                        #df
                        #echo
                        #cont
                #;;
                #2)
                        #echo The task you want to do is: 2. Show system uptime.
                        #uptime
                        #echo
                        #cont
                #;;
                #3)
                        #echo The task you want to do is: 3. Show the users logged into the system.
                        #who
                        #echo
                        #cont
                #;;
                #q)
                        #echo The task you want to do is: q. Quit the system.
                        #valid='T'
                        #echo Goodbye!
                        #echo
                #;;
                #*)
                        #echo The option you entered is not valid! Please reenter!
                        #valid='F'
                #;;
        #esac
#done


##====================20========================
#a=2
#b=1
#while [ $a -eq 2 -o $b -eq 2 ]
#do
    #echo a=$a b=$b
    #((b++))
    #((a--))
    

#done


##===================19==========================
#read -p "Which lines do you want to display? " num
#echo $num
#line_num=1
#while read line
#do
        #for i in $num
        #do
                #if [ $i -eq $line_num ]
                #then
                        #echo ${i}\ \ \ $line
                #fi
        #done
        #((line_num++))
#done < /etc/passwd

##============18=================
#for i in 1 2 3
#do 
    #if [ $i -eq 2 ]
    #then
        #break
    #fi
    
    #echo $i

#done
#echo $i


##============17====================
##Compared with the for loop, which does not check the condition,
##while loop checks the condition.
#i=2
#while [ $i -lt 7 ]
#do
    #echo $i
    #((i++))
    
#done

#echo Out $i

##=============16==================
##For loop does not check the limit, but just do it as listed.
#for i in $(seq 1 2 3)
#do 

    ##if [ $i -eq 2 ]
    ##then 
        ##continue
    ##fi
    #echo $i

#done

#echo $i

##================15=================
#cat << eof >a.txt
#Hello
#,
#Muzi Li!
#Can 
#you 
#give 
#me
#another
#chance
#to 
#love
#you
#?
#eof
#i=0
#line_num=0
#while read line
#do
    #((i++))
    #((line_num++))
    #if [ $i -eq 3 ]
    #then 
        #exit
    #fi
    
    #echo $line_num $line 
    ##((line_num++))
    
##continue: neglect the rest of the commands, but restart the next new
##iteration. exit: break from the whole script. break: break from the 
##loop.
#done < a.txt >b

#echo catb
#cat b



##==============14===================
##while loop can be executing when some command works.
#touch 1.jpg 2.jpg 3.jpg
#i=1
#while ls *jpg
#do
    #echo $i
    #rm ${i}.jpg
    #((i++))
#done


##==================13================
#tf=F

#while [ ${tf} = 'F' ]
#do 
    #read -p "Please enter your name: " name
    #echo $name
    #read -p "Is the entered name correct? " tf

#done




##====================12=============
#i=0

#while [ $i -lt 6 ]
#do 
    #echo $i
    #((i++))
#done


##==================11==============
##This program is to test the return codes of a function.
##It turns out
#function test_return()
#{
    #la
    
    #return 3
    
    #pwd
#}
#test_return

#echo $?

#if [ $? -eq 0 ]
#then
    #echo "The last command in test_return function 
        #executed successfully!"
#else
    #echo "The last command in test_return function 
        #did not execute successfully!"
#fi

#exit 2

#echo $?



##==================10===============
#a=2
#echo $a
#unset a    #unset: remove the variable from memory.
#echo $a

#b=3
#echo $b

#echo $b



##===================9===============
##This verifies that $0 represents the script not the function.
#position()
#{
    #echo $0
#}

#position


##==================8================
##To use the paramters in the function, you have to call
##the function before using the variables. Also all the variables
##are globle by default, but we can make some as local by using the 
##keyword "local" in front of it when declaring.
#parameter()
#{
        #a=2
     #local   b='hello'
#}

#parameter

#echo $a $b

##===================7=================
#function hello()
#{
    #for i in $@
    #do
        #echo "Hello $i!"
    #done
    ##name='me'
    ##echo "Hello $name?/!"
    #print_time
#}
#print_time(){
    #echo $(date +%F)
#}

#hello Seth Zhao Muzi

##========================6====================
#if [ 2 -eq 3 ]; then
    #echo equal
#elif [ 2 -lt 3 ]; then
    #echo less
##The number of ifs is the same as that of fis, but elif is not counted
##as an if.
#fi


##=======================5===================
#a=2
#cat <<- eof >> out2
    #hello
    #my love
    #!
    #$a
    #\$a

    #he
#end
#eof

#cat out2

##======================4====================
#ls * || cd
#a1=$(pwd)
#echo $a1 1

#ls x || cd
#a2=$(pwd)
#echo $a2 2

#ls * && cd 
#a3=$(pwd)
#echo $a3 3

#ls x || cd $a1
#a4=$(pwd)
#echo $a4 4

#if [ ${a4} = ${a1} ]
#then
    #echo "Return to the original directory."
#fi


##=====================3====================
#if [ 27 -lt 3 ]
#then
    #echo "less"
#fi


##====================2=====================
#a="2 3 c 5" #where the index is 0, 1, 2 ,3
#a=(2 3 c 5) #Different output for different input format.

#echo ${a[2]}  #the element with index of 2, no matter it's a number or char. 

#i=0

#while [ $i -le 3 ]; do
    #echo ${a[$i]}
##    (( i=i+1 ))
    #let i=i+1
## Both let and (()) work for arithmatic expression.
#done


##===================1=====================
##Okay, to make shell scripting working in Geany, first set permission u+x.
##Second, include the compiler (?): /bin/bash or other shell.
#ls
#cat udemy_shell_scripting.sh
