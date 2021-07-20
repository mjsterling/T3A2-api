class Room < ApplicationRecord
    has_many :bookings

    validates_presence_of :capacity, :offpeak_rate, :peak_rate, :number
    validates_uniqueness_of :number
end
