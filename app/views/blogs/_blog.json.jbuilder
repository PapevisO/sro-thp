json.extract! blog, :id, :title, :text, :user_id, :group_id, :created_at, :updated_at
json.url blog_url(blog, format: :json)
