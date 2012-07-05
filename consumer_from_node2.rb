#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bundler/setup"
require "amqp"

i=0
AMQP.start('amqp://guest:guest@localhost:35672') do |connection, open_ok|
  channel  = AMQP::Channel.new(connection)
  exchange = AMQP::Exchange.new(channel, "x-federation", "xanview", :durable => true,
    :arguments => {"upstream-set" => "my-upstreams", "type" => "topic", "durable" => "true"})
  channel.queue("testqueue2", :durable => true) do |queue|
    queue.bind(exchange, :routing_key => '#')
    queue.subscribe do |metadata, payload|
      i+=1
      puts "#{i}: Recieved message: #{payload.inspect}."
    end
  end
end
