class Contact < ApplicationRecord
  self.per_page = 5

  phone_number = /\(\+(\d{2}|\d{1})\)\s(\d{3}\-\d{3}\-\d{2}\-\d{2}|\d{3}\s\d{3}\s\d{2}\s\d{2})/
  belongs_to :user
  belongs_to :csv

  validates :name, presence: true, format: { with: /\A[a-zA-Z-]+\z/,
    message: "only allows letters" }
  validates  :date_of_birth, presence: true
  validates  :phone_number, presence: true, format: { with: phone_number,
    message: "Incorrect Phone Number format  (+00) 000-000-00-00 and (+00) 000 000 00 00" }
  validates  :address, presence: true
  validates  :credit_card_number, presence: true, credit_card_number: true
  validates  :credit_card_type, presence: true
  validates  :email, presence: true, email_address: true
  validates_uniqueness_of :email, scope: :user_id

  attr_encrypted :credit_card_number, key: 'This is a key that is 256 bits!!'
end
