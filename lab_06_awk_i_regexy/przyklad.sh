#! /bin/bash

if [ $# -ne 1 ]
then
    	echo "Nie podano argumentu"
        exit 1
fi

# if [ ! -d $2 ]
# then
#     	echo "Argument pierwszy nie jest katalogiem"
#         exit 1
# fi

if [ ! -f $1 ]
then
    	echo "Argument drugi nie jest plikiem"
        exit 1
fi

FILENAME=$1


awk 'BEGIN { print "NUMBER NAME    RATE   HOURS"; print " " }'
# awk 'BEGIN { print }'
awk '$1 ~ /[BKM].+/ { printf("  %-4s %-7s %4.2f   %-5s\n", NR, $1, $2, $3) } ' $FILENAME | sort
# awk '$3 > 0 { print NF, $1, $NF }' file1.txt