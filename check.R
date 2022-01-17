library(pkgcheck)
library(magrittr)
cat("::group::Install dependencies\n\n")
dir.create(".github", showWarnings = FALSE)
Sys.setenv("PKGCACHE_HTTP_VERSION" = "2")
pak::lockfile_create(
    "local::.",
    lockfile = ".github/pkg.lock",
    dependencies = "all"
)
pak::lockfile_install(".github/pkg.lock")
if (packageVersion("sessioninfo") >= "1.2.1") {
    sessioninfo::session_info(pkgs = "installed", include_base = TRUE)
} else {
    options(width = 200)
    sessioninfo::session_info(rownames(installed.packages()), include_base = TRUE)
}
c("::endgroup::\n")

cat("::group::Running pkgcheck\n")
pkgstats::ctags_install(sudo = TRUE)

check <- pkgcheck()
paste0(
    "::set-output name=visnet_path::",
    check$info$network_file,
    "\n"
) %>% cat()

md <- checks_to_markdown(check)
writeLines(md, "pkgcheck-results.md")
tmp_file <- render_markdown(md, FALSE)
file <- basename(tmp_file)
file.copy(tmp_file, file)

paste0(
    "::set-output name=results::",
    file,
    "\n"
) %>% cat()
cat("::endgroup::\n")

errors <- grep(":heavy_multiplication_x:", md) %>%
    `[`(md, .) %>%
    gsub("- :heavy_multiplication_x:", "::error ::", .) %>%
    paste0("\n")

for (error in errors) {
    cat(error)
}

cat("::group::Check Results\n")
print(check)
cat("::endgroup::\n")
