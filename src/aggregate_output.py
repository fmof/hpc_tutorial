#!/usr/bin/env python

import argparse
from collections import Counter
import csv
import sys

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('files', nargs='+')
    args = parser.parse_args()

    hist = Counter()
    norm = 0.0
    for in_file in args.files:
        with open(in_file, 'r') as fh:
            for line in fh:
                line = line.strip().split(' ==> ')
                if len(line) != 2:
                    continue
                try:
                    item = line[0]
                    count = int(line[1])
                    hist[item] += count
                    norm += float(count)
                except:
                    pass

    fields = ['item', 'count', 'pct']
    writer = csv.DictWriter(sys.stdout, fieldnames=fields)
    writer.writeheader()
    for item, count in hist.most_common():
        writer.writerow({'item':item,
                         'count':count,
                         'pct':float(count)/norm})
