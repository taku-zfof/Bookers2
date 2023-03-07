class BooksController < ApplicationController
  def index
    @books=Book.all
    @user=current_user
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id

    if@book.save
     redirect_to book_path(@book.id)
     flash[:notice] = "You have created book successfully."
    else
     @books=Book.all
     @user=current_user
     render :index
    end
  end

  def show
    @book=Book.find(params[:id])
  end

  def edit
    user_id = params[:id].to_i
        unless user_id == current_user.id
          redirect_to books_path
        end
    @book=Book.find(params[:id])
    
  end
  def update
    user_id = params[:id].to_i
        unless user_id == current_user.id
          redirect_to books_path
        end 
    @book=Book.find(params[:id])
    if@book.update(book_params)
     redirect_to book_path(@book.id)
     flash[:notice] = "You have updated book successfully."
    else
     render :edit
    end
  end
  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

   private

  def book_params
    params.require(:book).permit(:title, :body, )
  end


end
