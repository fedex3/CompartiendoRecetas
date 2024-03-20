class UsersController < ApplicationController
  def show
    @user = User.find_by(id: current_user.id)
    @recipes = @user.recipes
  end

  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update 
    @user = User.find_by(id: current_user.id)
    if @user.update(user_params)
      redirect_to user_profile_path
    else
      errors = ''
      @_user.errors.messages.each do |msg|
        errors = errors + User.human_attribute_name(msg[0].to_s)  + ': ' + msg[1][0].to_s + '<br>'
      end
      render :json => {:errors => errors}, :status => 422
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :detail, :image)
    end
end


