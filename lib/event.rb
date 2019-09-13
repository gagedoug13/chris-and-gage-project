class Event < ActiveRecord::Base
    has_many :schedules
    has_many :guests, through: :schedules
end