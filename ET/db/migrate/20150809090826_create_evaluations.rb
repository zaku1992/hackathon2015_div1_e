class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :toilet, index: true, foreign_key: true
      t.integer :clean
      t.integer :comfort
      t.integer :good_smell
      t.integer :design
      t.integer :find
      t.float :rate
      t.text :comment

      t.timestamps null: false
    end
  end
end
