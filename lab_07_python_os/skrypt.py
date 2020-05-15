#!/usr/bin/env python3
import sys


print(sys.argv)
print(len(sys.argv))
print(sys.argv.__len__())

for (i,arg) in enumerate(sys.argv):
	print('Argument nr {} to {}'.format(i,arg))