#!/bin/bash
# This file is a quick script to copy all files from an ELK customizations directory to this directory. I keep my personal configurations (ex. vagrant_vars.yaml, etc.)
# in that directory and upload generic versions to GitHub, so when I want to use this project, I clone it, run this shell file, then vagrant up.
cp -avr ../ELK-customizations/. ./