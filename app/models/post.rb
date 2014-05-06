class Post < ActiveRecord::Base
  belongs_to :user,
    inverse_of: :posts 
  # inverse_of allows access to the data object without performing
  # further SQL queries

  validates :user, presence: true
  validates :image, presence: true
  validates :description, length: { maximum: 140 }
end
