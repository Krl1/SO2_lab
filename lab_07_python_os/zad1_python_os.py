#!/usr/bin/env python3

# Dane są katalogi K1, K2 oraz T (argumenty skryptu). 
# K1 i K2 są rozumiane jako katalogi „jednopoziomowe” (tzn. interesują nas tylko pliki bezpośrednio w tym katalogu, a nie głębiej), 
# zaś T jest rozumiane jako całe drzewo katalogowe (dowolnej głębokości). Należy:
# 1. Utworzyć w K2 kopie plików regularnych z K1, do których my (wykonawca skryptu) mamy prawo wykonania. (3)
# 2. W K1 przekształcić wszystkie linki symboliczne do katalogów tak, aby były zdefiniowane ścieżką bezwzględną. (3)
# 3. W T należy znaleźć (wypisać nazwy) katalogi, które zostały utworzone dawniej niż 5 minut temu 
#    i które mają co najwyżej 3 (bezpośrednie) podkatalogi. (4)

import sys
import os
import shutil
import time

if sys.argv.__len__() != 4:
    print("Skrypt należy uruchomić z trzema parametremi (3 katalogi).")
    sys.exit(1)

K1 = sys.argv[1]
K2 = sys.argv[2]
T = sys.argv[3]

if not os.path.isdir(K1):
    print("Katalog o ścieżce '{}' nie istnieje.".format(K1))
    sys.exit(2)

if not os.path.isdir(K2):
    print("Katalog o ścieżce '{}' nie istnieje.".format(K2))
    sys.exit(3)

if not os.path.isdir(T):
    print("Katalog o ścieżce '{}' nie istnieje.".format(T))
    sys.exit(4)

# 1.
for filename in os.listdir(K1):
	file = os.path.join(K1, filename)
	try:
		if os.path.isfile(file) and not os.path.islink(file) and os.access(file, os.X_OK):
			shutil.copy(file, K2)
	except PermissionError:
		continue

# 2.
for filename in os.listdir(K1):
	file = os.path.join(K1, filename)
	if os.path.islink(file):
		if not os.path.isabs(os.readlink(file)):
			abs_path = os.path.abspath(os.path.join(K1,os.readlink(file)))
			if os.path.isdir(abs_path):
				os.remove(file)
				os.symlink(abs_path,file)

# 3.
first=True
for root, dirs, files in os.walk(T):
	if first:
		first = False
		continue
	count_of_dirs = len(dirs)
	for dir in dirs:
		if os.path.islink(os.path.join(root,dir)):
			count_of_dirs -= 1
	if count_of_dirs <= 3:
		time_of_most_recent_metadata_change = time.time() - os.stat(root).st_ctime #in seconds
		if time_of_most_recent_metadata_change > 5*60:
			print(root)