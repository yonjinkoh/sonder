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

  def new
    current_user ? @user = current_user : @user = User.new
    @movielist = current_user.lists.new(category_id: '2')
    5.times do
      movie = @movielist.movies.build
    end

    @booklist = current_user.lists.new(category_id: '1')
    5.times do
      book = @booklist.books.build
    end

    @quotelist = current_user.lists.new(category_id: '3')
    @songlist = current_user.lists.new(category_id: '4')

    @lists = Category.all
    # @movie = @movielist.movies.new
  end


end
