# r2dii.utils 0.0.0.9000

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
