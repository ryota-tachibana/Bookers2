class BooksController < ApplicationController
before_action :authenticate_user!
before_action :ensure_current_user, {only: [:edit,:update,:destroy]}

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @user = current_user
    @books = Book.all
  	@book = Book.find(params[:id])
  end

  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       redirect_to @book, notice: "You have created book successfully"
    else
    @books = Book.all
    flash.now[:alert] = "error."
    render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to @book, notice: "Book was successfully update."
    else
    flash.now[:alert] = "error."
    render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
    redirect_to @book, notice: "Book was successfully destroyed."
    end
  end

 private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

     def  ensure_current_user
      @book = Book.find(params[:id])
     if @book.user_id != current_user.id
        redirect_to books_path
     end
   end
end
