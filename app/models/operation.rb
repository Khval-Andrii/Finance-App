class Operation < ApplicationRecord
  belongs_to :category

  validates :amount, numericality: true
  validates :odate, presence: true
  validates :description, presence: true
  validates :types, numericality: { only_integer: true, in: 1..2 }
  paginates_per 4

  def self.model_report_by_category(start_date, end_date, type_operations)
    Operation
      .joins(:category)
      .where('odate BETWEEN ? AND ? AND types = ?', start_date, end_date, type_operations)
      .group('categories.name')
      .sum(:amount)
  end

  def self.model_report_by_dates(start_date, end_date, category_id)
    Operation
      .where('odate BETWEEN ? AND ? AND category_id = ?', start_date, end_date, category_id)
      .group(:odate)
      .sum(:amount)
  end
end 