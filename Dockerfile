FROM ghcr.io/ropensci-review-tools/pkgcheck:latest
LABEL maintainer="Jacob Wujciak-Jens <jacob@wujciak.de>"

COPY R/check.R /check.R
COPY R/install.R /install.R

RUN ["Rscript", "/install.R"]

ENTRYPOINT [ "Rscript", "/check.R" ]