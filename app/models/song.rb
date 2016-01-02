class Song < ActiveRecord::Base
  belongs_to :lists
  acts_as_commentable
end
