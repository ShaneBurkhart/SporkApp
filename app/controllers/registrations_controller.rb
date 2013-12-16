class RegistrationsController < Devise::RegistrationsController

  def new
    @plan = Role.find_by_name "basic"
    super
  end

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
