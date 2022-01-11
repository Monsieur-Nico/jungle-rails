class UserController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/', notice: 'Thank you for signing up!'
    else
      render '/signup'
    end
  end

end

private

def user_params
  params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
end