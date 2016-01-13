class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.all
  end

  def like
    @song = Song.find(params[:id])
    if current_user.voted_for? @song
      @song.unliked_by current_user
    else
      @song.like_by current_user
    end
    respond_to do |format|
      format.js
    end
  end

  def add_to_current
    @list = List.find(params[:id])
    @song = @list.songs.new(position: params[:number], list_id: @list.id)
    @number = params[:number].to_s
    respond_to do |format|
      format.js {render "songs/add_to_current", :locals => {:song => @song, :number => @number}}
    end
  end


  def comment
    @song = Song.find(params[:id])
    @comment = @song.root_comments.new
    respond_to do |format|
      format.js
    end
  end

  def add_comment
    @song = Song.find(params[:id])
    @comment = Comment.build_from(@song, current_user.id, params[:body])
    @comment.save
    respond_to do |format|
      format.js{render "add_comment", :locals => {:song => @song}}
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  def add
    @user = current_user
    @song = Song.find(params[:id])
    render :layout => false
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to edit_user_profile_index_path(List.find(@song.list_id).user) }
        format.json { render :show, status: :created, location: @song }
        format.js {redirect_to :back }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update

    @song = Song.find(params[:id])
    @song.assign_attributes(book_params)

    if @song.changed?
      respond_to do |format|
        if @song.update(song_params)
          format.html { redirect_to edit_user_profile_index_path(List.find(@song.list_id).user) }
          format.json { render :show, status: :ok, location: @song }
        else
          format.html { render :edit }
          format.json { render json: @song.errors, status: :unprocessable_entity }
        end
      end
    else
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:comment, :name, :position, :link, :artist, :album, :picture, :list_id)
    end
end
