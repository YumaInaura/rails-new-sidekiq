class SampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts 'Worked!'
    puts Time.current
  end
end
