PROG = haunted
NAME = HauntedHouse
OBJS = renderer.o

ARCH = mipsel-linux-
CC = $(ARCH)gcc

SDL_CFLAGS  := $(shell sdl-config --cflags)
SDL_LIBS    := $(shell sdl-config --libs)
CFLAGS = $(SDL_CFLAGS) -O2 
LDFLAGS = $(SDL_LIBS)


.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

$(PROG): $(OBJS)
	$(CC) $(LDFLAGS) $(CFLAGS) $(OBJS) -o $(PROG).dge sdl-$(PROG).c
	mv $(PROG).dge opk/
	mkdir -p dist
	rm -f dist/$(NAME).opk
	mksquashfs opk/ dist/$(NAME).opk
	rm opk/$(PROG).dge

clean:
	rm -f $(PROG) $(PROG).dge core *.o
	rm -Rf dist
