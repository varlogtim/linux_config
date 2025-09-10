#!/usr/bin/env python
import os
import sys

battery_dir = '/sys/class/power_supply/BAT0/'
energy_now_path = battery_dir + 'energy_now'
energy_full_path = battery_dir + 'energy_full'

energy_now = int(open(energy_now_path, 'r').read())
energy_full = int(open(energy_full_path, 'r').read())

percent_full = (energy_now / energy_full) * 100
msg = 'Battery: {:.2f}%'.format(percent_full)

print(msg)
