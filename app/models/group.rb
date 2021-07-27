class Group < ApplicationRecord
  belongs_to :user
  has_many :group_expenses
  has_many :expenses, through: :group_expenses

  validates :name, uniqueness: true, presence: true, allow_blank: false
end
