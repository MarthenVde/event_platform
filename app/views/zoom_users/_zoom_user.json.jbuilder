json.extract! zoom_user, :id, :email, :first_name, :last_name, :user_type, :zoom_user_id, :created_at, :updated_at
json.url zoom_user_url(zoom_user, format: :json)
