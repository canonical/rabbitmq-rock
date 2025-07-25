#!/bin/sh

# This is a script follows the RabbitMQ's official Dockerfile
# https://github.com/rabbitmq/rabbitmq-server/blob/7cf076673b244cf4ee009c5691c801f60c43f99b/packaging/docker-image/Dockerfile#L65

set -e

# Paths to config files
CONF_DIR="/etc/rabbitmq/conf.d"
DEFAULTS_CONF="$CONF_DIR/10-defaults.conf"
METRICS_CONF="$CONF_DIR/20-management_agent.disable_metrics_collector.conf"

# Function to write a file if it does not exist
write_file_if_not_exists() {
    local file=$1
    local content=$2

    if [ -e "$file" ]; then
        echo "Error: $file already exists. Operation aborted."
        exit 1
    else
        echo "$content" > "$file"
        echo "Created $file"
    fi
}

# Content for 10-defaults.conf
DEFAULTS_CONTENT="\
## DEFAULT SETTINGS ARE NOT MEANT TO BE TAKEN STRAIGHT INTO PRODUCTION
## see https://www.rabbitmq.com/configure.html for further information
## on configuring RabbitMQ

## allow access to the guest user from anywhere on the network
## https://www.rabbitmq.com/access-control.html#loopback-users
## https://www.rabbitmq.com/production-checklist.html#users
loopback_users.guest = false

## Send all logs to stdout/TTY. Necessary to see logs when running via
## a container
log.console = true
"

# Content for 20-management_agent.disable_metrics_collector.conf
METRICS_CONTENT="\
# Enable Prometheus-style metrics by default (https://github.com/docker-library/rabbitmq/issues/419)
management_agent.disable_metrics_collector = true
"

# Write files only if they don't exist
write_file_if_not_exists "$DEFAULTS_CONF" "$DEFAULTS_CONTENT"
write_file_if_not_exists "$METRICS_CONF" "$METRICS_CONTENT"

chown -R _daemon_:_daemon_ /etc/rabbitmq/conf.d
