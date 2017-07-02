class UsersController < ApplicationController
  before_action :set_user,          only: [:edit, :show, :update]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page],per_page: 5 )
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to my blog #{@user.name}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Succesfull change #{@user.name} settings"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = "You can edit only your profile"
      redirect_to root_path
    end
  end
end
