class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id, :recipe_id, :user_id

  belongs_to :recipe
  belongs_to :user

  validates :recipe_id, :user_id, :body, presence: true

  validate :valid_recipe

  private

    def valid_recipe
      errors.add(:recipe, "must be from this month.") unless Recipe.current_recipe.id == recipe_id
    end

end
