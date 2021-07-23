#!/bin/env python3
import sys
import datetime

date_format = '%Y-%m-%dT%H:%M:%SZ'


def check_args():
    if len(sys.argv) != 3:
        raise ValueError("Script should be called with two dates like this:\n"
                         "2021-08-31T21:31:10Z 2021-08-31T21:16:58Z\n")


def run():
    date_strs = (sys.argv[1], sys.argv[2])

    dates = [datetime.datetime.strptime(date_str, date_format)
             for date_str in date_strs]

    if dates[0] > dates[1]:
        datediff = dates[0] - dates[1]
    else:
        datediff = dates[1] - dates[0]

    print(f"{datediff}")


if __name__ == "__main__":
    check_args()
    run()
