# == Schema Information
#
# Table name: bookings
#
#  id                   :integer          not null, primary key
#  title                :string(255)      not null
#  user_id              :integer          not null
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

class Booking < ActiveRecord::Base
  validates :title, :category, presence: true
  # validates :facebook_publish, inclusion: { in: [true, false] }
  
  has_attached_file :picture,
                    :styles => { :small => "180x150" },
                    :default_url => ":style/Luxury_Rectangle_180x150.png",
                    :bucket => ENV["AWS_BUCKET"]
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  
  belongs_to(
    :category,
    class_name: "BookingCategory",
    foreign_key: :category_id,
    primary_key: :id,
    inverse_of: :bookings,
    dependent: :destroy
  )
  
  has_one(
    :user,
    through: :category,
    source: :user
  )
  
  def self.all_active
    self.where(display: true).all(order: "position")
  end
  
  def self.carousel_bookings
    self.where(carousel_display: true).all(order: "position")
  end
end
