vasttrafik-cli
==============

CLI program for listing Västtrafik departures

```sh
$ vasttrafik "Lindholm<TAB><TAB>
Lindholmen (Göteborg)             Lindholmsplatsen (Göteborg)
Lindholmens vändplan (Strömstad)  Lindholmsvägen (Strömstad)
Lindholmspiren (Göteborg)         
$ vasttrafik "Lindholmen (Göteborg)"
    16 Eketrägatan                     Nu     10
    16 Eketrägatan                     16     --
    16 Högsbohöjd                       6     16
    31 Eketrägatan                      8     21
    31 Hjalmar Brantingsplatsen        17     29
    45 Bäckebol                        15     29
    45 Marklandsgatan                   5     20
    55 Lindholmen                       1     11
    58 Bergsjön                        Nu     16
    58 Västra Eriksberg                 8     18
    99 Frölunda Torg                    8     17
    99 Hjalmar Brantingsplatsen         2     12
   121 Lindholmen                      15     47
   121 Torslanda                       18     50
```

To enable tab completion in bash, source the file `vasttrafik-completion.bash`.

```sh
$ . vasttrafik-completion.bash
```


TODO
----

* Make the completion script search for the file `allstops` (containing the
  complete list of stations) in predifined locations instead of requiring
  it to be in the current directory
* Don't escape spaces and other shell special characters if the common prefix
  of all matches doesn't contain any such characters.
* `make install` target
* deb packege (possibly)
* better instructions
