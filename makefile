CC=nim
PROGRAM=battery_notifierd
OUTDIR=bin

build:
	$(CC) c --outdir:$(OUTDIR) $(PROGRAM)

run:
	$(CC) c --outdir:$(OUTDIR) -r $(PROGRAM)
