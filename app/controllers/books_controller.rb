class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.new
    #新規投稿をする
    @book2 = Book.find(params[:id])
    #自分の投稿の一覧表示をする
    @user = User.find(@book2.user_id)
    #@book2のユーザーの情報を表示する,@book2.idだと本のidをとってきてしまう
  end

  def create
  	@book = Book.new(book_params)
    # 投稿データを保存するには、Strong Parameters も必要
    @book.user_id = current_user.id
  	if @book.save
  	 redirect_to book_path(@book.id), notice: "You have creatad book successfully."
    else
     @user = current_user
     @books = Book.all
     render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    if @user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
     redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
     render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
   params.require(:book).permit(:title, :body, :user_id)
  end
  # form_forを使うときは、Strong Parametersの定義が必要
end
