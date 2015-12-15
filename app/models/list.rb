class List < ActiveRecord::Base
has_one :category
has_many :movies, through :category
has_many :books, through :category
has_many :songs, through :category
end
