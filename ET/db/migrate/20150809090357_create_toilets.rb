class CreateToilets < ActiveRecord::Migration
  def change
    create_table :toilets do |t|
      t.string :name
      t.float :lat
      t.float :long
      t.text :address
      t.references :user, index: true, foreign_key: true
      t.integer :western
      t.integer :japanese
      t.boolean :multi
      t.integer :urinals
      t.text :comment
      t.float :ave_rate

      t.timestamps null: false
    end
  end
end
