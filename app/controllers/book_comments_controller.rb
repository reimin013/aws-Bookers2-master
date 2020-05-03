class BookCommentsController < ApplicationController
  def create
  	book = Book.find(params[:book_id])
  	comment = current_user.book_comments.new(book_comment_params)
  	comment.book_id = book.id
  	comment.save
  	redirect_back(fallback_location: books_url)
  end

  def destroy
  	# bookの情報を取得
  	book = Book.find(params[:book_id])
  	# その投稿内の削除対象のコメントを探して取得
  	comment = current_user.book_comments.find_by(book_id: book.id)
  	# comment.user_id = current_user.id
  	# comment.book_id = book.id
  	comment.destroy
  	redirect_back(fallback_location: books_url)
  end

private
def book_comment_params
  params.require(:book_comment).permit(:comment, :book_id, :user_id)
end

end
