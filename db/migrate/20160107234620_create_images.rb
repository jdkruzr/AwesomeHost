class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :filename
      t.string :path
      t.text :description
      
      t.timestamps null: false
    end
  end
end
