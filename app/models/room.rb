class Room < ActiveRecord::Base
  belongs_to :host
  attr_accessible :capacity
end
