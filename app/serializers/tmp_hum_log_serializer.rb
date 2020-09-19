class TmpHumLogSerializer < ActiveModel::Serializer
	attributes :id, :temperature, :humidity, :created_at
end