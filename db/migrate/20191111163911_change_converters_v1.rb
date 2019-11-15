class ChangeConvertersV1 < ActiveRecord::Migration[5.2]
  def change
    change_table :converters do |t|
      t.string :conversion_rate

    end
  end
end
