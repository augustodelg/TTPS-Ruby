class Book < ApplicationRecord
    has_many :notes, dependent: :delete_all
    belongs_to :user

    validates :name, presence: true
    validates_uniqueness_of :name, scope: :user_id
end
