#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bundler/setup"
require "amqp"

AMQP.start('amqp://guest:guest@localhost:35672') do |connection, open_ok|
    channel = AMQP::Channel.new(connection)
    exchange = channel.topic('xanview', :durable => true, :auto_delete => false)
    EventMachine.add_periodic_timer(0.1) do
      puts "publishing msg"
      exchange.publish("this is a test message", :routing_key => "some.topic" )
    end
end
