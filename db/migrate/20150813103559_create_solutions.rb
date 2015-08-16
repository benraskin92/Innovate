class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :solution
      t.references :challenge, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
