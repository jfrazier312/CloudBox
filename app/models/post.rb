class Post < ApplicationRecord
  has_attached_file :image, styles: { medium: "640x" }


  #Relationships:
  belongs_to :user
  has_many :comments, dependent: :destroy


  # Validations:
  validates :user_id, presence: true
  validates :image, presence: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :caption, length: { maximum: 50 }
end
