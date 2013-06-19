class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in @user
      redirect_to @user, notice: "Account successfully created and you're now signed in."
    else
      render action: "new"
    end
  end

  def update
    @user = User.find(params[:id])

    params[:user].delete(:password) if params[:user][:password].blank?

    if @user.update_attributes(params[:user])
      sign_in @user
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_url
  end

  private

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
end
