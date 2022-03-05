devtools::install_github("r-lib/pak@1311b92dfcb35c6596070cb80211179dcb7d1a5d")

dir.create("lckfile", showWarnings = FALSE)
Sys.setenv("PKGCACHE_HTTP_VERSION" = "2")

pak::lockfile_create(
    c(
        "any::data.table",
        "any::fs",
        "any::usethis",
        "any::here",
        "any::sessioninfo",
        "github::ropensci-review-tools/pkgcheck",
        "github::assignUser/octolog"
    ),
    lockfile = "lckfile/pkg.lock",
    dependencies = "all"
)

pak::lockfile_install("lckfile/pkg.lock")

if (packageVersion("sessioninfo") >= "1.2.1") {
    sessioninfo::session_info(pkgs = "installed", include_base = TRUE)
} else {
    options(width = 200)
    sessioninfo::session_info(
        rownames(installed.packages()),
        include_base = TRUE
    )
}
