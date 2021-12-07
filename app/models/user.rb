class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :package
  has_many :rents
  has_many :ranks
  has_many :comments
  has_many :favorites
  has_many :carts
end
