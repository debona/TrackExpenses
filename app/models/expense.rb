class Expense < ActiveRecord::Base

  validates :title,          :presence => true
  validates :operation_date, :presence => true
  validates :value,          :presence => true

end
