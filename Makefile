
all: inst/README.md

inst/README.md: inst/README.Rmd
	Rscript -e "library(knitr); knit('$<', output = '$@', quiet = TRUE)"
