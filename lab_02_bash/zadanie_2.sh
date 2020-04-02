#! /bin/bash
# Zadanie 2
#Dane są katalog D (pierwszy parametr skryptu) 
#oraz plik regularny P (drugi parametr skryptu). 
#P zawiera (być może pustą) listę (zbiór wierszy). 
#Należy w D utworzyć puste pliki regularne 
#o nazwach zgodnych z tą listą. 
#Jeżeli jakiś plik już istnieje, 
#to nie powinien zostać zniszczony.

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

for item in `cat $2`
do
  	if [ ! -f $1/$item ]
    then
        	touch $1/$item
    fi
done



