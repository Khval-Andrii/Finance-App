class RemoveShortFromCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :short, :text
  end
end
