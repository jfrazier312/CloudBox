class User < ApplicationRecord
  acts_as_voter

  PRIVILEGE_OPTIONS = %w(standard admin)

  # enums:
  enum privilege: {
      standard: 0,
      admin: 1
  }, _prefix: :privilege

  # Relationships:
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :assets, dependent: :destroy
  has_many :shared_assets, dependent: :destroy
  has_many :friends, :foreign_key => "user_1_id", dependent: :destroy
  has_many :friends, :foreign_key => "user_2_id", dependent: :destroy


  # Validations:
  validates :username, presence: true, length: { minimum: 4, maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, :if => :password
  validates :privilege, :inclusion => { :in => PRIVILEGE_OPTIONS }

  #####################################################################################################################

  # Instance Methods

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def share_asset_with(asset, user_list)
    SharedAsset.destroy_previous_shares(asset)
    User.transaction do
      raise Exception.new("File not directly shared with any users") unless user_list && user_list.size > 0
      user_list.each do |username|
        shared_asset = SharedAsset.new(asset_id: asset.id, user_id: User.find_by(username: username).id)
        shared_asset.save!
      end
    end
  end

  # Class Methods
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["username = :value OR email = :value", { :value => login.downcase }]).first
      # where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      conditions[:email].downcase! if conditions[:email]
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  # Returns false instead of throwing exception
  def add_friend(user)
    friend = Friend.new(user_1_id: self.id, user_2_id: user.id)
    friend.save
    # raise Exception.new('Cannot be friends :(') unless friend.save!
  end

  # Returns true is either one of these conditionals returns a non empty set
  def is_friends_with?(user)
    !Friend.where(user_1_id: self.id, user_2_id: user.id).empty? || !Friend.where(user_1_id: user.id, user_2_id: self.id).empty?
  end

  def get_all_friends
    Friend.where(user_1_id: self.id) | Friend.where(user_2_id: self.id)
  end

  def get_users_from_friends(friends)
    users = []
    friends.each do |friend|
      id = (friend.user_1_id == self.id) ? friend.user_2_id : friend.user_1_id
      users << User.find(id)
    end
    return users
  end

  def check_if_shared_with_me(asset)
    shared_asset = SharedAsset.find_by(user_id: self.id, asset_id: asset.id)
    # Fail unless shared asset exists, or you own the asset, or asset is privacy friends and you're a friend
    if (asset.privacy_friends? && !self.is_friends_with?(asset.user)) && (shared_asset.nil?) && (asset.user != self)
      raise Exception.new('You do not have permission to download this file')
    end
  end

  # Creates direct share between friends to shared asset table, persists after removal of friends
  def share_directly_with_friends(asset)
    Asset.transaction do
      friends = self.get_all_friends
      user_friends = self.get_users_from_friends(friends)
      user_friends.each do |friend|
        SharedAsset.create(asset_id: asset.id, user_id: friend.id)
      end
    end
  end

  # changes privacy of file to friends, so if you are friends you will share
  def share_with_friends(asset)
    asset.update!(privacy: 'friends')
  end

  def get_all_shared_assets
    shared_assets = SharedAsset.where(user_id: self.id)
    total_shared_assets = Set.new
    # get all directly shared assets
    shared_assets.each do |f|
      total_shared_assets << Asset.find(f.asset_id)
    end

    # get all public/shared with friends assets
    friends = self.get_all_friends
    my_friends_users = self.get_users_from_friends(friends)

    my_friends_users.each do |user|
      assets = user.assets.where(privacy: 'friends') | user.assets.where(privacy: 'public')
      if assets.size > 0
        assets.each do |asset|
          total_shared_assets << asset
        end
      end
    end
    return total_shared_assets
  end

  # Returns the hash digest for a given string, used in fixtures for testing
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


  #Adds functionality to save a securely hashed password_digest attribute to the database
  #Adds a pair of virtual attributes (password and password_confirmation), including presence validations upon object creation and a validation requiring that they match.
  #Adds an authenticate method that returns the user when the password is correct and false otherwise
  has_secure_password


end
