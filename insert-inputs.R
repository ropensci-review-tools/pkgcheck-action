# script to insert inputs from 'action.yaml' into README.md
x <- readLines ("action.yaml")
i1 <- grep ("^inputs\\:", x)
i2 <- grep ("^[a-zA-z]", x)
inputs <- x [i1:(i2 [i2 > i1])]

x <- readLines ("README.md")
i1 <- grep ("^\\`\\`\\`yaml$", x)
i2 <- grep ("^inputs\\:$", x)
i1 <- i1 [which ((i2 - i1) == 1L)]
i2 <- grep ("^\\`\\`\\`$", x)
i2 <- i2 [which (i2 > i1) [1]]

x <- c (x [seq (i1)],
        inputs,
        x [i2:length (x)])
writeLines (x, "README.md")
