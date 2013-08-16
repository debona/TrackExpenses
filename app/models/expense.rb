class Expense < ActiveRecord::Base

  default_scope -> { order(:operation_date) }
  scope :between, -> (min, max) { where("operation_date >= ? AND operation_date <= ?", min, max) }

  belongs_to :bank
  belongs_to :category

  validates :title,          presence: true
  validates :title,          uniqueness: { :scope => [:operation_date, :value] }
  validates :operation_date, presence: true
  validates :value,          presence: true # TODO numericality: {greater_than: 0, less_than: 10}
  validates :category_id,    presence: true

  after_initialize :init

  def init
    self.category_id = Category.unsorted.id unless self.category_id && self.category_id != 0
  end

end
