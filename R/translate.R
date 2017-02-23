
#' @importFrom withr with_envvar

translate <- function(template) {

  lang <- getOption("praise_language", "")
  if (lang != "") {
    with_envvar(c(LANGUAGE = lang), translate2(template))
  } else {
    translate2(template)
  }
}

translate2 <- function(template) {

  ## Call gettext() on the template, in case the calling package
  ## has translations for the current locale.
  caller <- environmentName(topenv())
  ttemplate <- gettext(template, domain = paste0("R-", caller))

  ## Are we in a praise-supported locale? If not, exit
  lang <- gettext("praiselanguage", domain = "R-praise")
  if (lang == "praiselanguage") {
    return(list(template = ttemplate, lang = "en"))
  }

  ## Yes, we are, check if the template was already translated
  ## If not, we try to translate it using the translations in praise
  ## itself
  if (ttemplate != template) {
    ttemplate <- gettext(template, domain = "R-praise")
  }

  ## OK, we are done, substitution will do the rest
  list(template = ttemplate, lang = lang)
}
