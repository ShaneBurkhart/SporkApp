class AddDeadlineToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :deadline, :integer
  end
end
