class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

end

# class User::RegistrationsController < Devise::RegistrationsController

#   before_filter :configure_permitted_parameters

#   protected

#   def configure_permitted_parameters
#     devise_parameter_sanitizer.for(:sign_up) do |u|
#       u.permit(:name, :email, :password, :password_confirmation)
#     end

#   end

# end