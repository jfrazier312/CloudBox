class Friend < ApplicationRecord

  belongs_to :user_1, :class_name => 'User'
  belongs_to :user_2, :class_name => 'User'

  validates_uniqueness_of :user_1_id, scope: [:user_2_id]


end
