class AddTypesToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :types, :integer
  end
end
