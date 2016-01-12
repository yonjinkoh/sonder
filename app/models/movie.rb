class Movie < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  belongs_to :lists
  # validates :name, :picture,  presence: true
  acts_as_commentable
  acts_as_votable
  default_scope {order('movies.position')}

end
