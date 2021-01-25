class AddBooksToNote < ActiveRecord::Migration[6.1]
  def change
    add_reference :notes, :book, null: false, foreign_key: true
  end
end
