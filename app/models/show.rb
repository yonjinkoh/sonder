class Show < ActiveRecord::Base
  belongs_to :lists
  acts_as_commentable
  acts_as_votable
end
