class ProfileController < ApplicationController
  before_action :authenticate_user!

  def april
    # @april = Tmdb::Movie.find("batman")
    # @search = Tmdb::Search.new
    # @search.resource('person')
    # @query = @search.query('adele')
    # @result = @search.fetch
    @thekey = "41955a0f09fdcad5028264d83e9c9af6"
  end


  def diane
  end

  def new
  end

  def search
  end

  def show
    params[:user_id] ? @user = User.find(params[:user_id]) : @user = current_user
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
  end

  def edit
    current_user == params[:user_id] ? @user = current_user : @user = User.find(params[:user_id])
    @lists = current_user.lists
    @movielist = @lists.where(name:"Movies").first
    @movies = @movielist.movies.sort
    @booklist = @lists.where(name:"Books").first
    @books = @booklist.books.sort
    @quotelist = @lists.where(name:"Quotes").first
    @quotes = @quotelist.quotes.sort
    @songlist = @lists.where(name:"Songs").first
    @songs = @songlist.songs.sort
  end




end
