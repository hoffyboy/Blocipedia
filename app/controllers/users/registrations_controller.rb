class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # protected
  # def after_inactive_sign_up_path_for(resource)
  #   # scope = Devise::Mapping.find_scope!(resource)
  #   # router_name = Devise.mappings[scope].router_name
  #   # context = router_name ? send(router_name) : self
  #   # context.respond_to?(:root_path) ? context.root_path : "/"
  #   charges_path
  # end
  # def after_sign_up_path_for(resource)
  #   # stored_location_for(resource) ||
  #   #   if resource.is_a?(User) && resource.can_publish?
  #   #     publisher_url
  #   #   else
  #   #     super(resource)
  #   #   end
  #   wikis_path
  # end
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :role])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    # raise current_user.inspect
    puts current_user.inspect

    current_user.role == 'upgrade_to_premium' ? new_charge_path : about_path
  end

  def downgrade_user
    current_user.role = 'standard'
    # current_user.save

    if current_user.save
      flash[:notice] = "You have successfully downgraded your membership to standard. You will not be billed anymore."
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error changing your membership. Please try again."
      render :edit
    end

  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
