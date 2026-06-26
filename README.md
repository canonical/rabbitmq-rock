# RabbitMQ Rock

A distroless-like RabbitMQ image based on Ubuntu. 

## Chiselled image

This image was created with [Chisel](https://documentation.ubuntu.com/chisel) to reduce the content of this image to only the essentials. This creates a more compact image with a smaller overall attack surface. Details on the content of this image can be found under the `rabbitmq-server_bins` slice(s) in the [chisel-releases](https://github.com/canonical/chisel-releasesl)
repository.

## Available versions

* [RabbitMQ 3.9 (Ubuntu 22.04)](./rabbitmq/3.9-22.04/rockcraft.yaml)
* [RabbitMQ 3.12 (Ubuntu 24.04)](./rabbitmq/3.12-24.04/rockcraft.yaml)
* [RabbitMQ 4.0 (Ubuntu 26.04)](./rabbitmq/4.0-26.04/rockcraft.yaml)
