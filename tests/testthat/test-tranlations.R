
context("translations")

test_that("built-in praise translations work", {
  expect_equal(
    withr::with_envvar(c(LANGUAGE="hu_HU"), praise("You rock!")),
    "Király vagy!"
  )
})

test_that("built-in praise translations and templating", {

  ## We restore the random seed
  seed <- .GlobalEnv$.Random.seed
  on.exit(assign(".Random.seed", seed, envir = .GlobalEnv))
  set.seed(42)

  expect_equal(
    withr::with_envvar(
      c(LANGUAGE="hu_HU"),
      praise("${EXCLAMATION} - ${adjective} code.")),
    "OHÓ - szép kód."
  )
})
