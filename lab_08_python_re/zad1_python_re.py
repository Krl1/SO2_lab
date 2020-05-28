#!/usr/bin/env python3

#Dane jest drzewo katalogowe D i dwa pliki zwykłe P1 i P2 (argumenty skryptu).
#1. W D dla każdego linku symbolicznego należy wyświetlić jego nazwę (ostatni człon) oraz liczbę znaków jaka jest w nim (linku) zapisana, zaś dla każdego pliku zwykłego należy wyświetlić jego nazwę (ostatni człon) oraz liczbę linii tego pliku zawierających napis "hello". (3 pt)
#2. Wyniki z punktu 1 należy dodatkowo zapisać do P1 po czym posortować (przed wyświetleniem) wg nazwy pliku. (2 pt)
#3. Należy wypisać na ekran zawartość pliku P2 z wszystkimi datami postaci YYYY-MM-DD zamienionymi na postać MM.DD.YY. Daty są zawsze oddzielone co najmniej jednym znakiem (ale niekoniecznie spacją). Może być więcej niż jedna data w jednej linii. (4 pt)

import sys
import os
# import shutil
# import time
import re

if sys.argv.__len__() != 4:
    print("Skrypt należy uruchomić z trzema parametremi (3 katalogi).")
    sys.exit(1)

D = sys.argv[1]
P1 = sys.argv[2]
P2 = sys.argv[3]

if not os.path.isdir(D):
    print("Katalog o ścieżce '{}' nie istnieje.".format(D))
    sys.exit(2)

if not os.path.isfile(P1):
    print("Plik'{}' nie istnieje.".format(P1))
    sys.exit(3)

if not os.path.isfile(P2):
    print("Plik '{}' nie istnieje.".format(P2))
    sys.exit(4)

f_P1 = open(P1, "w")

# 1.
print('Zad 1.')
for root, dirs, files in os.walk(D):
	for filename in files:
		file = os.path.join(root, filename)
		if os.path.islink(file):
			abs_path = os.path.abspath(file) 
			print('a)',filename, os.lstat(abs_path)[6])
			one_string = filename + " " + str(os.lstat(abs_path)[6]) + '\n'
			f_P1.write(one_string)

		elif os.path.isfile(file):
			try:
				with open(file, 'r', encoding='utf-8') as f:
					contents = f.read()
					pattern = (r'hello')
					result=len(re.findall(pattern, contents))
					print('b)',filename, result)
					one_string = filename + " " + str(result) + '\n'
					f_P1.write(one_string)
			except UnicodeDecodeError:
				continue
			except PermissionError:
				continue

# 2.
print('\nZad 2.')
f_P1.close()

lines = []

f_P1=open(P1, 'r')
for line in f_P1:
	lines.append(line)
f_P1.close()

lines.sort()

f_P1 = open(P1, "w")
for line in lines:
	f_P1.write(line)
f_P1.close()

with open(P1, 'r', encoding='utf-8') as f:
	contents = f.read()
	print(contents)


# 3.
print('\nZad 3.')
f_P2 = open(P2, "r")
for i, line in enumerate(f_P2):
	if line[-1] != '\n':
		line += '\n'

	pattern=re.compile(r'([0-9]{2})([0-9]{2})-([0-9]{2})-([0-9]{2})(.|\n)')
	matches = pattern.finditer(line)
	new_line=''
	start_line=0

	for match in matches:
		YY=match[2]
		MM=match[3]
		DD=match[4]
		new_date = str(MM)+'.'+str(DD)+'.'+str(YY)
		start_index=match.start()
		end_index=match.end()
		new_line+=line[start_line:start_index] + new_date
		start_line=end_index-1

	new_line+=line[start_line:]
	print(new_line, end='')


f_P2.close()