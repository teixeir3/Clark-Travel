# == Schema Information
#
# Table name: booking_categories
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  position    :integer
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer          not null
#

require 'test_helper'

class BookingCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
