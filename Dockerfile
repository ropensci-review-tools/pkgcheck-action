FROM mpadge/pkgcheck
LABEL maintainer="Jacob Wujciak-Jens <jacob@wujciak.de>"

COPY check.R /check.R
COPY install.R /install.R

RUN ["Rscript", "/install.R"]

ENTRYPOINT [ "Rscript", "/check.R" ]