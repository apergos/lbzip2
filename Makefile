# Makefile,v 1.9 2009/04/03 22:33:49 lacos Exp
.POSIX:

CC=gcc
CFLAGS=$$($(SHELL) lfs.sh CFLAGS) -D _XOPEN_SOURCE=500 -pipe -ansi -pedantic \
    -O2




LDFLAGS=-s $$($(SHELL) lfs.sh LDFLAGS)
LIBS=-l pthread -l bz2 $$($(SHELL) lfs.sh LIBS)

OBJECTS=main.o lbzip2.o lbunzip2.o lacos_rbtree.o \
    yambi/compat.o yambi/crctab.o yambi/decode.o yambi/emit.o yambi/retrieve.o

lbzip2: $(OBJECTS)
	$(CC) -o lbzip2 $(LDFLAGS) $(OBJECTS) $(LIBS)

main.o: main.c main.h lbunzip2.h lbzip2.h
	$(CC) $(CFLAGS) -c main.c

lbzip2.o: lbzip2.c main.h lbzip2.h lacos_rbtree.h
	$(CC) $(CFLAGS) -c lbzip2.c

lbunzip2.o: lbunzip2.c yambi/compat.h main.h lbunzip2.h lacos_rbtree.h
	$(CC) $(CFLAGS) -c lbunzip2.c

lacos_rbtree.o: lacos_rbtree.c lacos_rbtree.h
	$(CC) $(CFLAGS) -c lacos_rbtree.c

yambi/compat.o: yambi/compat.c yambi/compat.h yambi/yambi.h
	$(CC) $(CFLAGS) -c -I yambi -o $@ yambi/compat.c

yambi/crctab.o: yambi/crctab.c yambi/private.h yambi/yambi.h
	$(CC) $(CFLAGS) -c -I yambi -o $@ yambi/crctab.c

yambi/decode.o: yambi/decode.c yambi/decode.h yambi/private.h yambi/yambi.h
	$(CC) $(CFLAGS) -c -I yambi -o $@ yambi/decode.c

yambi/emit.o: yambi/emit.c yambi/decode.h yambi/private.h yambi/yambi.h
	$(CC) $(CFLAGS) -c -I yambi -o $@ yambi/emit.c

yambi/retrieve.o: yambi/retrieve.c yambi/decode.h yambi/private.h yambi/yambi.h
	$(CC) $(CFLAGS) -c -I yambi -o $@ yambi/retrieve.c

clean:
	rm -f lbzip2 $(OBJECTS)

check:
	$(SHELL) test.sh $(TESTFILE)
