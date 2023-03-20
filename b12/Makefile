libpath := $(shell winsdk.exe --type:lib --arch:x64 --kit:um)

cflags += -Ofast
cflags += -std=c11
cflags += -Wall
cflags += -Wextra
cflags += -Wno-gnu-empty-initializer
cflags += -pedantic
cflags += -nostdlib
cflags += -ffreestanding
cflags += -fno-stack-check
cflags += -fno-stack-protector
cflags += -mno-stack-arg-probe
cflags += -lkernel32
cflags += -Xlinker /align:16
cflags += -Xlinker /entry:start
cflags += -Xlinker /nodefaultlib
cflags += -Xlinker /subsystem:console
cflags += -Xlinker /libpath:"$(libpath)"

run: vitamin_b12.exe
	$<

vitamin_b12.exe: vitamin_b12.c words.h
	@-mkdir bin
	clang $< $(cflags) -o $@

words.h: words.py words.txt
	python $<
