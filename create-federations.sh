#!/bin/bash
set -e
rabbitmqctl -n node1 set_parameter federation-upstream my-upstream \
  '{"uri":"amqp://guest:guest@localhost:35672/%2f"}'
rabbitmqctl -n node1 set_policy federate-me "^xanview" '{"federation-upstream-set":"all"}'

rabbitmqctl -n node2 set_parameter federation-upstream my-upstream \
  '{"uri":"amqp://guest:guest@localhost:25672/%2f"}'
rabbitmqctl -n node2 set_policy federate-me "^xanview" '{"federation-upstream-set":"all"}'
