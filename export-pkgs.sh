#!/bin/bash

pacman -Qqen > pkglist.txt
pacman -Qmq > pkglist.local.txt