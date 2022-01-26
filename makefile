LFILE = R/insert-inputs

all: insert

insert: $(LFILE).R
	Rscript $(LFILE).R
