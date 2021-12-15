grfname=esperanto_town_names
version=1.2
builddir=build
srcdir=src
langdir=$(srcdir)/lang
NMLC=nmlc
NMLCFLAGS=
TAR=tar
YAGL=yagl
OTTD=openttd

.PHONY : all debug dist grf nfo decode test clean
all: grf dist

debug: NMLCFLAGS += -d
debug: all

dist: $(builddir)/$(grfname).tar

$(builddir)/:
	mkdir -p $@

grf: $(builddir)/$(grfname).grf

$(builddir)/%.grf: $(srcdir)/%.nml $(langdir)/english.lng $(langdir)/* | $(builddir)/
	$(NMLC) $(NMLCFLAGS) --grf $@ -l $(langdir) --custom-tags=$(srcdir)/custom_tags.txt --default-lang=english.lng $<

nfo: $(builddir)/$(grfname).nfo

$(builddir)/%.nfo: $(srcdir)/%.nml $(langdir)/english.lng $(langdir)/* | $(builddir)/
	$(NMLC) $(NMLCFLAGS) --nfo $@ -l $(langdir) --custom-tags=$(srcdir)/custom_tags.txt --default-lang=english.lng $<

# to lower case; remove build/; add name-version/
$(builddir)/%.tar: $(builddir)/%.grf LICENSE.txt CHANGELOG.md README.md
	$(TAR) --transform='s/\(.*\)/\L\1/' --transform='s|build/||' --transform='s/\.md/.txt/' --transform='s|.*|$(grfname)-$(version)/&|' -cvf $@ $^

# just for checking the grf
decode: $(builddir)/$(grfname).yagl

$(builddir)/%.yagl: $(builddir)/%.grf
	$(YAGL) --decode $< ./

# OpenTTD needs the tar file
test: dist
	$(OTTD) -x -g -c run/openttd.cfg

clean:
	$(RM) $(builddir)/*.grf $(builddir)/*.nfo $(builddir)/*.tar $(builddir)/*.yagl