all: luc8.pdf

%.html: %.rst
	rst2html $<

%.tex: %.rst
	rst2xetex $<

%.pdf: %.tex
	xelatex -interaction=batchmode $<

clean:
	rm -f *.html *.tex
	rm -f *.out *.log *.aux *.pdf
