1. [Usage][]
2. [Where to find][]
3. [Build newGRF][]
4. [Packaging for BaNaNaS][]

-------
1 Usage
-------

Just activate the newGRF and select one of the naming variants when creating a new game.

Current variants:
- `mixed` (real town names and generated names mixed together)
- `generated` (only generated pseudo names)
- `real towns` (only Esperanto versions of real town names)

---------------
2 Where to find
---------------

- Forum:   https://www.TT-Forums.net/viewtopic.php?p=1250403
- GitHub:  https://GitHub.com/LaPingvino/Esperanto-Town-Names
- GitLab:  https://GitLab.com/basxto/Esperanto-Town-Names (automated mirror)
- BaNaNaS: https://BaNaNaS.OpenTTD.org/package/newgrf/37550501

See [changelog][] for release history.

--------------
3 Build newGRF
--------------

With the the [NML][] compiler installed you can just type this into your terminal:

    $ nmlc -l src/lang --custom-tags=src/custom_tags.txt src/esperanto_town_names.nml

Or with GNU [Make][] installed just:

    $ make grf

If it's not installed, you have to give the full path:

    $ make grf NMLC="<path/to/nmlc>"

---------------------------
4 Packaging for [BaNaNaS][]
---------------------------

This needs GNU [Tar][] or something compatible:

    $ make dist

This will create the file `build/esperanto_town_names-*.tar` with the current version number instead of `*`.

Make sure to bump the version number in `src/custom_tags.txt` before publishing a new release.
It might also be necessary to change the last line of `run/openttd.cfg` for `make test` to work with a different version.

[changelog]: CHANGELOG.md
[NML]: https://github.com/OpenTTD/NML
[Make]: https://www.GNU.org/software/Make/
[BaNaNaS]: https://BaNaNaS.OpenTTD.org/
[Tar]: https://www.GNU.org/software/Tar/

[Usage]: #1-usage
[Where to find]: #2-where-to-find
[Build newGRF]: #3-build-newgrf
[Packaging for BaNaNaS]: #4-packaging-for-bananas