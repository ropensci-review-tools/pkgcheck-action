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
cat(
    "::set-output name=visnet_path::",
    fs::file_copy(check$info$network_file, file_dir),
    "\n"
)

md <- checks_to_markdown(check)
s_break <- md %>%
    grep("---", .) %>%
    .[[1]]

writeLines(md[1:(s_break - 1)], "summary.md")
cat("::set-output name=summary_md::", fs::file_copy("summary.md", file_dir), "\n")

writeLines(md, "full.md")
cat("::set-output name=full_md::", fs::file_copy("full.md", file_dir), "\n")


file <- render_markdown(md, FALSE) %>% fs::file_copy(file_dir)

cat(
    "::set-output name=results::",
    file,
    "\n"
)
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

as.numeric(length(errors) > 0) %>%
    cat("::set-output name=status::", ., "\n")
