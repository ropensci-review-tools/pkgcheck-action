FROM ghcr.io/ropensci-review-tools/pkgcheck:latest
LABEL maintainer="Maëlle Salmon <reviewtools@ropensci.org>"

ENV NOT_CRAN "true"
ENV CI "true"
ENV ROPENSCI "true"

COPY R/check.R /check.R
COPY R/install.R /install.R

RUN ["Rscript", "/install.R"]

ENTRYPOINT [ "Rscript", "/check.R" ]
