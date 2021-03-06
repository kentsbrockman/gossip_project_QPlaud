class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    city = City.find_or_create_by(name: params[:city], zip_code: params[:zipcode])
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name],
       email: params[:email], description: params[:description], age: params[:age], 
       password: params[:password], password_confirmation: params[:password_confirmation],
      city: city)
      if @user.save
        flash[:notice] = "Hurray! You have successfully created your profile 😁"
        if params[:remember]
          remember(@user)
        end
        log_in(@user)
        redirect_to gossip_project_home_path
      else
      flash[:alert] = "Oh no! We cannot create your profile for the following reason(s):"
      puts @user.errors.messages
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :description, :age, :password, :password_confirmation)
  end

end
