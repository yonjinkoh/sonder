class Book < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  belongs_to :lists
  acts_as_commentable
  acts_as_votable
end
