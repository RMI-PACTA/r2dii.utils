# r2dii.utils 0.0.0.9003

* `check_crucial_names()` gains class "missing_names".
* `check_crucial_names()` now errors with message giving (only) missing names.

# r2dii.utils 0.0.0.9002

* New article on Handling unclean data.
* New family of functions to write code for data with unclean names: `unclean_column_names()`, `clean_column_names()`, `clean_quo()`, and the helper `quo_chr()` to convert quosure expressions to strings (#12, #14).

# r2dii.utils 0.0.0.9001

* New `find_dropbox_2dii()` finds existing paths in 2dii's Dropbox folder (#1 @cjyetman).
* New option `r2dii_dropbox` allows setup for a custom 2dii Dropbox folder (#1 @cjyetman).
* New `path_examples()` and `path_example()` helps create paths to any package.
* New helpers to get parameters from the configuration file (#9 @Clare2D):
    * `allowable_asset_list()`
    * `inc_metaportfolio()`
    * `inc_project_metaportfolio()`
    * `inc_metaportfolio()`
    * `inc_project_metaportfolio()`
* `DATAPREP.TIMESTAMP()` errors if the relevant parameter is `NULL` (#8 @Clare2D).
* New `create_config()` helps create configuration files for examples and tests.
* Deprecate `DROPBOX.PATH()`.
* New `path_dropbox_2dii()` improves `DROPBOX.PATH()` with better name and documentation (#2 @cjyetman @pranavpandya84).
* New functions to handle paths, to handle the configuration file, and miscellaneous.
* Added a `NEWS.md` file to track changes to the package.
