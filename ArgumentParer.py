import os, sys
sys.path.append(os.path.dirname(__file__))
sys.path.append(os.path.join(os.environ["ROOT_PRJ"],"scripts/lib/python"))

parser =ArgumentParser(description=f""" Parser the input for scripts Job arguments""")
parser.add_argument("-file", type=str, help="file data")
parser.add_argument("-keyword", type=str, help="")
parser.add_argument("-data", type=hex, defaults=0xabcd, help=("")) 
args, unknown_args =parser.parse_known_args()
f = args.file
k = args.keyword
d = args.data
