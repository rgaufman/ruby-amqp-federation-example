#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bundler/setup"
require "amqp"

i=0
EventMachine.run do
  AMQP.connect('amqp://guest:guest@localhost:25672') do |connection, open_ok|
    channel = AMQP::Channel.new(connection)
    exchange = AMQP::Exchange.new(channel, "x-federation", "xanview", :durable => true, :arguments => {"upstream-set" => "my-upstreams", "type" => "topic", "durable" => "true"})

    # Publish Periodically
    EventMachine.add_periodic_timer(0.001) do
      i+=1
      puts "#{i}: publishing msg"
      exchange.publish("this is a test message to node1", :routing_key => "some.topic", :persistent => true )
    end

    # Publish 1,000 messages
    #(1..1000).each do
    #  i+=1
    #  exchange.publish("this is a test message to node1", :routing_key => "some.topic", :persistent => true )
    #end
  end
end
