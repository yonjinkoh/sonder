class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  # respond_to :js

  # GET /Lists
  # GET /Lists.json
  def index
    @lists = List.all
  end

  # GET /Lists/1
  # GET /Lists/1.json
  def show
  end

  # GET /Lists/new
  def new
    @list = List.new
  end

  # GET /Lists/1/edit
  def edit
  end

  # POST /Lists
  # POST /Lists.json
  def create
    @list = List.new(list_params)
    @movie = Movie.new

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
        format.js
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /Lists/1
  # PATCH/PUT /Lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Lists/1
  # DELETE /Lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params[:list].permit(:name)
    end
end
