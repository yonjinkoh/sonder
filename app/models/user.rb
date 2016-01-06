
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default("0"), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  picture                :string
#  description            :text


class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

# validates_confirmation_of    :password, :on=>:create


# mount_uploader :picture, PictureUploader, dependent: :destroy
has_many :lists, dependent: :destroy
acts_as_voter
acts_as_follower
acts_as_followable
acts_as_mentionable
#
# def to_param
#   username
# end




def add_product_list
  productlist = lists.find_or_create_by(name: "Products")
  5.times do
    product = productlist.products.build
    product.save
  end
end

def add_show_list
  showlist = lists.find_or_create_by(name: "TV")
  5.times do
    show = showlist.shows.build
    show.save
  end
end

def add_current_list
  currentlist= lists.find_or_create_by(name: "Now", position: 1)
  if lists.find_by(name:"Movies")
    lists.find_by(name:"Movies").update_attribute(:position, 2)
  end
  if lists.find_by(name:"Books")
    lists.find_by(name:"Books").update_attribute(:position, 3)
  end
  if lists.find_by(name:"Quotes")
    lists.find_by(name:"Quotes").update_attribute(:position, 4)
  end
  if lists.find_by(name: "Songs")
    lists.find_by(name:"Songs").update_attribute(:position, 5)
  end
end


def create_default_lists

  currentlist = lists.find_or_create_by(name: "Now", position: 1)

  movielist = lists.find_or_create_by(name: "Movies", category_id: "2", position: 2)
  5.times do
    movie = movielist.movies.build
    movie.save
  end

  booklist = lists.find_or_create_by(name: "Books", category_id: "1", position: 3)
  5.times do
    book = booklist.books.build
    book.save
  end


  quotelist = lists.find_or_create_by(name: "Quotes", category_id: "3", position: 4)
  5.times do
    quote = quotelist.quotes.build
    quote.save
  end


  songlist = lists.find_or_create_by(name: "Songs", category_id: "4", position: 5)
  5.times do
    song = songlist.songs.build
    song.save
  end

  showlist = lists.find_or_create_by(name: "TV", position: 5)
  5.times do
    show = showlist.shows.build
    show.save
  end


end

end
