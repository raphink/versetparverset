define LATEX_PREAMBLE
\usepackage[french]{babel}\setmainfont{Linux Libertine O}\setsansfont{Linux Biolinum O}\setmonofont[HyphenChar=None]{DejaVu Sans Mono}
endef

KINDLE_PATH=/documents/raphael
DOCUMENT=luc8

all: $(DOCUMENT).pdf

kindle: $(DOCUMENT)-to-kindle

%.html: %.rst
	rst2html $< > $@

%.epub: %.html
	ebook-convert $< $@

%.mobi: %.html
	ebook-convert $< $@

%-to-kindle: %.mobi
	-ebook-device mkdir "$(KINDLE_PATH)"
	ebook-device cp $< "prs500:$(KINDLE_PATH)"

%.tex: %.rst
	rst2xetex --latex-preamble='$(LATEX_PREAMBLE)' $< > $@

%.pdf: %.tex
	xelatex -interaction=batchmode $<

clean:
	rm -f *.html *.tex
	rm -f *.out *.log *.aux *.pdf
	rm -f *.epub *.mobi
