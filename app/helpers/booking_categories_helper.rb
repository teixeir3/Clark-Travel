# == Schema Information
#
# Table name: booking_categories
#
#  id                   :integer          not null, primary key
#  title                :string(255)      not null
#  position             :integer
#  description          :text
#  created_at           :datetime
#  updated_at           :datetime
#  user_id              :integer          not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  display              :boolean          default(TRUE), not null
#

module BookingCategoriesHelper
end
