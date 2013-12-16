class ContentController < ApplicationController
  before_filter :authenticate_user!

  def basic
    authorize! :view, :basic, :message => 'Access limited to subscribers.'
    # @recipe = Recipe.current_recipe
    # @comment = Comment.new(user_id: current_user.id, recipe_id: @recipe.id)
  end

end
