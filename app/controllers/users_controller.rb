class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
    #特定のユーザーの情報を表示する
  	@book = Book.new
    #新規投稿をする
  	@books = Book.where(user_id: params[:id])
    #投稿の一覧表示をする, find はとってくるデータが1つだけの時に使う
  end

  def index
    @book = Book.new
    @user = current_user
  	@users = User.all
  end

  def edit
  	@user = User.find(params[:id])
    if @user != current_user
       #redirect_to edit_user_path(@user)：これがあると無限にeditアクションを繰り返してしまう
       redirect_to user_path(current_user)
       # @book = Book.new
       # @books = Book.where(user_id: params[:id])
       # render :show
       #showページの結果として返しているだけなので、URLは変わらない
    end
  end

  def update
  	@user = User.find(params[:id])
    # userデータを保存するには、Strong Parameters も必要
    @user = current_user
  	if @user.update(user_params)
  	 redirect_to user_path(@user), notice: "You have updated user successfully."
    else
     render :edit
     # redirect_toにすると、エラーメッセージが表示されない！！
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
