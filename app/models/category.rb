class Category < ActiveRecord::Base

  has_many :expenses, :order => 'operation_date DESC'

  UNSORTED_NAME = 'unsorted'

  def self.unsorted
    @@unsorted ||= self.find_by_name(UNSORTED_NAME)
  end

end
