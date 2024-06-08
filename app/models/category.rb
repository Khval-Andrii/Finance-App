# FrozenStringLiteral
class Category < ApplicationRecord
  has_many :operations, dependent: :destroy
  belongs_to :user

  enum types: { expense: 1, income: 2 }

  validates :name, presence: true, uniqueness: { scope: :user_id, message: 'This category has already exist.' }
  validates :description, presence: true
  validates :user_id, presence: true
  validates :types, inclusion: { in: types.keys }

  paginates_per 4

  def self.categories_of_user(user)
    Category.where(user_id: user).order(:name)
  end

  def self.categories_types
    Category.types.keys.map { |type| [type.humanize, type] }
  end
end
