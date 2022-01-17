FROM mpadge/pkgcheck

COPY check.R /check.R
COPY install.R /install.R

#RUN ["Rscript", "/install.R"]

ENTRYPOINT [ "Rscript", "/check.R" ]