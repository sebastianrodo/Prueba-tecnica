class User < ApplicationRecord
  self.per_page = 5

  has_many :contacts, dependent: :delete_all
  has_many :csvs, dependent: :delete_all

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
