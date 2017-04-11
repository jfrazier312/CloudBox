class Post < ApplicationRecord
  acts_as_votable

  has_attached_file :image, styles: { medium: "640x" }

  #Relationships:
  belongs_to :user
  has_many :comments, dependent: :destroy
  # research this, should allow you to set or update attributes on associated comments through an attribute hash for a post
  # params = { post: {
  #     caption: 'my_caption!!', comments_attributes: [
  #         { content: 'Kari, the awesome Ruby documentation browser!' },
  #         { content: 'The egalitarian assumption of the modern citizen' },
  #         { content: '', _destroy: '1' } # this will be ignored
  #     ]
  # }}
  # post = Post.create(params[:member])
  accepts_nested_attributes_for :comments

  # Validations:
  validates :user_id, presence: true
  validates :image, presence: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :caption, length: { maximum: 2000 }
end
