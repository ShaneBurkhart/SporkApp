class AddRecipeMonthAndYearToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :month, :integer
    add_column :recipes, :year, :integer
  end
end
