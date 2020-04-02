#! /bin/bash
# Zadanie 12
#Dany jest katalog D (pierwszy parametr skryptu). 
#Należy wypisać dwie liczby: 
#liczbę wszystkich plików regularnych w D oraz :  ls -l | grep '^-..x'
#liczbę wszystkich bezpośrednich podkatalogów w D.  ls -l | grep '^d..x'
#W obu przypadkach należy wziąć pod uwagę jedynie te pliki, 
#do których my (nasz skrypt) mamy prawo wykonania.

if [ $# -eq 0 ]
then
  echo "Brak parametrów"
  exit 1
fi

var1=0
for item in `ls -lA | grep '^-..x'`
do
    var1=$[var1+1]
done

var1=$[var1/9]
echo $var1

var2=0
for item in `ls -lA | grep '^d..x'`
do
    var2=$[var2+1]
done

var2=$[var2/9]
echo $var2


