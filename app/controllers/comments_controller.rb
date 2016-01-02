class CommentsController < ApplicationController
before_action :set_comment

  def new
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  def index
  end

private
def set_comment
  @comment = Comment.find(params[:id])
end

end
