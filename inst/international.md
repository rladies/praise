
# International praise

This is a short document on how to add new languages to `praise`.

Starting from version 2, `praise` supports praising in multiple
languages. The language of the praise is selected based on the current
locale: if the praising package supports the language of the current
locale, then this language will be used.

The process involves a number of players, so let's start with some
definitions:
* *Developer* is the person that creates (or develops) the *praising
  package*. E.g. the developers of the `testthat` package, as this package
  uses `praise`.
* Praise *translators* are the people that add/extend word lists in
  multiple languages to the `praise` package itself.
* The *user* the user of the praising package (not the user of the
  `praise` package, at least, not directly).

To support international praise, each player needs to different steps.

## Users

To receive praise in a certain language, you need to change the locale,
by e.g. changing the `LANGUAGE` environment variable. If `praise`, and the
praising package both support this language, then R will praise you in this
language. E.g. to set the language to Hungarian, you would need to do:

```r
Sys.setenv(LANGUAGE = "hu_HU")
praise("Your tests are ${adjective}!")
```

Note that if R itself supports this language (and it probably does), then
the complete R interface will switch to using this language. This might or
might not be desired. To change only the praise language, without changing
R's language in general, you can set the `praise_language` global option
to the desired langauge:

```r
options(praise_language = "hu_HU")
praise("Your tests are ${adjective}!")
```

## Translators

### Contributing to an already supported language

Contributing to an already supported language is very easy. All you need
to do is to find the YAML file corresponding to your language in the
`inst/languages` directory, and add new words (or remove inappropriate
words) from the file. The syntax is easy and mostly self-explanatory.
You are also welcome to add new parts of speeches to this file.

### Adding support to a new language

For adding support to a new language, you will need the `msgtools`
package. Currently this package has some bugs, and you might need to install
a patched fork from GitHub:

```r
source("https://install-github.me/gaborcsardi/msgtools")
```

Once `msgtools` is installed, you can add follow the
[README](https://github.com/RL10N/msgtools#readme) file of `msgtools` to
add a new language:

1. Make sure `gettext` is available on your system with
   `msgtools::check_for_gettext()`.
2. Create the translation using `make_translation()` and
   `write_translation()`.
3. Edit the newly created translation file, add it `git`. In particular,
   you need to add a record for the `praiselanguage` string, for example
   Spanish would look like this:
   
    ```
    msgid "praiselanguage"
    msgstr "es"
    ```
   
4. Use `check_translations()` and `install_translations()` to install the
   newly added language.
5. Add your new language to the `R/package.R` file, in the
   `praise_parts_langs` list. Your entry will look like this:

    ```
    es = load_language("spanish")
    ```

   where `es` is the language code that you used for the `praiselanguage`
   string in the `po` file, and `spanish` is the name of the file containing
   the praise words in `inst/languages`. (See the next step.)
6. Create the list of praise words in `inst/languages`, in a YAML file.
   See the already existing YAML files for examples. It is a good idea to
   have at least the same parts of speech as in the `english.yaml` file,
   even if the number of words is small.

Note that this procedure is only needed if you are adding a new language
from scratch. For adding new praise words, you just need to edit the YAML
files, and you don't need the `msgtools` package at all.

We strongly suggest that the translation files have UTF-8 encoding.

### Translating `testthat` praise

In step 3. above you can also translate the praise messages from
`testthat`. These will be automatically picked up and used by `praise`
when running `testthat` tests. Note that when you are tranlating `praise`
templates here, the tranlation should (ideally) also be a template in the
new language, so that the praise is randomized. E.g. the Hungarian
translation has
```
msgid "${EXCLAMATION} - ${adjective} code."
msgstr "${FELKIALTAS} - ${melleknev} kód."
```
where *exclamation* is *felkialtas*  in Hungarian, and *adjective* is
*melleknev*. Also note that the cases of the strings are matched.

## Developers

If you are developing an R package that wants to praise users in multiple
languages, then you will need to install the `msgtools` package first,
see above.

You will need to use the `msgtools` package to translate your praising
messages into all languages that you want to support. Follow the `msgtools`
README and documentation. 

There are (at least) two ways to call `praise()` that are compatible with
internationalization and `msgtools`. Simple praise messages:

```r
message(praise("${Adjective} code."))
```

Selecting the praise message programatically:
```
messages <- gettext(c(
  "${EXCLAMATION} - ${adjective} code.",
  "Your tests are ${adjective}!"
))
message(praise(sample(messages, 1)))
```
Note that you need to use `gettext` in this case, otherwise `msgtools`
does not pick up the messages to translate. You don't need to specify
the domain for `gettext`.

The point is that all praise messages that are to be translated, need to be
within a `message` or `gettext` call (or `gettextf`, `warning` or `stop`,
but these are less common with praising).

# Contributions

`praise` welcomes contributions, big or small, and translations to new
languages as well. The only requirement is that `praise` messages and words
must be kept **nice** and inclusive. Please fork the repo at
https://github.com/rladies/praise.

It migth be a good idea to open a new issue in this repository when
starting with a new language, to make sure that nobody else starts working
on the same language, and the efforts can be coordinated.

# Questions, comments

If something does not work for you, or have a question, do not hesitate to
open an issue in the issue tracker at
https://github.com/rladies/praise/issues.
