class AddRestaurantNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :restaurant_name, :string
  end
end
