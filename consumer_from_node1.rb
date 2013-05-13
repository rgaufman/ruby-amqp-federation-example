#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bundler/setup"
require "amqp"

i=0
AMQP.start('amqp://guest:guest@localhost:25672') do |connection, open_ok|
  channel  = AMQP::Channel.new(connection)
  exchange = channel.topic("xanview", durable: true)
  channel.queue("xanview.node1.to", :durable => true) do |queue|
    queue.bind(exchange, :routing_key => '#')
    queue.subscribe do |metadata, payload|
      i+=1
      puts "#{i}: Recieved message: #{payload.inspect}."
    end
  end
end