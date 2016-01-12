class Show < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  belongs_to :lists
  acts_as_commentable
  acts_as_votable
  default_scope {order('shows.position')}

end
