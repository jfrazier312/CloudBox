class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, length: { minimum: 1, maximum: 50 }


end
