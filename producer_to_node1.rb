#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bundler/setup"
require "amqp"

AMQP.start('amqp://guest:guest@localhost:25672', :heartbeat => 1) do |connection, open_ok|
    channel = AMQP::Channel.new(connection)
    #exchange = channel.topic('xanview', :durable => true, :auto_delete => false)
    exchange = AMQP::Exchange.new(channel, "x-federation", "xanview", :durable => true, :arguments => {"upstream-set" => "my-upstreams", "type" => "topic", "durable" => "true"})
    EventMachine.add_periodic_timer(1) do
      puts "publishing msg"
      exchange.publish("this is a test message", :routing_key => "some.topic" )
    end
end
