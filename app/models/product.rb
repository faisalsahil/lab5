class Product < ActiveRecord::Base

  belongs_to :category
  has_many :reviews

  validates_presence_of :name, :description, :price, :category_id

  mount_uploader :picture, ProductPictureUploader

  scope :active, -> { where(active: true) }

  scope :seach_by, ->(q) do
    where(
      Product.arel_table[:name].matches("%#{q}%")\
      .or(Product.arel_table[:description].matches("%#{q}%"))
    )
  end


end

