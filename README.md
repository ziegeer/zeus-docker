# zeus-docker
`Dockerfile` for building a zeus container.

# build
`docker build -t <image-name> --build-arg ZEUS_TAR=<zeus-tar> .`

# run
`docker run -d --name <container-name> <image-name>`

# note
When running on a Mac, you will want to include opening the ports via the -p param. For example:

`docker run -d -p 9090:9090 <container-name> <image-name>`

# Login
Login is admin / zeus
