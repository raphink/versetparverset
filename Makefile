define LATEX_PREAMBLE
\usepackage[french]{babel}\setmainfont{Linux Libertine O}\setsansfont{Linux Biolinum O}\setmonofont[HyphenChar=None]{DejaVu Sans Mono}
endef

all: luc8.pdf

%.html: %.rst
	rst2html $< > $@

%.tex: %.rst
	rst2xetex --latex-preamble='$(LATEX_PREAMBLE)' $< > $@

%.pdf: %.tex
	xelatex -interaction=batchmode $<

clean:
	rm -f *.html *.tex
	rm -f *.out *.log *.aux *.pdf
