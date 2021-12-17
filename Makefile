grfname=esperanto_town_names
version := $(shell grep VERSIO "src/custom_tags.txt" | cut -d':' -f2)
builddir=build
srcdir=src
langdir=$(srcdir)/lang
NMLC=nmlc
NMLCFLAGS=
TAR=tar
ZIP=zip
YAGL=yagl
OTTD=openttd

.PHONY : all debug grf nfo dist zip source decode test clean
all: grf dist

debug: NMLCFLAGS += -d
debug: all

$(builddir)/:
	mkdir -p $@

grf: $(builddir)/$(grfname).grf

$(builddir)/%.grf: $(srcdir)/%.nml $(srcdir)/custom_tags.txt $(langdir)/english.lng $(langdir)/* | $(builddir)/
	$(NMLC) $(NMLCFLAGS) --grf $@ -l $(langdir) --custom-tags=$(srcdir)/custom_tags.txt --default-lang=english.lng $<

nfo: $(builddir)/$(grfname).nfo

$(builddir)/%.nfo: $(srcdir)/%.nml $(srcdir)/custom_tags.txt $(langdir)/english.lng $(langdir)/* | $(builddir)/
	$(NMLC) $(NMLCFLAGS) --nfo $@ -l $(langdir) --custom-tags=$(srcdir)/custom_tags.txt --default-lang=english.lng $<

dist: $(builddir)/$(grfname)-$(version).tar

# to lower case; remove build/; add name-version/
$(builddir)/%-$(version).tar: $(builddir)/%.grf LICENSE.txt CHANGELOG.md README.md
	$(TAR) --transform='s/\(.*\)/\L\1/' --transform='s|build/||' --transform='s/\.md/.txt/' --transform='s|.*|$(grfname)-$(version)/&|' -cvf $@ $^

zip: $(builddir)/$(grfname)-$(version).tar.zip

%.zip: %
	$(ZIP) -9 $@ $<

source: $(builddir)/$(grfname)-$(version)_source.tar.gz

$(builddir)/$(grfname)-$(version)_source.tar.gz: $(builddir)/
	git archive --format=tar.gz -9 trunko --prefix=$(grfname)-$(version)_source/ -o $@


# just for checking the grf
decode: $(builddir)/$(grfname).yagl

$(builddir)/%.yagl: $(builddir)/%.grf
	$(YAGL) --decode $< ./

# OpenTTD needs the tar file
test: dist
	sed "s|$(grfname)-.*/|$(grfname)-$(version)/|" -i run/openttd.cfg
	$(OTTD) -x -g -c run/openttd.cfg

clean:
	$(RM) $(builddir)/*.grf $(builddir)/*.nfo $(builddir)/*.tar $(builddir)/*.yagl $(builddir)/*.zip $(builddir)/*.gz