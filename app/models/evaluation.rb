class Evaluation < ApplicationRecord
    belongs_to :entry
    validates :school_num, presence: true
    validates :evaluate1, presence: true
    validates :evaluate2, presence: true
    validates :evaluate3, presence: true
    validates :school_num, inclusion:{in:1000000..2000000}
end
