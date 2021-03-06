#
# %CopyrightBegin%
#
# Copyright Ericsson AB 2006-2012. All Rights Reserved.
#
# The contents of this file are subject to the Erlang Public License,
# Version 1.1, (the "License"); you may not use this file except in
# compliance with the License. You should have received a copy of the
# Erlang Public License along with this software. If not, it can be
# retrieved online at http://www.erlang.org/.
#
# Software distributed under the License is distributed on an "AS IS"
# basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
# the License for the specific language governing rights and limitations
# under the License.
#
# %CopyrightEnd%
#
include $(ERL_TOP)/make/target.mk
include $(ERL_TOP)/make/$(TARGET)/otp.mk

# ----------------------------------------------------
# Application version
# ----------------------------------------------------
include ../../vsn.mk
VSN=$(SYNTAX_TOOLS_VSN)
APPLICATION=syntax_tools

# ----------------------------------------------------
# Release directory specification
# ----------------------------------------------------
RELSYSDIR = $(RELEASE_PATH)/lib/$(APPLICATION)-$(VSN)

# ----------------------------------------------------
# Man page source directory (with .erl files)
# ----------------------------------------------------
SRC_DIR = $(ERL_TOP)/lib/syntax_tools/src
INC_DIR = $(ERL_TOP)/lib/syntax_tools/include

# ----------------------------------------------------
# Target Specs
# ----------------------------------------------------
XML_APPLICATION_FILES = ref_man.xml
XML_REF3_FILES = \
	epp_dodger.xml \
	erl_comment_scan.xml \
	erl_prettypr.xml \
	erl_recomment.xml \
	erl_syntax.xml \
	erl_syntax_lib.xml \
	erl_tidy.xml \
	igor.xml \
	merl.xml \
	merl_transform.xml \
	prettypr.xml

XML_PART_FILES = part.xml part_notes.xml
XML_CHAPTER_FILES = chapter.xml
XML_NOTES_FILES = notes.xml

BOOK_FILES = book.xml


XML_FILES=\
	$(BOOK_FILES) $(XML_CHAPTER_FILES) \
	$(XML_PART_FILES) $(XML_REF3_FILES) $(XML_APPLICATION_FILES) \
	$(XML_NOTES_FILES)

# ----------------------------------------------------
INFO_FILE = ../../info

HTML_FILES = \
	$(XML_APPLICATION_FILES:%.xml=$(HTMLDIR)/%.html) \
	$(XML_PART_FILES:%.xml=$(HTMLDIR)/%.html)

MAN3_FILES = $(XML_REF3_FILES:%.xml=$(MAN3DIR)/%.3)


HTML_REF_MAN_FILE = $(HTMLDIR)/index.html

TOP_PDF_FILE = $(PDFDIR)/$(APPLICATION)-$(VSN).pdf

# ----------------------------------------------------
# FLAGS 
# ----------------------------------------------------
XML_FLAGS += 
DVIPS_FLAGS += 

# ----------------------------------------------------
# Targets
# ----------------------------------------------------
$(HTMLDIR)/%.gif: %.gif
	$(INSTALL_DATA) $< $@

docs: pdf html man

$(TOP_PDF_FILE): $(XML_FILES)

pdf: $(TOP_PDF_FILE)

html: gifs $(HTML_REF_MAN_FILE)

man: $(MAN3_FILES)

$(XML_REF3_FILES):
	escript $(DOCGEN)/priv/bin/xml_from_edoc.escript $(SRC_DIR)/$(@:%.xml=%.erl)

$(XML_CHAPTER_FILES):
	escript $(DOCGEN)/priv/bin/xml_from_edoc.escript -def vsn $(VSN) -chapter ../overview.edoc 

gifs: $(GIF_FILES:%=$(HTMLDIR)/%)

xml: $(XML_REF3_FILES) $(XML_CHAPTER_FILES)

debug opt: 

clean clean_docs:
	rm -rf $(HTMLDIR)/*
	rm -f $(MAN3DIR)/*
	rm -f $(XML_REF3_FILES) $(XML_CHAPTER_FILES) *.html
	rm -f $(TOP_PDF_FILE) $(TOP_PDF_FILE:%.pdf=%.fo)
	rm -f errs core *~ 

# ----------------------------------------------------
# Release Target
# ---------------------------------------------------- 
include $(ERL_TOP)/make/otp_release_targets.mk

release_docs_spec: docs
	$(INSTALL_DIR) "$(RELSYSDIR)/doc/pdf"
	$(INSTALL_DATA) $(TOP_PDF_FILE) "$(RELSYSDIR)/doc/pdf"
	$(INSTALL_DIR) "$(RELSYSDIR)/doc/html"
	$(INSTALL_DATA) $(HTMLDIR)/* \
		"$(RELSYSDIR)/doc/html"
	$(INSTALL_DATA) $(INFO_FILE) "$(RELSYSDIR)"
	$(INSTALL_DIR) "$(RELEASE_PATH)/man/man3"
	$(INSTALL_DATA) $(MAN3DIR)/* "$(RELEASE_PATH)/man/man3"

release_spec:
