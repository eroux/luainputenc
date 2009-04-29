# Makefile for luainputenc.

NAME = luainputenc

GENERATED = eu2enc.def luainputenc.drv luainputenc.pdf lutf8x.def eu2lmr.fd \
	    luainputenc.sty inputenc.sty.diff luainputenc.lua lutf8.def 
SOURCE = luainputenc.dtx README Makefile
ALLFILES = $(GENERATED) $(SOURCE)

ZIP = $(NAME).zip

PDFLATEX = pdflatex --interaction=batchmode $< >/dev/null
MAKEINDEX = makeindex -s gind.ist $(subst .dtx,,$<) >/dev/null 2>&1

all: $(GENERATED)
ctan: $(ZIP)
world: all ctan

$(GENERATED): luainputenc.dtx
	$(PDFLATEX)
	$(MAKEINDEX)
	$(PDFLATEX)
	$(PDFLATEX)

$(ZIP): $(ALLFILES)
	@echo "Making $@ for normal CTAN distribution."
	@$(RM) -- $@
	@zip -9 $@ $(ALLFILES)

clean: 
	@$(RM) -- *.log *.aux *.toc *.idx *.ind *.ilg

mrproper: clean
	@$(RM) -- $(GENERATED) $(ZIP)

.PHONY: clean mrproper
