#! /usr/local/bin/bash

if [ -f l_outer_shell_extra_p_file ]
then
	rm l_outer_shell_extra_p_file
fi

for ((i = 3; i <= 168; i ++))
{
	cat header out/${i} >> l_outer_shell_extra_p_file
}
