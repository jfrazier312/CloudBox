class Asset < ApplicationRecord

  belongs_to :user
  has_many :shared_assets, dependent: :destroy

  PRIVACY_OPTIONS = %w(private friends public)

  enum privacy: {
      private: 0,
      friends: 1,
      public: 2
  }, _prefix: :privacy

  validates :privacy, :inclusion => { :in => PRIVACY_OPTIONS }


  has_attached_file :uploaded_file,
                    :url => "/assets/get/:id",
                    :path => ":Rails_root/assets/:id/:basename.:extension"
  validates_attachment_size :uploaded_file, :less_than => 30.megabytes
  validates_attachment_presence :uploaded_file
  validates_attachment :uploaded_file, content_type: { content_type: ["text/plain", "image/jpg", "image/jpeg", "image/gif", "image/png", "application/pdf", "application/msword", "video/quicktime", "audio/mpeg3", "application/java", "application/zip", "application/octet-stream", "application/x-gzip", "application/x-compressed", "text/html", "application/powerpoint", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"] }


  validates :uploaded_file, presence: true
  validates :filename, presence: true
  validates :description, presence: true, length: { maximum: 255}
  validates :custom_name, presence: true, length: { maximum: 30}


  before_validation {
    self.filename = uploaded_file.original_filename
  }

  def get_shared_with_users
    shared_assets = SharedAsset.where(asset_id: self.id)
    users = []
    if shared_assets
      shared_assets.each do |sa|
        shared_user = User.find(sa.user_id)
        users << shared_user.username if shared_user
      end
    end

    # if self.privacy_friends?
    #   user = self.user
    #   friends = user.get_users_from_friends(user.get_all_friends)
    #   friends.each do |f|
    #     users << f.username
    #   end
    # end
    #
    # if self.privacy_public?
    #   User.all.each do |f|
    #     user << f.username
    #   end
    # end

    return users
  end


end
