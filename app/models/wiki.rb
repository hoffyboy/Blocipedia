class Wiki < ApplicationRecord
  # before_save :validate_user
  belongs_to :user
  has_many :collaborators, dependent: :destroy

  validates :user, presence: true
end
