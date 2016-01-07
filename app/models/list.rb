class List < ActiveRecord::Base
has_one :category, dependent: :destroy
has_many :movies, dependent: :destroy
has_many :quotes, dependent: :destroy
has_many :books, dependent: :destroy
has_many :songs, dependent: :destroy
has_many :shows, dependent: :destroy
has_many :products, dependent: :destroy
has_many :places, dependent: :destroy
belongs_to :user
default_scope {order('lists.position')}
accepts_nested_attributes_for :movies, :books, :quotes, :shows, :songs, :places, :products

end
