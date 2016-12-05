### wien2wannier/test/repl/Makefile
###
###    wien2wannier/test/repl/Makefile
###
### Copyright 2016 Elias Assmann

-include ../../make.sys

SUBDIRS := PoC repl

CASES=$(subst /,, $(wildcard */))

.ONESHELL:
SHELL=/bin/bash
.SHELLFLAGS = -ec

.PHONY: all clean $(CASES)

all: $(CASES)

$(CASES):
	@cd $@
	./$@.sh

clean:
	@for d in $(CASES); do
	   git clean -f $d
	done

## Time-stamp: <2016-07-13 17:24:58 assman@faepop71.tu-graz.ac.at>
