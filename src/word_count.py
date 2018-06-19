#!/usr/bin/env python

import argparse
import codecs
from collections import Counter
import gzip
import sys

class SmartFile:
    def __init__(self, name, compressed=False):
        self.name = name
        self.compressed = compressed
        self.fh = None

    def __enter__(self):
        if self.compressed:
            self.fh = gzip.open(self.name, 'rb')
        else:
            self.fh = open(self.name, 'r')
        self.fh = codecs.getreader('utf-8')(self.fh)
        return self.fh

    def __exit__(self, *args):
        if self.fh is not None:
            self.fh.close()
        

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('files', nargs='+', type=str)
    parser.add_argument('--compressed', action='store_true')
    parser.add_argument('--col', default=1, type=int)
    parser.add_argument('--delimiter','-d', default='\t', type=str)
    parser.add_argument('--number', '-n', default=None, type=int)
    args = parser.parse_args()

    item_hist = Counter()

    for file_name in args.files:
        sys.stderr.write("Reading %s\n" % (file_name))
        with SmartFile(file_name, compressed=args.compressed) as fh:
            for line_no, line in enumerate(fh):
                line = line.strip()
                if len(line) == 0:
                    continue
                try:
                    item = line.strip().split(args.delimiter)[args.col - 1]
                    item_hist[item] += 1
                except Exception as e:
                    sys.stderr.write("On line #%d (\n\"%s\"\n), "
                                     "got the following exception\n" % (line_no, line))
                    sys.stderr.write("%s\n" % str(e))

    for k,v in item_hist.most_common(args.number):
        sys.stdout.write("%s ==> %s\n" % (k, v))
                
    
                
