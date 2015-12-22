class Category < ActiveRecord::Base
  has_and_belongs_to_many :lists
  has_many :movies
  accepts_nested_attributes_for :movies
  validates :name,  presence: true
end
