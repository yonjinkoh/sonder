class Show < ActiveRecord::Base
  belongs_to :lists
  acts_as_commentable
  acts_as_votable
  default_scope {order('shows.position')}

end
