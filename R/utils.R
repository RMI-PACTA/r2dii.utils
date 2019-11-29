warn_if_not_dir_exists <- function(x) {
  if (!fs::dir_exists(x)) {
    warn(
      glue(
        "The output path doesn't exist:
        {ui_path(x)}
        Do you need to create it?"
      )
    )
  }

  invisible(x)
}
