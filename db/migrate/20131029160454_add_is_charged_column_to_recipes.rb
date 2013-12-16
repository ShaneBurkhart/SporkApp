class AddIsChargedColumnToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :is_charged, :boolean
  end
end
