# Makefile for luainputenc.

NAME = luainputenc

DOC = luainputenc.pdf
RUNFILES = eu2enc.def lutf8.def lutf8x.def eu2lmr.fd inputenc.sty.diff \
	   luainputenc.sty luainputenc.lua 
SOURCE = luainputenc.dtx README Makefile

GENERATED = $(DOC) $(RUNFILES)
ALLFILES = $(GENERATED) $(SOURCE)

DTX = $(NAME).dtx
ZIP = $(NAME).zip

TEX = tex --interaction=batchmode $< >/dev/null
PDFLATEX = pdflatex --interaction=batchmode $< >/dev/null
MAKEINDEX = makeindex -s gind.ist $(subst .dtx,,$<) >/dev/null 2>&1

all: $(GENERATED)
ctan: $(ZIP)
world: all ctan

$(DOC): $(DTX)
	$(PDFLATEX)
	$(MAKEINDEX)
	$(PDFLATEX)
	$(PDFLATEX)

$(RUNFILES): $(DTX)
	$(TEX)

$(ZIP): $(ALLFILES)
	@echo "Making $@ for normal CTAN distribution."
	@$(RM) -- $@
	@zip -9 $@ $(ALLFILES) >/dev/null

clean: 
	@$(RM) -- *.log *.aux *.toc *.idx *.ind *.ilg

mrproper: clean
	@$(RM) -- $(GENERATED) $(ZIP)

.PHONY: clean mrproper
