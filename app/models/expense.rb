class Expense < ApplicationRecord
  belongs_to :user
  has_many :group_expenses
  has_many :groups, through: :group_expenses

  validates :name, presence: true, allow_blank: false, length: { maximum: 20 }
  validates :amount, presence: true, numericality: { only_integer: true }, length: { maximum: 10 }
end
