class List < ActiveRecord::Base
has_one :category, dependent: :destroy
has_many :movies, dependent: :destroy
has_many :quotes, dependent: :destroy
has_many :books, dependent: :destroy
has_many :songs, dependent: :destroy
belongs_to :user
accepts_nested_attributes_for :movies, :books, :quotes, :songs

end
