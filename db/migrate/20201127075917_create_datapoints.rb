class CreateDatapoints < ActiveRecord::Migration[5.0]
  def change
    create_table :datapoints do |t|
      t.string :field
      t.integer :time
      t.integer :data
      t.references :log, foreign_key: true

      t.timestamps
    end
  end
end
