class AddSearchableToListings < ActiveRecord::Migration[8.0]
  def change
    change_table :listings do |t|
      t.virtual :searchable,
      type: :tsvector,
      as: "to_tsvector('english', coalesce(title, ''))",
      stored: true
    end
  end
end
