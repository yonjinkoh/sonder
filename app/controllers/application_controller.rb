class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: [:secret]


  def like
    @b = params[:id]
    case params[:class]
    when "Movie"
      @thing = Movie.find(@b)
    when "Song"
      @thing = Song.find(@b)
    when "Quote"
      @thing = Quote.find(@b)
    when "Show"
      @thing = Show.find(@b)
    when "Book"
      @thing = Book.find(@b)
    end
    @thing.liked_by current_user
    respond_to do |format|
      format.js
    end
  end

  def dislike
    @b = params[:id]
    case params[:class]
    when "Movie"
      @thing = Movie.find(@b)
    when "Song"
      @thing = Song.find(@b)
    when "Quote"
      @thing = Quote.find(@b)
    when "Show"
      @thing = Show.find(@b)
    when "Book"
      @thing = Book.find(@b)
    end
    @thing.unliked_by current_user
    respond_to do |format|
      format.js
    end
  end

  def comment
    @b = params[:id]
    case params[:class]
    when "Movie"
      @thing = Movie.find(@b)
    when "Song"
      @thing = Song.find(@b)
    when "Quote"
      @thing = Quote.find(@b)
    when "Show"
      @thing = Show.find(@b)
    when "Book"
      @thing = Book.find(@b)
    end
    @comment = @thing.root_comments.new
    respond_to do |format|
      format.js
    end
  end

  def add_comment
    @b = params[:id]
    case params[:class]
    when "Movie"
      @thing = Movie.find(@b)
    when "Song"
      @thing = Song.find(@b)
    when "Quote"
      @thing = Quote.find(@b)
    when "Show"
      @thing = Show.find(@b)
    when "Book"
      @thing = Book.find(@b)
    end
    @comment = Comment.build_from(@thing, current_user.id, params[:body])
    @comment.save
    respond_to do |format|
      format.js {render "add_comment", :locals => {:thing => @thing}}
    end
  end


  def about
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :password, :email, :first_name, :last_name, :description, :picture) }
    devise_parameter_sanitizer.for(:account_update) << :name
  end

end
