class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only:[:edit, :update]

  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @books = Book.all
    @book.user_id = current_user.id
    @user = current_user
    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def create
    @book= Book.new(book_params)
    @books = Book.all
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to books_path  # 投稿一覧画面へリダイレクト
    flash[:notice] = 'Book was successfully destroyed.'
  end

  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      redirect_to root_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body) #titleとbodyの内容を渡している
  end
end