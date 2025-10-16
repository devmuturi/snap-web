class AddIndexForListingsSearchable < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_index :listings, :searchable,
    using: :gin,
    algorithm: :concurrently
  end
end
