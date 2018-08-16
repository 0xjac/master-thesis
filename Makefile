ifndef BUILD
	BUILD:=build
endif

ifndef BIBLIOGRAPHY
	BIBLIOGRAPHY:=$(shell grep metadata.yml -e "^bibliography: " | sed -e 's/bibliography: //' -e 's/ //g')
endif

ifndef GLOSSARY
	GLOSSARY:=$(shell grep metadata.yml -e "^glossary: " | sed -e 's/glossary: //' -e 's/ //g')
endif

ifndef OUTPUT_FILE
	OUTPUT_FILE:=$(shell grep metadata.yml -e "^generated_file: " | sed -e 's/generated_file: //' -e 's/ //g')
endif

ifndef DIST_DIR
  DIST_DIR:=.
endif

OUTPUT:=$(BUILD)/$(OUTPUT_FILE)

.PHONY: build clean abstract.md acknowledgements.md
.ONESHELL: build debug fast abstract.md acknowledgements.md .build-dir .gen-tex .tex

build: clean .tex

fast: .gen-tex
	@echo "OUTPUT=$(OUTPUT)"
	cp -r ./lib/* "$(BUILD)/"
	cp "glossary.tex" "$(BUILD)/glossary.tex"
	cp "$(BIBLIOGRAPHY).bib" "$(BUILD)/$(BIBLIOGRAPHY).bib"
	xelatex -output-directory="$(BUILD)" "$(OUTPUT)"
	mv "$(OUTPUT).pdf" "$(DIST_DIR)/"
	@echo "PDF generated: $(DIST_DIR)/$(OUTPUT_FILE).pdf"

.tex: .gen-tex
	@echo "OUTPUT=$(OUTPUT)"
	cp -r ./lib/* "$(BUILD)/"
	cp "glossary.tex" "$(BUILD)/glossary.tex"
	cp "$(BIBLIOGRAPHY).bib" "$(BUILD)/$(BIBLIOGRAPHY).bib"
	xelatex -output-directory="$(BUILD)" "$(OUTPUT)"
	makeglossaries -d "$(BUILD)" "$(OUTPUT_FILE)"
	xelatex -output-directory="$(BUILD)"  "$(OUTPUT)"
	bibtex "$(OUTPUT)"
	xelatex -output-directory="$(BUILD)"  "$(OUTPUT)"
	xelatex -output-directory="$(BUILD)" "$(OUTPUT)"
	mv "$(OUTPUT).pdf" "$(DIST_DIR)/"
	@echo "PDF generated: $(DIST_DIR)/$(OUTPUT_FILE).pdf"

readme:
	pandoc --from markdown --to gfm --template=template/readme.template.md --output=README.md metadata.yml
	sed -i '' -Ee '/<p align="center" style="font-size:(large|larger);">/,/<\/p>/s/  /<br\ \/>/g' README.md

abstract.md: SNIPPET_FILE=abstract
acknowledgements.md: SNIPPET_FILE=acknowledgements

abstract.md acknowledgements.md:
	@echo "SNIPPET=$(SNIPPET_FILE)"
	pandoc --pdf-engine=xelatex -o "$(BUILD)/$(SNIPPET_FILE).tex" "$(SNIPPET_FILE).md"

clean:
	rm -rf build
	rm -rf "$(OUTPUT)."{aux,bbl,blg,lof,log,lot,out,tex,toc}

.build-dir:
	mkdir -p build

.gen-tex: .build-dir abstract.md acknowledgements.md
	pandoc --number-sections --template=template/template.tex --toc --listings \
	  --from markdown+tex_math_dollars+tex_math_single_backslash --natbib \
		--variable="abstract_file:$(BUILD)/abstract.tex" --variable="acknowledgements_file:$(BUILD)/acknowledgements.tex" \
		--output "$(OUTPUT).tex" metadata.yml chapters/*.md
