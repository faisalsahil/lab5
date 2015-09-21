class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :product
      t.string     :headline
      t.text       :content
      t.string     :attachment
      t.timestamps
    end
  end
end
