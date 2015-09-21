class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :product

  mount_uploader :attachment, ReviewAttachmentUploader

  validates :headline, presence: true
  validates :content, presence: true

end
