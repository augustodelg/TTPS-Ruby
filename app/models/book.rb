class Book < ApplicationRecord
    has_many :notes, dependent: :delete_all
    belongs_to :user
end
