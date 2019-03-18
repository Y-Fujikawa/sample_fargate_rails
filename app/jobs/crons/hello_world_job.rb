module Crons
  class HelloWorldJob < ApplicationJob
    queue_as :default

    def perform(*args)
      puts "Hello Job!!"
    end
  end
end
