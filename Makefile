define LATEX_PREAMBLE
\usepackage[french]{babel}\setmainfont{Linux Libertine O}\setsansfont{Linux Biolinum O}\setmonofont[HyphenChar=None]{DejaVu Sans Mono}
endef

KINDLE_PATH=/documents/raphael
DOCUMENT=luc8
AUTHOR=Raphaël Pinson
LANGUAGE=fr
PUBDATE=$(shell date)

EBOOK_CONVERT_OPTS=--authors "$(AUTHOR)" --language "$(LANGUAGE)" --pubdate "$(PUBDATE)" --keep-ligatures

all: $(DOCUMENT).pdf

kindle: $(DOCUMENT)-to-kindle

%.html: %.rst
	# h1 level is for the document title
	rst2html --initial-header-level=2 --no-toc-backlinks $< > $@

%.epub: %.html
	ebook-convert $< $@ $(EBOOK_CONVERT_OPTS)

%.mobi: %.html
	ebook-convert $< $@ $(EBOOK_CONVERT_OPTS)

%-to-kindle: %.mobi
	# cp -f doesn't work, we need to remove
	ebook-device rm "$(KINDLE_PATH)/$<"
	-ebook-device mkdir "$(KINDLE_PATH)"
	ebook-device cp $< "prs500:$(KINDLE_PATH)/$<"

%.tex: %.rst
	rst2xetex --latex-preamble='$(LATEX_PREAMBLE)' $< > $@

%.pdf: %.tex
	xelatex -interaction=batchmode $<
	xelatex -interaction=batchmode $<

clean:
	rm -f *.html *.tex
	rm -f *.out *.log *.aux *.toc *.pdf
	rm -f *.epub *.mobi
