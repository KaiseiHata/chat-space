class Group < ApplicationRecord
  validates_presence_of :name
  has_many :users, through: :group_users
  has_many :group_users
end
