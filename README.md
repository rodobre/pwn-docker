# Summary
Intended to be run on multi-arch setups on platform `linux/amd64` to provide an environment for binary exploitation.

# ARM-based environments
Docker supports multi-arch with the use of QEMU. To build this image and run it as `linux/amd64`, use the following:

```console
docker build --platform linux/amd64 -t pwn-docker .
docker run --platform linux/amd64 -t -d --name pwn-docker -v $PWD/.shared:/.shared pwn-docker
```

# Native `amd64` environments

```console
docker build -t pwn-docker .
docker run -t -d --name pwn-docker -v $PWD/.shared:/.shared pwn-docker
```
