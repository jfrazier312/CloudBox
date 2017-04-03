class Asset < ApplicationRecord

  belongs_to :user

  has_attached_file :uploaded_file
  validates_attachment_size :uploaded_file, :less_than => 10.megabytes
  validates_attachment_presence :uploaded_file
  validates :uploaded_file, presence: true

  validates :filename, presence: true, length: { maximum: 20}

  validates_attachment :uploaded_file, content_type: { content_type: ["text/plain"] }


end
