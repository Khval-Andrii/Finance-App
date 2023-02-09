class Operation < ApplicationRecord
  belongs_to :category

  validates :amount, numericality: true
  validates :odate, presence: true
  validates :description, presence: true
  validates :types, numericality: { only_integer: true, in: 1..2 }
  paginates_per 3
end 