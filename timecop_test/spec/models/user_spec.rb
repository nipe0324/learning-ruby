require 'rails_helper'

RSpec.describe User, :type => :model do

  it do
    # seconds will now seem like hours
    Timecop.scale(3600) do
      puts Time.zone.now
      # => 2012-09-20 21:23:25 -0500
      sleep 5
      # seconds later, hours have past it's gone from 9pm at night to 6am in the morning
      puts Time.zone.now
      # => 2012-09-21 06:22:59 -0500
      sleep 5
      # seconds later, hours have past it's gone from 9pm at night to 6am in the morning
      puts Time.zone.now
    end

    sleep 5

    puts Time.zone.now
  end
end
