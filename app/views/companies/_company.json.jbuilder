json.extract! company, :id, :name, :description, :event_id, :created_at, :updated_at
json.url event_company_url(company, format: :json)
