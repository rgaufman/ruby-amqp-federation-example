#!/bin/sh
echo ${PWD}
export RABBITMQ_BASE=${PWD}/node2
export RABBITMQ_CONFIG_FILE=${PWD}/node2/rabbitmq
export RABBITMQ_PLUGINS_EXPAND_DIR=${PWD}/node2/plugins
export RABBITMQ_ENABLED_PLUGINS_FILE=${PWD}/node2/enabled_plugins
export RABBITMQ_MNESIA_DIR=${PWD}/node2/mnesia
export RABBITMQ_LOG_BASE=${PWD}/node2/logs
export RABBITMQ_NODENAME=europe1
/usr/lib/rabbitmq/bin/rabbitmq-plugins enable mochiweb
/usr/sbin/rabbitmq-server
