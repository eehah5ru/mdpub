SHELL := /bin/bash

THISPATH=$(shell pwd)
BASEPATH=$(THISPATH)
OUTPUT_FOLDER=output

SRC_NAME ?= "default"

TEMPLATE ?= "default-template"

BUILDNAME=$(SRC_NAME)

# TIMESTAMP=$(shell date "+%Y%m%d-%H%M%S")
# BUILDNAME=cv-$(TIMESTAMP)

PANDOC_OPTIONS=--dpi=600 --pdf-engine=xelatex

OUTPUTPATH=$(THISPATH)/$(OUTPUT_FOLDER)/$(BUILDNAME)
SRC_PATH=$(THISPATH)/$(SRC_NAME).md

TEMPLATEPATH=$(THISPATH)/templates
TEMPLATEFILE=$(TEMPLATEPATH)/$(TEMPLATE).tex

.DEFAULT_GOAL := pdf
.PHONY: all clean html pdf epub embed viewpdf viewhtml

.PHONY: pre
pre:
	# @echo Using config: $(MDCFG)
	@mkdir -p $(OUTPUT_FOLDER)

.PHONY: post
post:
	@echo "Finished compiling all targets"

.PHONY: clean
clean:
	@rm -f $(OUTPUT_FOLDER)/*

.PHONY: pdf
pdf: pre
	cd $(BASEPATH) && \
	pandoc -o $(OUTPUTPATH).tex --template=$(TEMPLATEFILE) $(PANDOC_OPTIONS) $(SRC_PATH) && \
	cd $(THISPATH)/$(OUTPUT_FOLDER) && \
	latexmk -nobibtex -f $(BUILDNAME).tex
