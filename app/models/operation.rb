class Operation < ApplicationRecord
  belongs_to :category

  validates :amount, numericality: true
  validates :odate, presence: true
  validates :description, presence: true
  validates :types, numericality: { only_integer: true, in: 1..2 }
  paginates_per 3

  def self.model_report_by_category(start_date, end_date)
    Operation
      .joins(:category)
      .where('odate BETWEEN ? AND ?', start_date, end_date)
      .group('categories.name')
      .sum(:amount)
  end

  def self.model_report_by_dates(start_date, end_date)
    Operation
      .where('odate BETWEEN ? AND ?', start_date, end_date)
      .group(:odate)
      .sum(:amount)
  end
end 