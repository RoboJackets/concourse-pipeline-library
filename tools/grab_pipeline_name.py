#/bin/python3

from re import fullmatch
from sys import stdin

print(fullmatch(r"pipelines/(?P<name>[a-z-]+).yml", stdin.read().strip()).group("name"))
