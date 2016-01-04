class ProfileController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :edit, :explore]
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

  def new
  end

  def search
  end

  def explore
    @profiles = User.where.not(first_name: "")
  end

  def change_current
    @lists = current_user.lists
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
        var_name = "@number_#{ranking.to_s}"
        @items_of_ranking.sort!{|a,b|a.updated_at <=> b.updated_at}

        self.instance_variable_set(var_name, @items_of_ranking.last)

      end

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
      @sortedlists = [@currentlist, @movielist, @booklist, @quotelist, @songlist]

    end

  end

  def edit

    @rankings = [1,2,3,4,5]
    @user = User.find(params[:user_id])
    # current_user.id.to_s == params[:user_id] ? @user = current_user : nil
    @lists = current_user.lists
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
      var_name = "@number_#{ranking.to_s}"
      @items_of_ranking.sort!{|a,b|a.updated_at <=> b.updated_at}

      self.instance_variable_set(var_name, @items_of_ranking.last)
    end


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

    @sortedlists = [@currentlist, @movielist, @booklist, @quotelist, @songlist]

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
