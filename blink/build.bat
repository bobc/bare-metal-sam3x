@echo off

set TC=%USERPROFILE%\AppData\Local\Arduino15\packages\arduino\tools\arm-none-eabi-gcc\4.8.3-2014q1\bin
set CC=%TC%\arm-none-eabi-gcc
set PROG=%USERPROFILE%\AppData\Local\Arduino15\packages\arduino\tools\bossac\bossac-1.7.0

set CFLAGS=-mcpu=cortex-m3 -mthumb --specs=nosys.specs -nostdlib -g -Os

echo Compiling...
%cc% -c main.c -o main.o %CFLAGS%
%cc% -c startup.c -o startup.o %CFLAGS%

echo Linking...
%cc% startup.o main.o -o blink.elf -mcpu=cortex-m3 -mthumb --specs=nosys.specs -nostdlib "-Tflash.ld" "-Wl,-Map,blink.map" -nostartfiles

echo Creating bin file...
%TC%\arm-none-eabi-objcopy  -O binary  blink.elf blink.bin


if not /%1/ == /PROG/ goto skip1

echo Programming code...
%PROG%\bossac --port=COM68 -U true -i -u -e -w -b "blink.bin" -v -R

:skip1