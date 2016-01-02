class Movie < ActiveRecord::Base
  belongs_to :lists
  # validates :name, :picture,  presence: true
  acts_as_commentable
  acts_as_votable
end
