json.extract! evento, :id, :titulo, :contenido, :usuario_id, :created_at, :updated_at
json.url evento_url(evento, format: :json)