class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.followees(User), owner_type: "User")
  end
end
