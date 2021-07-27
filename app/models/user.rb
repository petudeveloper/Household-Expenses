class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
  validates :name, uniqueness: true, presence: true, allow_blank: false

  has_many :groups, dependent: :destroy
  has_many :expenses, dependent: :destroy
end
