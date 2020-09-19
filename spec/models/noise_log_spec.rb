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

  it { should respond_to(:device_id) }
  it { should validate_presence_of(:device_id) }

end
