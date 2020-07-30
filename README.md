# MyCudaProgram

This is a sample program to be used with [CUDATester](https://github.com/emwjacobson/CUDATester).

This repo is an example program to be used with Azure Pipelines with a GPU enabled self-hosted agent. The `azure-pipelines.yml` gives an example of running on a Self-hosted agent pool.

## Usage
 1. Clone this repo
    
    `git clone https://github.com/emwjacobson/MyCudaProgram`
 2. Build locally or pull CUDATester from Dockerhub
    1. To build, clone [CUDATester](https://github.com/emwjacobson/CUDATester), and run `make dockerbuild`
    2. To pull, run `docker pull emwjacobson/cudatester`

 3. Run docker image, mounting current directory

    ``docker run --rm -it -v `pwd`:/app/copy emwjacobson/cudatester make``
    - `--rm` will auto-delete the container after exiting
    - `-it` will run it interactively
    - ``-v `pwd`:/app/copy`` will mount the current directory to `/app/copy` inside of the container.
    - `make` runs the default directive of the [Makefile](https://github.com/emwjacobson/CUDATester/blob/master/Makefile) inside the container.
    
    The default directive in the _container's_ Makefile will run the `run` directive of _this repo's_ Makefile. It is expected that the `run` directive will install dependencies, build, and run the program.

## Azure self-hosted agents

Azure allows for self-hosted agents for their Pipelines. This allows GPUs to be used and passed to containers for testing. See the [Azure pipelines self-hosted agents page](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/agents?view=azure-devops) for more information on Self-hosted agents.