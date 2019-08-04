class Entry < ApplicationRecord
  has_many :users
  has_many_attached :files
end
