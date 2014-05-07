class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, 
    dependent: :destroy,
    inverse_of: :user 
    # the association object is destroyed alongside this object
  has_many :meows,
    dependent: :destroy,
    inverse_of: :user 
end
