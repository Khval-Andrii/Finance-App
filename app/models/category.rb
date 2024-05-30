# class Category
class Category < ApplicationRecord
  has_many :operations, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :description, presence: true

  paginates_per 4
end
