class Note < ApplicationRecord

    belongs_to :book
    has_rich_text :content
    validates :title, presence: true, length: { maximum: 150, too_long: "%{count} characters is the maximum allowed" }
    validates_uniqueness_of :title, scope: :book_id

end
