r <- "README.md"

# fnn to get start and end line nums of one yaml chunk matching `ptn` on the
# first line after start of chunk:
get_line_nums <- function (ptn, x) {
    i1 <- grep ("^\\`\\`\\`yaml$", x)
    i2 <- grep (ptn, x)
    index <- which (vapply (i1, function (i)
                            any ((i2 - i) == 1L),
                            logical (1)))
    i1 <- i1 [index [1]]
    i2 <- grep ("^\\`\\`\\`$", x)
    i2 <- i2 [which (i2 > i1) [1]]
    c (i1, i2)
}

# insert contents of main workflow file from pkgcheck
pkgcheck_dir <- file.path (here::here (), "..", "pkgcheck")
pkgcheck_dir <- normalizePath (pkgcheck_dir, mustWork = FALSE)
f <- ifelse (dir.exists (pkgcheck_dir),
             file.path (pkgcheck_dir, "inst", "pkgcheck.yaml"),
             system.file ("pkgcheck.yaml", package = "pkgcheck"))

ptn <- "^name\\:\\spkgcheck$"
x <- readLines (r)
i <- get_line_nums (ptn, x)
x <- c (x [seq (i [1])],
        readLines (f),
        x [i [2]:length (x)])


# insert inputs from 'action.yaml' into README.md
inputs <- readLines ("action.yaml")
i1 <- grep ("^inputs\\:$", inputs)
i2 <- grep ("^[a-zA-Z]", inputs)
i2 <- i2 [which (i2 > i1) [1]] - 1
inputs <- inputs [i1:i2]
inputs <- inputs [which (nzchar (inputs))]

i <- get_line_nums ("^inputs\\:$", x)
x <- c (x [seq (i [1])],
        inputs,
        x [i [2]:length (x)])
writeLines (x, r)
