
ifndef OUTPUT
	OUTPUT:=$(shell grep metadata.yml -e "^generated_file: " | sed -e 's/generated_file: //' -e 's/ //g')
endif

ifndef BUILD
	BUILD:=build
endif

.PHONY: build clean abstract.md acknowledgements.md
.ONESHELL: build abstract.md acknowledgements.md .build-dir .gentexsnippet

build: EXT=pdf
debug: EXT=tex
debug: OUTPUT=debug

build debug: .build-dir abstract.md acknowledgements.md
	pandoc --number-sections --template=template/template.tex --pdf-engine=xelatex --toc \
		--from markdown+tex_math_dollars+tex_math_single_backslash \
		--variable="abstract_file:$(BUILD)/abstract.tex" --variable="acknowledgements_file:$(BUILD)/acknowledgements.tex" \
		--output "$(OUTPUT).$(EXT)" metadata.yml chapters/*.md

readme:
	pandoc --from markdown --to gfm --template=template/readme.template.md --output=README.md metadata.yml
	sed -i '' -e '/<p align="center" style="font-size:larger;">/,/<\/p>/s/  /<br\ \/>/g' README.md

abstract.md: SNIPPET_FILE=abstract
acknowledgements.md: SNIPPET_FILE=acknowledgements

abstract.md acknowledgements.md:
	echo "SNIPPET=$(SNIPPET_FILE)"
	pandoc --pdf-engine=xelatex -o "$(BUILD)/$(SNIPPET_FILE).tex" "$(SNIPPET_FILE).md"

clean:
	rm -rf build

.build-dir:
	mkdir -p build
