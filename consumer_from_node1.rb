#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bundler/setup"
require "amqp"

AMQP.start('amqp://guest:guest@localhost:25672', :heartbeat => 1) do |connection, open_ok|
  channel  = AMQP::Channel.new(connection)
  #exchange = channel.topic('xanview', :durable => true)
  channel.queue("", :durable => true) do |queue|
    queue.bind('xanview', :routing_key => '#')
    queue.subscribe do |metadata, payload|
      puts "Recieved message: #{payload.inspect}."
    end
  end
end
