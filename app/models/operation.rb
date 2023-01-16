class Operation < ApplicationRecord
  belongs_to :category

  validates :amount, numericality: true
  validates :odate, presence: true
  validates :description, presence: true
end 