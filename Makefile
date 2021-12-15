grfname=esperanto_town_names
langdir=lang
nmlc=nmlc

.PHONY : build clean
build: $(grfname).grf

%.grf: %.nml $(langdir)/esperanto.lng $(langdir)/*
	$(nmlc) -o $@ -l $(langdir) --default-lang=esperanto.lng $<

clean:
	$(RM) $(grfname).grf