#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bundler/setup"
require "amqp"

i=0
routing_key = "xanview.node1"

EventMachine.run do
  AMQP.connect('amqp://guest:guest@localhost:35672') do |connection, open_ok|
    channel  = AMQP::Channel.new(connection)
    queue = channel.queue("xanview.node2.from", durable: true)

    exchange = channel.topic("xanview", durable: true)
    queue.bind(exchange, routing_key: '#')

    #EventMachine.add_periodic_timer(0.001) do
    #  i+=1
    #  puts "#{i}: publishing msg"
    #  exchange.publish("test message from node2", routing_key: routing_key, persistent: true)
    #end

    (1..1000).each do
      exchange.publish("test message from node2", routing_key: routing_key, persistent: true)
    end

  end
end