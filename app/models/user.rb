class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  validates :name, presence: true
  
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  has_and_belongs_to_many :saved_listings, join_table: "saved_listings", class_name: "Listing"

  before_validation :remove_extra_whitespace

  private

  def remove_extra_whitespace
    self.name = self.name&.strip
  end
end
