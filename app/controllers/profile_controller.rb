class ProfileController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :edit, :explore]
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

  def new


  end

  def add_on_mobile
    @user = User.find(params[:id])
    @list_id = params[:list_id]
    @ranking = params[:ranking]
    if params[:class] == "Movie"
      @movie = Movie.new(list_id: @list_id, position: @ranking)
      respond_to do |format|
        format.html {render "movies/add", :layout => false}
        format.js{render "movies/add"}
      end
    elsif  params[:class] == "Song"
      @song = Song.new(list_id: @list_id, position: @ranking)
      respond_to do |format|
        format.html {render "songs/add", :layout => false}
        format.js{render "songs/add"}
      end
    elsif params[:class] == "Book"
      @book = Book.new(list_id: @list_id, position: @ranking)
      respond_to do |format|
        format.html {render "books/add", :layout => false}
      end
    elsif params[:class] == "Quote"
      @quote = Quote.new(list_id: @list_id, position: @ranking)
      respond_to do |format|
        format.html {render "quotes/add", :layout => false}
        format.js
      end
    elsif params[:class] == "Show"
      @show = Show.new(list_id: @list_id, position: @ranking)
      respond_to do |format|
        format.html {render "shows/add", :layout => false}
        format.js
      end
    end
  end

  def follow
    @followed = params[:id]
    current_user.follow!(@followed)
    respond_to do |format|
      format.js
    end
  end

  def search
  end

  def explore
    @profiles = User.where.not(first_name: "").where.not(avatar: "")
    @featured = @profiles.where(featured: true)
    @topmovies = []
    @topbooks = []
    @profiles.each do |profile|
      if profile.lists.where(name: "Movies").first.movies.first.picture?
        @topmovies << profile.lists.where(name: "Movies").first.movies.first
      end
      unless profile.lists.where(name: "Books").first.books.empty?
        if profile.lists.where(name: "Books").first.books.first.picture?
          @topbooks << profile.lists.where(name: "Books").first.books.first
        end
      end
    end

    @moviestodisplay = @topmovies.take(12)
    @bookstodisplay = @topbooks.take(12)
  end

  def change_current
    @lists = current_user.lists
    @user = params[:user]
    @currentlist = @lists.where(name: "Now").first
    @ranking = params[:ranking].to_s

    respond_to do |format|
      format.js
    end
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
      @rankings = [1,2,3,4,5]
      @currentlist = @lists.where(name: "Now").first
      @currentlist_items = []

      @currentlist.movies.each do |c|
        @currentlist_items << c
      end
      @currentlist.songs.each do |c|
        @currentlist_items << c
      end
      @currentlist.quotes.each do |c|
        @currentlist_items << c
      end
      @currentlist.books.each do |c|
        @currentlist_items << c
      end
      @currentlist.shows.each do |c|
        @currentlist_items << c
      end


      @rankings.each do |ranking|
        @items_of_ranking = []
        @currentlist.movies.where(position:ranking).each do |c|
          @items_of_ranking << c
        end
        @currentlist.songs.where(position:ranking).each do |c|
          @items_of_ranking << c
        end
        @currentlist.quotes.where(position:ranking).each do |c|
          @items_of_ranking << c
        end
        @currentlist.books.where(position:ranking).each do |c|
          @items_of_ranking << c
        end
        @currentlist.shows.where(position:ranking).each do |c|
          @items_of_ranking << c
        end
        var_name = "@number_#{ranking.to_s}"
        # show the LAST updated
        @items_of_ranking.sort!{|a,b|a.updated_at <=> b.updated_at}
        self.instance_variable_set(var_name, @items_of_ranking.last)
      end

      @sortedlists = []
      unless @currentlist_items.empty?
        @sortedlists << @currentlist
      end
      # below: filters out empty items
      @movielist = @lists.where(name:"Movies").first
      @movies = @movielist.movies.sort{|a,b|a.position <=> b.position}
      unless @movies.empty?
        @sortedlists << @movielist
      end
      @booklist = @lists.where(name:"Books").first
      @books = @booklist.books.sort{|a,b|a.position <=> b.position}
      unless @books.empty?
        @sortedlists << @booklist
      end
      @quotelist = @lists.where(name:"Quotes").first
      @quotes = @quotelist.quotes.sort{|a,b|a.position <=> b.position}
      unless @quotes.empty?
        @sortedlists << @quotelist
      end
      @songlist = @lists.where(name:"Songs").first
      @songs = @songlist.songs.sort{|a,b|a.position <=> b.position}
      unless @songs.empty?
        @sortedlists << @songlist
      end
      @showlist = @lists.where(name:"TV").first
      @shows = @showlist.shows.sort{|a,b|a.position <=> b.position}
      unless @shows.empty?
        @sortedlists << @showlist
      end


      if @lists.where(name:"Products").first
        @productlist = @lists.where(name: "Products").first
        @products = @productlist.products.where.not(name:"").sort
        unless @products.empty?
          @sortedlists << @productlist
        end
      end

    end

  end

  def edit

    @rankings = [1,2,3,4,5]
    @user = User.find(params[:user_id])
    # current_user.id.to_s == params[:user_id] ? @user = current_user : nil
    @lists = @user.lists
    @currentlist = @lists.where(name: "Now").first

    @rankings.each do |ranking|
      @items_of_ranking = []
      @currentlist.movies.where(position:ranking).each do |c|
        @items_of_ranking << c
      end
      @currentlist.songs.where(position:ranking).each do |c|
        @items_of_ranking << c
      end
      @currentlist.quotes.where(position:ranking).each do |c|
        @items_of_ranking << c
      end
      @currentlist.books.where(position:ranking).each do |c|
        @items_of_ranking << c
      end
      @currentlist.shows.where(position:ranking).each do |c|
        @items_of_ranking << c
      end
      var_name = "@number_#{ranking.to_s}"
      @items_of_ranking.sort{|a,b|a.updated_at <=> b.updated_at}
      self.instance_variable_set(var_name, @items_of_ranking.last)
    end


    @movielist = @lists.where(name:"Movies").first
    @movies = @movielist.movies.sort{|a,b|a.position <=> b.position}
    @booklist = @lists.where(name:"Books").first
    @books = @booklist.books.sort{|a,b|a.position <=> b.position}
    @quotelist = @lists.where(name:"Quotes").first
    @quotes = @quotelist.quotes.sort{|a,b|a.position <=> b.position}
    @songlist = @lists.where(name:"Songs").first
    @songs = @songlist.songs.sort{|a,b|a.position <=> b.position}
    @showlist = @lists.where(name:"TV").first
    @shows = @showlist.shows.sort{|a,b|a.position <=> b.position}
    # @placelist = @lists.where(name: "Places").first
    # @places = @placelist.places.sort
    if @lists.where(name:"Products").first
      @productlist = @lists.where(name: "Products").first
      @products = @productlist.products.sort
    end

    @sortedlists = [@currentlist, @movielist, @booklist, @quotelist, @songlist, @showlist]

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

    def set_s3_direct_post
     @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end


end
