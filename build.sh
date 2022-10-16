#! /bin/bash

set -e

ORIG="Donkey Kong (World) (Rev A).nes"
ROM="donkeykong-eo.nes"
IPS="donkeykong-eo.ips"
FLIPS="wine /opt/floating/flips.exe"

echo "Assembling ROM..."
cd src
/opt/asm6f/asm6f DonkeyKongDisassembly.asm "$ROM"
mv "$ROM" "../$ROM"
cd ..

echo "Updating CHR..."
dd if=chr/bonus.bin of="$ROM" conv=notrunc bs=1 seek=$((0x5270))
dd if=chr/oilcan.bin of="$ROM" conv=notrunc bs=1 seek=$((0x54D0))
dd if=chr/hiscore.bin of="$ROM" conv=notrunc bs=1 seek=$((0x5D10))

echo "Generating patch..."
$FLIPS -c -i "$ORIG" "$ROM" "$IPS"

echo "Done"
