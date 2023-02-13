#!/bin/bash

pacman_packages=()
missing_packages=()

for package in $(cut -d' ' -f1 ../pacman.installed); do
    if pacman -Si "${package}" > /dev/null 2>&1; then
        pacman_packages+=("${package}")
    else
        missing_packages+=("${package}")
    fi
done

pacman -Sy ${pacman_packages[@]}

echo MISSING PACKAGES:
for p in ${missing_packages[@]}; do
    echo ${p}
done
