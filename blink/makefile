


TC  =C:/users/bob/AppData/Local/Arduino15/packages/arduino/tools/arm-none-eabi-gcc/4.8.3-2014q1/bin
PROG=C:/users/bob/AppData/Local/Arduino15/packages/arduino/tools/bossac/bossac-1.7.0

CC=$(TC)/arm-none-eabi-gcc

CFLAGS=-mcpu=cortex-m3 -mthumb --specs=nosys.specs -nostdlib -g -Os

all : blink.bin

main.o: main.c
	@echo Compiling $<
	@$(CC) -c main.c -o main.o $(CFLAGS)

startup.o: startup.c
	@echo Compiling $<
	@$(CC) -c startup.c -o startup.o $(CFLAGS)

blink.elf : main.o startup.o flash.ld
	@echo Linking $@
	@$(CC) startup.o main.o -o blink.elf -mcpu=cortex-m3 -mthumb --specs=nosys.specs -nostdlib "-Tflash.ld" "-Wl,-Map,blink.map" -nostartfiles

blink.bin : blink.elf
	@echo Creating bin file $@
	@$(TC)/arm-none-eabi-objcopy  -O binary  blink.elf blink.bin

clean:
	rm -f main.o startup.o blink.bin blink.elf

prog:

	echo Programming code...
	$(PROG)/bossac --port=COM68 -U true -i -u -e -w -b "blink.bin" -v -R
