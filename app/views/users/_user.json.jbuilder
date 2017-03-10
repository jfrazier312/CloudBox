json.extract! user, :id, :username, :email, :privilege, :password, :created_at, :updated_at
json.url user_url(user, format: :json)
