class List < ActiveRecord::Base
has_one :category
has_many :movies, dependent: :destroy
has_many :books, dependent: :destroy
accepts_nested_attributes_for :movies, :books
# has_many :books, through :category
# has_many :songs, through :category
end
