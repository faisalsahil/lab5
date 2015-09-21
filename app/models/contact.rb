class Contact

  include ActiveModel::Model

  attr_accessor :email, :title, :body

  validates :email, :title, presence: true
  validates :email, format: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

end
