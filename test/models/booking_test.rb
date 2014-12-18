# == Schema Information
#
# Table name: bookings
#
#  id                   :integer          not null, primary key
#  title                :string(255)      not null
#  url                  :string(255)      not null
#  position             :integer
#  display              :boolean          default(TRUE), not null
#  created_at           :datetime
#  updated_at           :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  carousel_display     :boolean          default(FALSE), not null
#  category_id          :integer          not null
#

require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
