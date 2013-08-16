class Category < ActiveRecord::Base


  has_many :expenses

  UNSORTED_ID = 1
  def self.unsorted
    self.find(UNSORTED_ID)
  end

end
