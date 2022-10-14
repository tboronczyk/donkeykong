#! /bin/bash

set -e

ORIG="Donkey Kong (World) (Rev A).nes"
ROM="donkeykong-eo.nes"
IPS="donkeykong-eo.ips"
FLIPS="wine /opt/floating/flips.exe"

echo "GENERATING ROM AND IPS FROM $ORIG..."
cp "$ORIG" "$ROM"

echo "Updating CHR..."
#...

echo "Updating PRG..."
dd if=prg/gameover.bin of="$ROM" conv=notrunc bs=1 seek=$((0x06DD))

echo "Generating patch..."
$FLIPS -c -i "$ORIG" "$ROM" "$IPS"

echo "Done"
