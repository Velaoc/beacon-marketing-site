class Lead < ApplicationRecord
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: true
  validates :name, length: { maximum: 120 }
end
