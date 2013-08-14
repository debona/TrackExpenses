class Expense < ActiveRecord::Base

  belongs_to :bank
  belongs_to :category

  validates :title,          :presence => true
  validates :operation_date, :presence => true
  validates :value,          :presence => true

end
