class AddPicUrl < ActiveRecord::Migration
  def change
    add_column :products, :pic_name, :string
  end
end
