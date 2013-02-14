class Host < ActiveRecord::Base
  has_many :rooms, :dependent => :destroy
  
  attr_accessible :address, :name
end
