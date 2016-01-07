class Song < ActiveRecord::Base
  belongs_to :lists
  acts_as_commentable
  acts_as_votable
  default_scope {order('songs.position')}

end
