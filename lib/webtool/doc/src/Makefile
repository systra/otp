# ``The contents of this file are subject to the Erlang Public License,
# Version 1.1, (the "License"); you may not use this file except in
# compliance with the License. You should have received a copy of the
# Erlang Public License along with this software. If not, it can be
# retrieved via the world wide web at http://www.erlang.org/.
# 
# Software distributed under the License is distributed on an "AS IS"
# basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
# the License for the specific language governing rights and limitations
# under the License.
# 
# The Initial Developer of the Original Code is Ericsson Utvecklings AB.
# Portions created by Ericsson are Copyright 1999, Ericsson Utvecklings
# AB. All Rights Reserved.''
# 
#     $Id$
#
include $(ERL_TOP)/make/target.mk
include $(ERL_TOP)/make/$(TARGET)/otp.mk

# ----------------------------------------------------
# Application version
# ----------------------------------------------------
include ../../vsn.mk
VSN=$(WEBTOOL_VSN)
APPLICATION=webtool

DOC_EXTRA_FRONT_PAGE_INFO=Important note: \
The Webtool application is obsolete and will be removed \
in the next major OTP release

# ----------------------------------------------------
# Release directory specification
# ----------------------------------------------------
RELSYSDIR = $(RELEASE_PATH)/lib/$(APPLICATION)-$(VSN)

# ----------------------------------------------------
# Target Specs
# ----------------------------------------------------
XML_APPLICATION_FILES = ref_man.xml

XML_REF1_FILES = start_webtool.xml

XML_REF3_FILES = webtool.xml

XML_PART_FILES = \
	part.xml \
	part_notes.xml \
	part_notes_history.xml

XML_CHAPTER_FILES = \
	webtool_chapter.xml \
	notes.xml \
	notes_history.xml

BOOK_FILES = book.xml

XML_FILES = \
	$(BOOK_FILES) $(XML_CHAPTER_FILES) \
	$(XML_PART_FILES) $(XML_REF3_FILES) \
	 $(XML_REF1_FILES) $(XML_APPLICATION_FILES)

GIF_FILES =

# ----------------------------------------------------

HTML_FILES = $(XML_APPLICATION_FILES:%.xml=$(HTMLDIR)/%.html) \
	$(XML_PART_FILES:%.xml=$(HTMLDIR)/%.html)

INFO_FILE = ../../info

MAN1_FILES = $(XML_REF1_FILES:%.xml=$(MAN1DIR)/%.1)
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


clean clean_docs:
	rm -rf $(HTMLDIR)/*
	rm -f $(MAN1DIR)/*
	rm -f $(MAN3DIR)/*
	rm -f $(TOP_PDF_FILE) $(TOP_PDF_FILE:%.pdf=%.fo)
	rm -f errs core *~ 

man: $(MAN1_FILES) $(MAN3_FILES)

gifs: $(GIF_FILES:%=$(HTMLDIR)/%)

debug opt: 

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
	$(INSTALL_DIR) "$(RELEASE_PATH)/man/man1"
	$(INSTALL_DATA) $(MAN1_FILES) "$(RELEASE_PATH)/man/man1"
	$(INSTALL_DIR) "$(RELEASE_PATH)/man/man3"
	$(INSTALL_DATA) $(MAN3_FILES) "$(RELEASE_PATH)/man/man3"

release_spec:

