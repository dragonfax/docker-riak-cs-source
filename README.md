
Build riak-cs from source, in a docker container, for development purposees.


### Create the image

  make build 

### Build and run Riak CS from source

  make run

### Develop Riak CS

Look at the `make dev` target in the makefile.
You can use that but to save your changes between runs you should
mount your own volume into the container with -v
and then untar the tarball to start with

  mkdir my-source
  docker run -it -v my-source:/app dragonfax/riak-cs-source bash

and the within the docker continer

  cd /app
  tar xzvpf /riak-cs-source.tgz

This will put a precompiled version of the sources in your local directory,
and you can just start developing away.
