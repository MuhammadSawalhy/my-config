

.PHONY: all

ifeq ($(origin REVERSE), undefined)
FILES = $(./linux-hard-link-files.bash -d)
all: linux/$(FILES)
else
FILES = $(./linux-hard-link-files.bash -rd)
all: ~/$(FILES)
endif

linux/%: ~/%
	ln $< $@

~/%: linux/%
	ln $< $@

