class HomeController < ApplicationController

  def index
    redirect_to content_path if current_user
    @recipe = Recipe.current_recipe
  end

end
