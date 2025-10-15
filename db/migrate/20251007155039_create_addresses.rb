class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true

      t.string :line_1
      t.string :line_2
      t.string :city
      t.string :country
      t.string :postcode

      t.timestamps
    end
  end
end
