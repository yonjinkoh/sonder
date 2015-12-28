class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  if Rails.env.production?
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  else
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable
  end

end
