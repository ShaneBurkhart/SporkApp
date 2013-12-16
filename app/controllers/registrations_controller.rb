class RegistrationsController < Devise::RegistrationsController

  def new
    @plan = Role.find_by_name "basic"
    @recipe = Recipe.current_recipe
    super
  end

=begin
  def update_plan
    @user = current_user
    role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
    if @user.update_plan(role)
      redirect_to edit_user_registration_path, :notice => 'Updated plan.'
    else
      flash.alert = 'Unable to update plan.'
      render :edit
    end
  end
=end

  def update_card
    @user = current_user
    @user.stripe_token = params[:user][:stripe_token]
    if @user.save
      redirect_to edit_user_registration_path, :notice => 'Updated card.'
    else
      flash.alert = 'Unable to update card.'
      render :edit
    end
  end

  protected

    def after_update_path_for(resource)
      content_path
    end

  private

    def build_resource(*args)
      super
      if params[:plan]
        resource.add_role(params[:plan])
      end
    end

end
