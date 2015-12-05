
class ProfileController < ApplicationController



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
    @user = User.new
    @booklist = List.new(category_id: '1')
  end


end
