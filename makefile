LFILE = R/insert-inputs

all: contrib insert

contrib:
	Rscript -e "allcontributors::add_contributors()"

insert: $(LFILE).R
	Rscript $(LFILE).R
