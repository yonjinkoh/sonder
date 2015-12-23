
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

mount_uploader :picture, PictureUploader
has_many :lists, dependent: :destroy
has_one :picture, dependent: :destroy


def create_default_lists
  movielist = lists.find_or_create_by(name: "Movies", category_id: "2")
  5.times do
    movie = movielist.movies.build
    movie.save
  end

  booklist = lists.find_or_create_by(name: "Books", category_id: "1")
  5.times do
    book = booklist.books.build
    book.save
  end


  quotelist = lists.find_or_create_by(name: "Quotes", category_id: "3")
  5.times do
    quote = quotelist.quotes.build
    quote.save
  end


  songlist = lists.find_or_create_by(name: "Songs", category_id: "4")
  5.times do
    song = songlist.songs.build
    song.save
  end

end

end
