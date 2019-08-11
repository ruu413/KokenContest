class Entry < ApplicationRecord
  has_many :users
  has_many_attached :files
  has_many :eveluations
  #has_secure_password
end
