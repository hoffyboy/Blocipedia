class Wiki < ApplicationRecord
  # before_save :validate_user
  belongs_to :user

  validates :user, presence: true
end
