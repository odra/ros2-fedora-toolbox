# ROS2 Fedora Toolbox

Fedora toolbox container image.

## Building

A Makefile is provided for convenience, you can run `make build` using the following parameters:

```sh
make build REG=quay.io ORG=lrossett NAME=fedora-toolbox-ros2 TAG=f37-rolling
```

You can also set the image name directly:

```sh
make build IMAGE=quay.io/lrossett/edora-toolbox-ros2:f37-rolling
```

## Testing

Create a new container and run the talker demo:

```sh
podman run -it quay.io/lrossett/edora-toolbox-ros2:f37-rolling /bin/bash
$ . ~/ros2_foxy/install/local_setup.bash
$ ros2 run demo_nodes_cpp talker
```

Open a new terminal tab and run the listener demo app in the same container:

```sh
podman exec -it $container_id /bin/bash
$ . ~/ros2_foxy/install/local_setup.bash
$ ros2 run demo_nodes_py listener
```

## Usage

### Standard Container

You can use this linux image as a simple container:

```
podman run quay.io/lrossett/fedora-toolbox-ros2:f37-rolling /bin/bash 
```

### Toolbox

Create a toolbox by running:

```sh
toolbox create --image quay.io/lrossett/fedora-toolbox-ros2:f37-rolling f37-ros2-rolling
```

Run the following command to enter into the toolbox container:

```sh
toolbox enter f37-ros2-rolling
```

Sometimes the container might be created but not running but you can just start it as any created container in such cases

```sh
podman start f37-ros2-rolling
```

You can then proceed  by using the `toolbox enter..." command.

## License

[MIT](./LICENSE)
