class Movie < ActiveRecord::Base
  belongs_to :lists
  # validates :name, :picture,  presence: true
end
