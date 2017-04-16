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


end
