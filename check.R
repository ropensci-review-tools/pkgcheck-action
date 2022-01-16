library(pkgcheck)
library(magrittr)

check <- pkgcheck()
print(check$info$network_file)
paste0("::set-output name=visnet_path::", check$info$network_file) %>% cat()

md <- checks_to_markdown(check)
writeLines(md, "pkgcheck-results.md")
rmarkdown::render("pkgcheck-results.md", quiet = TRUE)

errors <- grep(":heavy_multiplication_x:", md) %>%
    `[`(md, .) %>%
    gsub("- :heavy_multiplication_x:", "::error ::", .)

for (error in errors) {
    cat(error)
}

cat("::group::Check Results")
check
cat("::endgroup::")