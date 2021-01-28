class Book < ApplicationRecord
    after_destroy :stop_destroy

    has_many :notes, dependent: :delete_all
    belongs_to :user

    validates :name, presence: true, length: { maximum: 32, too_long: "%{count} characters is the maximum allowed" }
    validates_uniqueness_of :name, scope: :user_id

    def stop_destroy
        if name == 'Global'
            errors.add(:base, "You dont delete the Global book")
            p 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
        end
        
    end
    
end
