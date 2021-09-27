class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :authenticate_user!

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @showbook = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def create
    # １. データを新規登録するためのインスタンス作成
    user = User.new(user_params)
    # ２. データをデータベースに保存するためのsaveメソッド実行
    if user.save
      redirect_to user_path(user.id)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  private

  def correct_user
     user = User.find(params[:id])
     if current_user != user
       redirect_to books_path(user.id)
     end
  end

end