class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:index]
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]
  skip_before_action :verify_authenticity_token
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
  #
  # # GET /users/1
  # # GET /users/1.json
  def show
  end

  # # GET /users/new
  def new
    @user = User.new
  end
  #
  # # GET /users/1/edit
  # def edit
  # end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @user.create_default_lists
        format.html { redirect_to 'users/:id/profile_edit', notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
        format.js
      else
        format.html { render :new }
        format.js
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        if @user.verified? == true
          @user.add_product_list
        end
        format.html { redirect_to edit_user_profile_index_path(@user.id), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  #
  

  private

    def set_s3_direct_post
     @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
  #
  #   # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :email, :avatar, :verified, :password, :password_confirmation, :last_name, :username, :list_id, :description, :picture)
    end
end
