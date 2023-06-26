#!/usr/bin/env bash

# xfce4-genmon script to monitor current memory usage
# 2020 (ɔ) almaceleste

ICON=$(echo -e '\uf85a')

# mem usage threshold warning (in GB) - yellow
warn=4
# mem usage threshold alarm (in GB) - red
alarm=7

used=$(free --giga | grep Mem | awk '{printf "%d", $3}')
free=$(free --human --giga | grep Mem | awk '{printf "%s", $4}')
shared=$(free --human --giga | grep Mem | awk '{printf "%s", $5}')
avail=$(free --human --giga | grep Mem | awk '{printf "%s", $7}')

color='#fbf1c7'
if [ $used -gt $alarm ]
then
    color='#fb4934'
elif [ $used -gt $warn ]
then
    color='#fabd2f'
fi
used="${used}GB"

echo -e "<txt><span foreground="\'$color\'"> ${ICON}  $used </span></txt>"
echo -e "<tool>mem: \t$used used\n\t\t$free free\n\t\t$shared shared\n\t\t$avail avail</tool>"
