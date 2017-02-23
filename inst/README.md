


# praise

> Praise Users

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Linux Build Status](https://travis-ci.org/gaborcsardi/praise.svg?branch=master)](https://travis-ci.org/gaborcsardi/praise)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/github/gaborcsardi/praise?svg=true)](https://ci.appveyor.com/project/gaborcsardi/praise)
[![](http://www.r-pkg.org/badges/version/praise)](http://www.r-pkg.org/pkg/praise)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/praise)](http://www.r-pkg.org/pkg/praise)


Build friendly R packages that praise their users if they have
done something good, or they just need it to feel better.

## Installation


```r
devtools::install_github("gaborcsardi/praise")
```

## Usage


```r
library(praise)
praise()
```

```
#> [1] "You are grand!"
```

You can supply a template, and `praise()` fills in random words of the specified
part of speech:


```r
praise("${EXCLAMATION}! You have done this ${adverb_manner}!")
```

```
#> [1] "OH! You have done this bravely!"
```

Note that capitalization in the inserted words will be the same as in the template:


```r
praise("${Exclamation}! ${EXCLAMATION}!-${EXCLAMATION}! This is just ${adjective}!")
```

```
#> [1] "Ole! AHHH!-GEE! This is just stylish!"
```

Currently supported parts of speech:


```r
names(praise_parts)
```

```
#> [1] "adjective"     "adverb_manner" "adverb"        "exclamation"  
#> [5] "rpackage"      "created"       "creating"
```

## International praise

Starting from version 2, `praise` supports praising in multiple languages. See the [inst/international.md](inst/international.md) file for more about this. Currently `praise` supports the following languages:

* English
* Hungarian

## License

MIT © [Gabor Csardi](https://github.com/gaborcsardi), [Sindre Sorhus](http://sindresorhus.com)
