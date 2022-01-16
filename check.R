library(pkgcheck)
library(magrittr)

check <- pkgcheck()
print(check$info$network_file)
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
