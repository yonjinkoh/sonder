class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end


  def add_to_current
    @list = List.find(params[:id])
    @movie = @list.movies.new(position: params[:number])
    @number = params[:number].to_s
    respond_to do |format|
      format.js{render "movies/add_to_current", :locals => {:movie => @movie, :number => @number}}
    end
  end


  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  def add
    @user = current_user
    @movie = Movie.find(params[:id])
    render :layout => false
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to edit_user_profile_index_path(List.find(@movie.list_id).user)}
        format.json { render :show, status: :created, location: @movie }
        format.js
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    @movie = Movie.find(params[:id])
    @movie.assign_attributes(movie_params)

    if @movie.changed?
      respond_to do |format|
        if @movie.update(movie_params)
          format.html { redirect_to edit_user_profile_index_path(List.find(@movie.list_id).user)}
          format.json { render :show, status: :ok, location: @movie }
        else
          format.html { render :edit }
          format.json { render json: @movie.errors, status: :unprocessable_entity }
        end
      end
    else
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:id, :list_id, :name, :position, :picture, :year, :overview)
    end
end
