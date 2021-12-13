class User < ApplicationRecord
  after_create :welcome_send
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
         
  validates :phone, length:{in:7..20}, uniqueness: true
  validates :first_name, length:{in:2..20}, presence: true
  validates :last_name, length:{in:2..20}, presence: true
  validates :address, presence: true

  belongs_to :package, optional: true

  has_many :rents
  has_many :ranks
  has_many :comments
  has_many :favorites
  has_many :carts

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def favorites_games
    favorites_games = []

    self.favorites.each do |favorite|
      favorites_games.push(favorite.game)
    end

    return @favorites_games
  end
end
