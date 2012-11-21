class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      #Flashes a message welcoming the new user
      flash[:success] = "Welcome to the Sample App!"
      # Afterwards, it redirects the user to its respective profile page
      redirect_to @user
    else
      #After the new view is rendered, the errors will be displayed in the error_messages partial
      render 'new'
    end
  end

end