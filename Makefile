CC = gcc
CFLAGS = -Wall -Werror -Wstrict-prototypes

LIBS = -lbsd

DEPS = src/toml.h src/icb.h src/irc.h
OBJ = src/toml.c src/icbirc.c src/icb.c src/irc.c

GIT_COMMIT := $(shell git rev-parse --short HEAD)

.PHONY: clean install

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

icbirc: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS) -DGIT_COMMIT="\"$(GIT_COMMIT)\""

install:
	cp -v icbirc /usr/local/bin

	mkdir -p /usr/local/share/man/man8/
	cp -v man/icbirc.8 /usr/local/share/man/man8/

clean:
	rm -f icbirc *.o
