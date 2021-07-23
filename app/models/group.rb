class Group < ApplicationRecord
    belongs_to :user
    has_many :expenses, through: :group_expenses
end
