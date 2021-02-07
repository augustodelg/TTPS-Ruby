class Book < ApplicationRecord
    has_many :notes, dependent: :destroy
    belongs_to :user
    validates :name, presence: true, length: { maximum: 150, too_long: "%{count} characters is the maximum allowed" }
    validates_uniqueness_of :name, scope: :user_id

end
