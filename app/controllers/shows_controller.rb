class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]

  # GET /shows
  # GET /shows.json
  def index
    @shows = Show.all
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
  end

  def like
    @show = Show.find(params[:id])
    if current_user.voted_for? @show
      @show.unliked_by current_user
    else
      @show.like_by current_user
    end
    respond_to do |format|
      format.js
    end
  end

  def add_to_current
    @list = List.find(params[:id])
    @show = @list.shows.new(position: params[:number])
    @number = params[:number].to_s
    respond_to do |format|
      format.js{render "shows/add_to_current", :locals => {:show => @show, :number => @number}}
    end
  end

  def comment
    @show = Show.find(params[:id])
    @comment = @show.root_comments.new
    respond_to do |format|
      format.js
    end
  end

  def add_comment
    @show = Show.find(params[:id])
    @comment = Comment.build_from(@show, current_user.id, params[:body])
    @comment.save
    respond_to do |format|
      format.js{render "shows/add_comment", :locals => {:show => @show}}
    end
  end

  # GET /shows/new
  def new
    @show = Show.new
  end

  # GET /shows/1/edit
  def edit
  end

  def add
    @user = current_user
    @show = Show.find(params[:id])
    render :layout => false
  end

  # POST /shows
  # POST /shows.json
  def create
    @show = Show.new(show_params)

    respond_to do |format|
      if @show.save
        format.html {  redirect_to edit_user_profile_index_path(List.find(@show.list_id).user) }
        format.json { render :show, status: :created, location: @show }
        format.js { redirect_to :back}
      else
        format.html { render :new }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shows/1
  # PATCH/PUT /shows/1.json
  def update
    respond_to do |format|
      if @show.update(show_params)
        format.html { redirect_to edit_user_profile_index_path(List.find(@show.list_id).user)}
        format.json { render :show, status: :ok, location: @show }
      else
        format.html { render :edit }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shows/1
  # DELETE /shows/1.json
  def destroy
    @show.destroy
    respond_to do |format|
      format.html { redirect_to shows_url, notice: 'Show was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show
      @show = Show.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def show_params
      params.require(:show).permit(:position, :name, :description, :picture, :list_id)
    end
end
