class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  def like
    @book = Book.find(params[:id])
    @book.like_by current_user
    respond_to do |format|
      format.js
    end
  end

  def dislike
    @book.unliked_by current_user
    respond_to do |format|
      format.js
    end
  end

  def add_to_current
    @list = List.find(params[:id])
    @book = @list.books.new(position: params[:number])
    @number = params[:number].to_s
    respond_to do |format|
      format.js{render "books/add_to_current", :locals => {:book => @book, :number => @number}}
    end
  end

  def comment
    @book = Book.find(params[:id])
    @comment = @book.root_comments.new
    respond_to do |format|
      format.js
    end
  end

  def add_comment
    @book = Book.find(params[:id])
    @comment = Comment.build_from(@book, current_user.id, params[:body])
    @comment.save
    respond_to do |format|
      format.js{render "books/add_comment", :locals => {:book => @book}}
    end
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def add
    @user = current_user
    @book = Book.find(params[:id])
    render :layout => false
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to edit_user_profile_index_path(List.find(@book.list_id).user) }
        format.json { render :show, status: :created, location: @book }
        format.js
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    @book = Book.find(params[:id])
    @book.assign_attributes(book_params)

    if @book.changed?
      respond_to do |format|
        if @book.update(book_params)
          format.html { redirect_to edit_user_profile_index_path(List.find(@book.list_id).user) }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    else
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :link, :description, :picture, :position, :list_id, :author, :published)
    end
end
