class TmpHumLogSerializer < ActiveModel::Serializer
	attributes :temperature, :humidity, :created_at
end