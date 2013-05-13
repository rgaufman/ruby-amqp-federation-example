ruby-amqp-federation-example
============================

Example of using RabbitMQ's Federation Plugin with Ruby-AMQP

# Step 1 - Start RabbitMQ Nodes (in 2 separate terminals)

```
bash start-node1.sh
bash start-node2.sh
```

 * Node 1 runs on port: 25672, management interface: 55555
 * Node 2 runs on port: 35672, management interface: 55556

# Step 2 - Prepare environment and create federations

```
bundle install
bash cleanup.sh
bash create-federations.sh
```

# Step 3 - Start the Consumer/Producer

From separate terminals, run:

```
ruby consumer_from_node1.rb
ruby consumer_from_node2.rb
```

Then try producing messages to either node, both will receive the messages:

```
ruby producer_to_node2.rb
```