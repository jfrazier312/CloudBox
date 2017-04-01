require 'rails_helper'


module PostsHelper
  def create_multiple_posts(num_posts)
    for i in 1..num_posts do
      create :post
    end
  end

end

RSpec.configure do |config|
  config.include PostsHelper
end