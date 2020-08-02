PROGRAM_NAME=cudaProgram

all: build run

build: 
	nvcc $(PROGRAM_NAME).cu -o $(PROGRAM_NAME)

run: build
	./$(PROGRAM_NAME)

clean:
	rm $(PROGRAM_NAME)
