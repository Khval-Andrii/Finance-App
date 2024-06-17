# class Operation
class Operation < ApplicationRecord
  belongs_to :category
  belongs_to :user

  enum types: { income: 1, expense: 2 }

  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :amount, numericality: true
  validates :odate, presence: true
  validates :description, presence: true
  validates :types, inclusion: { in: types.keys }

  paginates_per 3

  def self.list_of_operations(user = 0)
    Operation.where(user_id: user).order(created_at: :desc)
  end

  def self.operations_types
    Operation.types.keys.map { |type| [type.humanize, type] }
  end

  def self.model_report_by_category(user, start_date, end_date, type_operations)
    Operation
      .joins(:category)
      .where(user_id: user, odate: start_date..end_date, types: type_operations)
      .group('categories.name')
      .sum(:amount)
  end

  def self.model_report_by_dates(user, start_date, end_date, category_id)
    Operation
      .where(user_id: user, odate: start_date..end_date, category_id:)
      .group(:odate)
      .sum(:amount)
  end
end
