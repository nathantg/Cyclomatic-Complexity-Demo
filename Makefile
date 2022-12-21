CC=gcc

cyclomake: main.c
	$(CC) -o cyclomake main.c -I.

.PHONY: clean

clean:
	rm cyclomake