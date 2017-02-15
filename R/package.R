
#' @title Praise Users
#' @name praise
#' @description Build friendly R packages that
#' praise their users if they have done something
#' good, or they just need it to feel better.
#'
#' @docType package
#' @aliases praise praise-package

NULL

load_language <- function(lang) {
  lang_file <- system.file(
    package = .packageName,
    "languages",
    paste0(lang, ".R")
  )
  env <- new.env()
  source(lang_file, local = env)
  as.list(env)
}

#' Parts of speech for praising
#'
#' @format
#' Named list of character vectors. List entries: \describe{
#'   \item{adjective}{Words and phrases to be used as positive adjectives.
#'     Most of them are from \url{https://github.com/sindresorhus/superb}.}
#'   \item{adverb}{Adverbs.}
#'   \item{adverb_manner}{Adverbs of manner, with positive meanings.}
#'   \item{created}{Synonyms of \sQuote{create} in paste tense.}
#'   \item{creating}{Synonyms of \sQuote{create}, in present participle
#'     form.}
#'   \item{exclamation}{Positive exclamations.}
#'   \item{rpackage}{Synonyms for the term \sQuote{R package}.}
#' }
#'
#' @export

praise_parts <- load_language("english")

#' Parts of speech for praising, in all supported languages.
#'
#' @format
#' It is a named list, and each element is a language. The names of the
#' list elements are lowercase two letter ISO 639-1 codes.
#'
#' Each list element is a list itself, and contains different parts of
#' speech. E.g. for English we have: \describe{
#'   \item{adjective}{Words and phrases to be used as positive adjectives.
#'     Most of them are from \url{https://github.com/sindresorhus/superb}.}
#'   \item{adverb}{Adverbs.}
#'   \item{adverb_manner}{Adverbs of manner, with positive meanings.}
#'   \item{created}{Synonyms of \sQuote{create} in paste tense.}
#'   \item{creating}{Synonyms of \sQuote{create}, in present participle
#'     form.}
#'   \item{exclamation}{Positive exclamations.}
#'   \item{rpackage}{Synonyms for the term \sQuote{R package}.}
#' }
#'
#' @export

praise_parts_langs <- list(
  en = praise_parts,
  hu = load_language("hungarian")
)


#' Randomized praise based on a template
#'
#' @details
#' Replace parts of the template with random words from the praise
#' word lists. See examples below.
#'
#' @param template Character scalar, the template string.
#' @export
#' @examples
#' praise()
#'
#' ## Capitalization
#' praise("${Exclamation}! This ${rpackage} is ${adjective}!")
#'
#' ## All upper case
#' praise("${EXCLAMATION}! You have done this ${adverb_manner}!")

praise <- function(template = "You are ${adjective}!") {
  intl_template <- translate(template)
  while (is_template(intl_template)) {
    intl_template <- replace_one_template(intl_template)
  }
  intl_template$template
}


template_pattern <- "\\$\\{([^\\}]+)\\}"


is_template <- function(x) grepl(template_pattern, x$template)


replace_one_template <- function(intl_template) {
  template <- intl_template$template
  match <- regexpr(template_pattern, template, perl = TRUE)

  template1 <- substring(
    template,
    match,
    match + attr(match, "match.length") - 1L
  )

  part <- substring(
    template,
    attr(match, "capture.start"),
    attr(match, "capture.start") + attr(match, "capture.length") - 1L
  )

  parts <- praise_parts_langs[[intl_template$lang]]

  intl_template$template <-match_case_sub(
    template1,
    part,
    sample(parts[[tolower(part)]], 1),
    template
  )

  intl_template
}


match_case_sub <- function(pattern, part, replacement, text) {
  if (toupper(part) == part) {
    replacement <- toupper(replacement)
  } else if (capitalize(part) == part) {
    replacement <- capitalize(replacement)
  }

  sub(pattern, replacement, text, fixed = TRUE)
}

capitalize <- function(x) {
  paste0(
    toupper(substring(x, 1, 1)),
    substring(x, 2)
  )
}
