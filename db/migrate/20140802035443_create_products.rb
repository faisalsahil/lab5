class CreateProducts < ActiveRecord::Migration

  def change
    create_table :products do |t|
      t.string  :name,        :null => false
      t.text    :description
      t.decimal :price,       :null => false
      t.integer :category_id, :null => false
      t.boolean :new,         :null => false, :default => false
      t.string  :picture

      t.timestamps
    end
  end

end
