# == Schema Information
#
# Table name: noise_logs
#
#  id         :bigint(8)        not null, primary key
#  device_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe NoiseLog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
