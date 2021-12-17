    .mmm,
    ]P""`                               ][
    ][   .dWW,]bWb  dWb  WdW[ dWW,]bWW,]WWW  dWb
    ]WWW ]bm,`]P T[]bmd[ W`   `md[]P ][ ][  ]P T[
    ][    ""W,][ ][]P""` W   .W"T[][ ][ ][  ][ ][
    ]bmm,]mmd[]WmW`'Wmm[ W   ]bmW[][ ][ ]bm 'WmW`
    '"""` """ ]["`  '""  "    ""'`'` '`  ""  '"`
              ][

1. [Usage][]
2. [Where to find][]
3. [Build newGRF][]
4. [Packaging for BaNaNaS][]
5. [Playtesting][]


-------
1 Usage
-------

Enable this newGRF and select a naming variant when you create a new game.

Current variants:
- `mixed` (real town names and generated names mixed together)
- `generated` (only generated pseudo names)
- `real towns` (only Esperanto versions of real town names)


---------------
2 Where to find
---------------

- Forum:   https://www.TT-Forums.net/viewtopic.php?p=1250403
- GitHub:  https://GitHub.com/LaPingvino/Esperanto-Town-Names
- GitLab:  https://GitLab.com/basxto/Esperanto-Town-Names (mirror)
- BaNaNaS: https://BaNaNaS.OpenTTD.org/package/newgrf/37550501

See [changelog][] for release history.

See [license][] for the granted license.


--------------
3 Build newGRF
--------------

With the the [NML][] compiler installed, just type in your terminal:

    $ nmlc -l src/lang --custom-tags=src/custom_tags.txt src/esperanto_town_names.nml

Or with GNU [Make][] installed just:

    $ make grf

If nmlc iss not installed, you have to give the full path:

    $ make grf NMLC="<path/to/nmlc>"


---------------------------
4 Packaging for [BaNaNaS][]
---------------------------

This needs GNU [Tar][] or something compatible:

    $ make dist

This will create the file `build/esperanto_town_names-*.tar`.
`*` is a placeholder for the current version.

Make sure to bump `VERSIO` in `src/custom_tags.txt`
and `version` in the .nml for a new release.


---------------------------
5 Playtesting
---------------------------

As already mentioned, you can build a current version of this newGRF
and launch it with OpenTTD through:

    $ make test

If such an instance is already running, you can:

    $ make dist

And then in the ingame console:

    reload_newgrfs
    restart

[changelog]:             CHANGELOG.md
[license]:               LICENSE.md
[NML]:                   https://github.com/OpenTTD/NML
[Make]:                  https://www.GNU.org/software/Make/
[BaNaNaS]:               https://BaNaNaS.OpenTTD.org/
[Tar]:                   https://www.GNU.org/software/Tar/

[Usage]:                 #1-usage
[Where to find]:         #2-where-to-find
[Build newGRF]:          #3-build-newgrf
[Packaging for BaNaNaS]: #4-packaging-for-bananas
[Playtesting]:           #5-playtesting