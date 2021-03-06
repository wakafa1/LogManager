class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.string :filename
      t.references :user, foreign_key: true
      t.boolean :parsed

      t.timestamps
    end
  end
end
