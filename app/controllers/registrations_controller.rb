class RegistrationsController < Devise::RegistrationsController

    private
  
    def sign_up_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :picture, :picture_cache, :remove_picture)
    end
  
    def account_update_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :picture, :picture_cache, :remove_picture)
    end
  end