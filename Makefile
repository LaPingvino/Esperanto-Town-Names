grfname=esperanto_town_names
version=1.2
builddir=build
srcdir=src
langdir=$(srcdir)/lang
nmlc=nmlc
tar=tar

.PHONY : build clean
build: $(builddir)/$(grfname).grf $(builddir)/$(grfname).tar

$(builddir)/:
	mkdir $@

$(builddir)/%.grf: $(srcdir)/%.nml $(langdir)/english.lng $(langdir)/* | $(builddir)/
	$(nmlc) -o $@ -l $(langdir) --default-lang=english.lng $<

# to lower case; remove build/; add name-version/
$(builddir)/%.tar: $(builddir)/%.grf LICENSE.txt
	$(tar) --transform='s/\(.*\)/\L\1/' --transform='s|build/||' --transform='s|.*|$(grfname)-$(version)/&|' -cvf $@ $^

clean:
	$(RM) $(builddir)/$(grfname).grf $(builddir)/$(grfname).tar