class Category < ActiveRecord::Base
  has_and_belongs_to_many :lists
  validates :name,  presence: true
end
