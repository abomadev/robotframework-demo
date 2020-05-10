import sys
from fuzzywuzzy import fuzz

ratio = fuzz.ratio(sys.argv[1],sys.argv[2])
print(ratio)