emacs ?= emacs
BEMACS = $(emacs) -batch -l test/elpa.el

all: emacsq

update:
	emacs -batch -l test/make-update.el

emacsq:
	emacs -Q -l test/elpa.el -l org-download.el -l org-roam-download.el ~/test.org

compile:
	$(BEMACS) -batch $(LOAD) --eval "(byte-compile-file \"org-download.el\")"
	$(BEMACS) -batch $(LOAD) --eval "(byte-compile-file \"org-roam-download.el\")"

clean:
	rm -f *.elc

.PHONY: all update emacsq compile clean
