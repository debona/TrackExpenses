class Category < ActiveRecord::Base

  scope :without_unsorted, -> { where('id != ?', Category::UNSORTED_ID) }

  has_many :expenses

  UNSORTED_ID = 1

  def self.unsorted
    self.find(UNSORTED_ID)
  end

end
