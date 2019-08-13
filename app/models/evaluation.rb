class Evaluation < ApplicationRecord
    belongs_to :entry
    validates :schoolnum, presence: true
    validates :evaluate1, presence: true
    validates :evaluate2, presence: true
    validates :evaluate3, presence: true
end
