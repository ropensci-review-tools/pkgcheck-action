library(pkgcheck)
library(magrittr)

pak::pak_update()

cat("::group::Install dependencies\n\n")
file_dir <- fs::dir_create(".pkgcheck")
Sys.setenv("PKGCACHE_HTTP_VERSION" = "2")
pak::lockfile_create(
    "local::.",
    lockfile = ".pkgcheck/pkg.lock",
    dependencies = "all"
)
pak::lockfile_install(".pkgcheck/pkg.lock")
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
    fs::file_copy(check$info$network_file, file_dir),
    "\n"
) %>% cat()

md <- checks_to_markdown(check)
writeLines(md, fs::path(file_dir, "pkgcheck-results.md"))
file <- render_markdown(md, FALSE) %>% fs::file_copy(file_dir)

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

# Set Exitstatus so Github action fails
if (length(errors) > 0) q("no", status = 1)
