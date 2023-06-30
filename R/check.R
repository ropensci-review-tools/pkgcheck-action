library(pkgcheck)
library(magrittr)
library(octolog)
enable_github_colors()

octo_start_group("Install dependencies")

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

# prevent rcmdcheck NOTE
usethis::use_build_ignore(".pkgcheck")

octo_end_group()

octo_start_group("Running Pkgcheck...")
pkgstats::ctags_install(sudo = TRUE)

check <- pkgcheck()
fs::file_copy(check$info$network_file, file_dir) %>%
    octo_set_output("visnet_path")

md <- checks_to_markdown(check)
s_break <- md %>%
    grep("---", .) %>%
    .[[1]]

writeLines(md[1:(s_break - 1)], "summary.md")
fs::file_copy("summary.md", file_dir) %>%
    octo_set_output("summary_md")


writeLines(md, "full.md")
fs::file_copy("full.md", file_dir) %>%
    octo_set_output("full_md")


render_md2html(md, FALSE) %>%
    fs::file_copy(file_dir) %>%
    octo_set_output("results")

octo_end_group()

errors <- md[1:s_break] %>% grep("^- :heavy_multiplication_x:", .) %>%
    `[`(md, .) %>%
    gsub("^- :heavy_multiplication_x: ", "", .)

for (error in errors) {
    octo_abort(error, .fail_fast = FALSE)
}

octo_start_group("Check Results")
print(check)
octo_end_group()

as.numeric(length(errors) > 0) %>% encode_string() %>%
    octo_set_output("status")
