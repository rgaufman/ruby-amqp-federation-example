#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bundler/setup"
require "amqp"

AMQP.start('amqp://guest:guest@localhost:35672', :heartbeat => 0) do |connection, open_ok|
  channel  = AMQP::Channel.new(connection)
  #exchange = channel.topic('xanview', :durable => true)
  exchange = AMQP::Exchange.new(channel, "x-federation", "xanview", :durable => true, :arguments => {"upstream-set" => "my-upstreams", "type" => "topic", "durable" => "true"})
  channel.queue("", :durable => true) do |queue|
    queue.bind('xanview', :routing_key => '#')
    queue.subscribe do |metadata, payload|
      puts "Recieved message: #{payload.inspect}."
    end
  end
end
