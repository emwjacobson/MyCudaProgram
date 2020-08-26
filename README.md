# MyCudaProgram

This is a sample program that was made to test [CUDATester](https://github.com/emwjacobson/CUDATester).

This repo is also an example program to be used with Azure Pipelines with a GPU enabled self-hosted agent. The `azure-pipelines.yml` gives an example of running on a Self-hosted agent pool.

This repo currently has 2 projects, a sample CUDA program (MySampleProgram), and a Unified Memory program by Nvidia (UnifiedMemoryStreams). These are both run as seperate jobs, and each job produces 3 output files:
- A .nvvp file - A file to be used in Nvidia Visual Profiler tool to analyze kernel calls
- 2 .txt files
    - One is a log file straight from nvprof, useful to analyze cuda API calls in the program
    - The other is the output from `check.sh` which checks to see if certain CUDA API calls are being made

## Usage
1. Clone this repo
  
    `git clone https://github.com/emwjacobson/MyCudaProgram`

2. Build locally or pull CUDATester from Dockerhub
    - To build, clone [CUDATester](https://github.com/emwjacobson/CUDATester), and run `make dockerbuild`
    - To pull, run `docker pull emwjacobson/cudatester`

3. Run docker image, mounting current directory

    ``docker run --rm -it -v $(pwd):/root emwjacobson/cudatester [command]``

    - `--rm` will auto-delete the container after exiting
    - `-it` will run it interactively
    - ``-v $(pwd):/root`` will mount the current directory to `/root` inside of the container.
    - `[command]` is the _optional_ command to run inside of the container.
      - This can be changed depending on workflow, eg to run a python file you might want to use `python3 main.py`.
      - If no command is specified, it will drop you into a bash shell

## Benchmarking

2 agent containers were setup on an Nvidia Jetson AGX Xavier. Below are the times it took to compile all of the sources repos based on which power model was currently running on it.

nvpmodel -m 1: 10 Watt, 2 cores - 39m31s
nvpmodel -m 5: 20 Watt, 4 cores - 17m29s
nvpmodel -m 3: 30 Watt, 8 cores - 12m52s
nvpmodel -m 0: Max Perf, 8 cores - 4m18s
