class AddTypesToOperations < ActiveRecord::Migration[7.0]
  def change
    add_column :operations, :types, :integer
  end
end
