class Operation < ApplicationRecord
  belongs_to :category

  validates :amount, numericality: true
  validates :odate, presence: true
  validates :description, presence: true
  paginates_per 3
end 