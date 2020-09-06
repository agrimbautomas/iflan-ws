# == Schema Information
#
# Table name: noise_logs
#
#  id         :bigint(8)        not null, primary key
#  device_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class NoiseLog < ApplicationRecord

	validates_presence_of :device_id
	enum device_id: {sensors_device: 1, camera_device: 2}

end
