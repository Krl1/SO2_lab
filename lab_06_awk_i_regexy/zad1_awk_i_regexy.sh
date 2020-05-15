#! /bin/bash

# Ogólnie skrypt poza standardowym sprawdzeniem argumentów skryptu powinien zawierać tylko jedno wywołanie komendy awk 
# (ewentualnie dwuczłonowy potok cat | awk). W nawiasach punkty za poszczególne części zadania. 
# Do zaliczenia ćwiczenia należy uzyskać przynajmniej połowę punktów. Czas na przesyłanie odpowiedzi standardowo do 14:00 dzisiaj.

# Dany jest plik zwykły P (argument skryptu). Należy wypisać ten plik na ekran z następującymi zmianami 
# (tylko wypisać, bez zmiany oryginalnego pliku):
# 1. Ponumerować linie pliku (puste też). (1)
# 2. Nie wypisywać treści komentarzy jednolinijkowych C/C++ (pomijać treść od dwuznaku // do końca linii). (2)
# 3. Zamienić wszystkie daty formatu DD-MM-YYYY (np. 30-04-2020) na YY/MM/DD (20/04/30). 
#    Uwaga: daty mogą występować wielokrotnie w tej samej linii! (4)
# 4. Na koniec wypisać nazwy załączonych plików C/C++ (wykrywanie linii typu #include <filename> lub #include "filename"). (3)

if [ $# -ne 1 ]
then
    	echo "Nie podano argumentu"
        exit 1
fi

if [ ! -f $1 ]
then
    	echo "Argument drugi nie jest plikiem"
        exit 1
fi

P=$1

awk '{ \
tekst1 = gensub(/\/\/.*/,"","1", $0); \
tekst2 = gensub(/([0-9]{2})-([0-9]{2})-([0-9]{2})([0-9]{2})/, "\\4/\\2/\\1", "g", tekst1); \
match(tekst2, /(#include) *(<|")(.+)("|>) */, tab); \
if(tab[2]==tab[4]) pliki[tab[3]] = tab[3]; \
if(tab[2]=="<" && tab[4]==">") pliki[tab[3]] = tab[3]; \
print NR, tekst2 } \
END { for (klucz in pliki) print pliki[klucz] }' $P
