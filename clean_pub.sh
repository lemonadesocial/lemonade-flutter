#!/usr/bin/env sh
fvm flutter clean
fvm flutter packages pub get
./build_runner.sh