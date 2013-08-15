class Expense < ActiveRecord::Base

  belongs_to :bank
  belongs_to :category

  validates :title,          :presence => true
  validates :operation_date, :presence => true
  validates :value,          :presence => true # TODO :numericality => {:greater_than => 0, :less_than => 10}

  # TODO: prevent duplicates
  # validates :zipcode, :uniqueness => {:scope => :recorded_at}
  # validates_uniqueness_of :teacher_id, :scope => [:semester_id, :class_id]

end
