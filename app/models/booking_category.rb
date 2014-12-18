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

class BookingCategory < ActiveRecord::Base
  
  validates :title, :user, presence: true
  
  has_many(
    :bookings,
    class_name: "Booking",
    foreign_key: :category_id,
    primary_key: :id,
    inverse_of: :category
  )
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :booking_categories
  )
  
  def self.all_active
    self.all(order: "position")
  end
  
end
