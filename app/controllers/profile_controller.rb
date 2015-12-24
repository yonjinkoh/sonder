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

  def edit
    @thekey = "41955a0f09fdcad5028264d83e9c9af6"
  end

  def diane
  end

  def search
  end

  def show
    current_user ? @user = current_user : @user = User.new
    @lists = current_user.lists
    @movielist = @lists.where(name:"Movies").first
    @booklist = @lists.where(name:"Books").first
    @quotelist = @lists.where(name:"Quotes").first
    @quotes = @quotelist.quotes.sort
    @songlist = @lists.where(name:"Songs").first
  end

  def new
    current_user ? @user = current_user : @user = User.new
    @lists = current_user.lists
    @movielist = @lists.where(name:"Movies").first
    @booklist = @lists.where(name:"Books").first
    @quotelist = @lists.where(name:"Quotes").first
    @quotes = @quotelist.quotes.sort
    @songlist = @lists.where(name:"Songs").first
  end


end
