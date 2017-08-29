# zeus-docker
dockerfile for building a zeus container

# build
`docker build -t <image-name> --build-arg ZEUS_TAR=<zeus-tar> .`

# run
`docker run -d --name <container-name> <image-name>`

# note
when running on mac, you will want to include opening the ports via the -p param
