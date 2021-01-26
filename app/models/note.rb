class Note < ApplicationRecord
    belongs_to :book
    has_rich_text :content 
    validates :title, presence: true
    validates_uniqueness_of :title, scope: :book_id
end
