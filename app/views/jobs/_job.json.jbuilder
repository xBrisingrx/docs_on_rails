json.extract! job, :id, :d_type, :name, :description, :active, :created_at, :updated_at
json.url job_url(job, format: :json)
