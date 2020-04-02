#! /bin/bash
# Zadanie 12
#Dany jest katalog D (pierwszy parametr skryptu). 
#Należy wypisać dwie liczby: 
#liczbę wszystkich plików regularnych w D oraz
#liczbę wszystkich bezpośrednich podkatalogów w D.
#W obu przypadkach należy wziąć pod uwagę jedynie te pliki, 
#do których my (nasz skrypt) mamy prawo wykonania.

if [ $# -eq 0 ]
then
  echo "Brak parametrów"
  exit 1
fi


if [ ! -d $1 ]
then
    	echo "Nie podano katalogu"
        exit 1
fi

var1=0
var2=0
for item in `ls -A $1`
do
  	if [ -f $1/$item -a -x $1/$item ]
        then
            	var1=$[var1+1]
    elif [ -d $1/$item -a -x $1/$item ]
        then
            	var2=$[var2+1]
        fi
done

echo $var1
echo $var2
