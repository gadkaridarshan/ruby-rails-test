class CreateConverters < ActiveRecord::Migration[5.2]
  def change
    create_table :converters do |t|
      t.string :from_currency, null: false
      t.string :to_currency, null: false

      t.timestamps
    end
  end
end
