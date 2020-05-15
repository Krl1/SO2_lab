#! /bin/bash

# Dany jest katalog D oraz plik zwykły P (dwa argumenty skryptu). 
# Należy w D usunąć wszystkie dowiązania symboliczne wiszące (zepsute) 
# a następnie zamienić wszystkie dowiązania symboliczne w D do pliku P na dowiązania twarde.

if [ $# -eq 0 ]
then
    	echo "Podano za malo parametrow"
        exit 1
fi


if [ ! -d $1 ]
then
    	echo "Nie podano katalogu"
        exit 1
fi

if [ ! -f $2 ]
then
    	echo "Nie podano pliku"
        exit 1
fi

for item in `ls -A $1`
do
    if [ -h $1/$item -a ! -e $1/$item ]
    then
        echo $1/$item 
        rm $1/$item
    fi

done

for item in `ls -A $1`
do

    if [ -h $1/$item -a $(realpath $2) == $(realpath $1/$item) ]
    then
        ln -f $(realpath $2) $1/$item

    fi

done