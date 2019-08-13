class Entry < ApplicationRecord
  has_many :users
  has_many_attached :files
  has_many :evaluations
  #has_secure_password
  self.inheritance_column = :_type_disabled # typeを使用可能に
  validates :users, presence: true
  validates :users, length:{in:1..3}
  validates :teamname, length:{ minimum:1}
  validates :type,inclusion:{in:[0,1]}
end
