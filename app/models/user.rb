class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # def email_required?
  # 	false
  # end

  # def email_changed?
  # 	false
  # end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy


  validates :name, presence: true, length: {minimum: 2, maximum: 20}
  validates :email, presence: true, uniqueness: true
  validates :introduction, length: {maximum: 50}
end
