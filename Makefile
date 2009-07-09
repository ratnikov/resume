TARGET=resume.pdf web-resume.pdf
CLASS=resume.cls

all: $(TARGET)

publish: $(TARGET)
	scp $(TARGET) $(REMOTE)

%.dvi: %.tex
	latex $<
#%.pdf: %.dvi
#	dvipdf $<
#%.ps: %.dvi
#	dvips $< -o$@

%.pdf: %.tex
	pdflatex $<

%.ps: %.pdf
	pdf2ps $<

%.html: %.pdf
	pdftohtml -q -noframes $<

%.txt: %.html
	w3m -dump -cols 72 -T text/html $< > $@

$(TARGET): $(CLASS)

clean:
	rm -f $(TARGET:%.pdf=%.aux)
	rm -f $(TARGET:%.pdf=%.dvi)
	rm -f $(TARGET:%.pdf=%.log)
	rm -f $(TARGET:%.pdf=%.pdf)
	rm -f $(TARGET:%.pdf=%.ps)
	rm -f $(TARGET:%.pdf=%.html)
	rm -f $(TARGET:%.pdf=%.txt)

.PHONY: all publish clean
