#! /bin/bash

# Dane jest drzewo katalogowe D oraz plik P. Należy stworzyć 2 potoki:

# Potok 1:

# – dla każdego dowiązania symbolicznego należy wypisać jego (lub ewentualnie celu) nazwę (ostatni człon) 
#   zaszyfrowaną dowolnym szyfrem cezara, (3)
# – dla każdego katalogu wypisać liczbę jego (bezpośrednich) ukrytych plików, (3)
# – dla każdego pliku, którego nazwa zaczyna się na literę n lub N wypisać jego ścieżkę
#   bezwzględną z zamianą ukośników na odwrotne. (3)
# Wyniki należy posortować, wysłać do pliku P, odwrócić kolejność linii oraz wyświetlić na ekranie ostatnie 7 wyników. (3)

# Potok 2:
# Należy wyświetlić liczbę plików zwykłych na poszczególnych poziomach drzewa.

# Uwaga ogólna: potok ma być postaci komenda find + komenda while. 
# Find ma dostarczać tyle informacji ile może (while ma robić tylko to czego find nie potrafi zrobić).

if [ $# -ne 2 ]
then
    	echo "Nie podano 2 argumentów"
        exit 1
fi

if [ ! -d $1 ]
then
    	echo "Argument pierwszy nie jest katalogiem"
        exit 1
fi

if [ ! -f $2 ]
then
    	echo "Argument drugi nie jest plikiem"
        exit 1
fi


find $1 \( \
	\( -type l -printf '1. %f\n' \) , \
	\( -type d -printf '2. %p\n' \) , \
	\( -type f -iname "n*" -printf '3. ' -exec readlink -f {} \; \) \
	\) | while read opcja dane
do
	if [ $opcja = 1. ]; then
		nowa_nazwa=$(tr a-zA-Z c-zabC-ZAB  <<< $dane)
		echo $opcja $nowa_nazwa
	elif [ $opcja = 2. ]; then
		liczba_ukrytych_plikow=0
		for ukryte_pliki in `find $dane -maxdepth 1 -type f -iname ".*"`
		do 
			liczba_ukrytych_plikow=$[liczba_ukrytych_plikow+1]
		done
		echo $opcja $dane $liczba_ukrytych_plikow
	elif [ $opcja = 3. ]; then
		nowa_sciezka=$(tr '/' '\\' <<< $dane)
		echo $opcja $nowa_sciezka 
	fi
done | sort | tee $2 | tac | tail -n 7

echo ' '
echo '----------------------------------------------------------------'
echo ' '

aktualna_glebokosc=0
liczba_plikow=0
find $1 -type d -printf '%d %p\n' | sort | ( while read glebokosc sciezka
do
	if [ $glebokosc -eq $aktualna_glebokosc ]; then
		for pliki in `find $sciezka -maxdepth 1 -type f`
		do 
			liczba_plikow=$[liczba_plikow+1]
		done
	else
		echo glebokosc: $aktualna_glebokosc liczba_plikow: $liczba_plikow
		aktualna_glebokosc=$glebokosc
		liczba_plikow=0

		for pliki in `find $sciezka -maxdepth 1 -type f`
		do 
			liczba_plikow=$[liczba_plikow+1]
		done
	fi

done
echo glebokosc: $aktualna_glebokosc liczba_plikow: $liczba_plikow )
