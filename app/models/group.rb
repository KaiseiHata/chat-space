class Group < ApplicationRecord
  validates_presence_of :name
  has_many :users, through: :group_users
  has_many :group_users
  accepts_nested_attributes_for :group_users, allow_destroy: true
end
