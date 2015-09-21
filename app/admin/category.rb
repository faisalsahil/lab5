# ActiveAdmin.register Category not working due to naming problem
ActiveAdmin.register Category, as: 'product_categories' do

  permit_params :name

end

