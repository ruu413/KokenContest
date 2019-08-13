class User < ApplicationRecord
  belongs_to :entry
  validates :grade, inclusion:{in:0..5}
  validates :name, length:{minimum:1}
end
