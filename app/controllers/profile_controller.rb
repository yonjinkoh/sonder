class ProfileController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :explore]
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

  def new
  end

  def search
  end

  def explore
    @profiles = User.where.not(first_name: "")

  end

  def show
    if params[:username]
      @user = User.find_by(username: params[:username])
    elsif params[:user_id]
       @user = User.find(params[:user_id])
    elsif current_user
      @user = current_user
    else redirect_to new_user_session_path
    end

    if @user
      @lists = @user.lists
      # below: filters out empty items
      @movielist = @lists.where(name:"Movies").first
      @movies = @movielist.movies.where.not(name: "").sort
      @booklist = @lists.where(name:"Books").first
      @books = @booklist.books.where.not(name: "").sort
      @quotelist = @lists.where(name:"Quotes").first
      @quotes = @quotelist.quotes.where.not(content: "").sort
      @songlist = @lists.where(name:"Songs").first
      @songs = @songlist.songs.where.not(name: "").sort
      if @lists.where(name:"Products").first
        @productlist = @lists.where(name: "Products").first
        @products = @productlist.products.where.not(name:"").sort
      end
    end
  end

  def edit
    current_user.id.to_s == params[:user_id] ? @user = current_user : nil
    @lists = current_user.lists
    @movielist = @lists.where(name:"Movies").first
    @movies = @movielist.movies.sort
    @booklist = @lists.where(name:"Books").first
    @books = @booklist.books.sort
    @quotelist = @lists.where(name:"Quotes").first
    @quotes = @quotelist.quotes.sort
    @songlist = @lists.where(name:"Songs").first
    @songs = @songlist.songs.sort
    if @lists.where(name:"Products").first
      @productlist = @lists.where(name: "Products").first
      @products = @productlist.products.sort
    end
  end

  private

    def set_s3_direct_post
     @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end


end
