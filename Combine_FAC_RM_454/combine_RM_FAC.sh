#! /bin/bash

if [ -f RM_FAC_TOPUP_FINAL ]
then
	rm RM_FAC_TOPUP_FINAL
fi

for i in $(seq 1 454)
do
	cat RM_FAC_add/${i} >> RM_FAC_TOPUP_FINAL
done
