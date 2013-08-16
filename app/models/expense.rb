class Expense < ActiveRecord::Base

  belongs_to :bank
  belongs_to :category

  validates :title,          :presence => true
  validates :operation_date, :presence => true
  validates :value,          :presence => true # TODO :numericality => {:greater_than => 0, :less_than => 10}
  validates :category_id,    :presence => true

  after_initialize :init

  def init
    self.category_id = Category.unsorted.id unless self.category_id && self.category_id != 0
  end

  # TODO: prevent duplicates
  # validates :zipcode, :uniqueness => {:scope => :recorded_at}
  # validates_uniqueness_of :teacher_id, :scope => [:semester_id, :class_id]

end
