class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)

  
  def index
    @users = User.all
  end
  
  def show
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}を削除しました。"
    redirect_to users_url
  end
  
  private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
