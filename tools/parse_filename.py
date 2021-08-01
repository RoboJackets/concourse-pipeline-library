#/bin/python3

from re import fullmatch
from sys import stdin, argv

print(fullmatch(r"pipelines/(?P<team>[a-z-]+)/(?P<pipeline>[a-z-]+).yml", stdin.read().strip()).group(argv[1]))
