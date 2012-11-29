class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string :title
      t.date :date
      t.string :time_dur
      t.string :name_art
      t.decimal :price
      t.text :full_desc
      t.string :song
      t.integer :user_id

      t.timestamps
    end
    add_index :concerts, :user_id
  end
end
