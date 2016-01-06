class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
  end

  def like
    @quote = Quote.find(params[:id])
    if current_user.voted_for? @quote
      @quote.unliked_by current_user
    else
      @quote.like_by current_user
    end
    respond_to do |format|
      format.js
    end
  end


  def add_to_current
    @list = List.find(params[:id])
    @quote = @list.quotes.new(position: params[:number])
    @number = params[:number].to_s
    respond_to do |format|
      format.js{render "quotes/add_to_current", :locals => {:quote => @quote, :number => @number}}
    end
  end

  def comment
    @quote = Quote.find(params[:id])
    @comment = @quote.root_comments.new
    respond_to do |format|
      format.js
    end
  end

  def add_comment
    @quote = Quote.find(params[:id])
    @comment = Comment.build_from(@quote, current_user.id, params[:body])
    @comment.save
    respond_to do |format|
      format.js{render "quotes/add_comment", :locals => {:quote => @quote}}
    end
  end



  # GET /quotes/new
  def new
    @quote = Quote.new
  end


  def add
    @user = current_user
    @quote = Quote.find(params[:id])
    render :layout => false
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(quote_params)

    respond_to do |format|
      if @quote.save
        format.html { redirect_to :back }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to edit_user_profile_index_path(List.find(@quote.list_id).user) }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.require(:quote).permit(:id, :content, :position, :list_id, :source)
    end
end
