# == Schema Information
#
# Table name: promotions
#
#  id                   :integer          not null, primary key
#  title                :string(255)      not null
#  user_id              :integer          not null
#  highlight            :text
#  body                 :text
#  start_date           :date
#  expiration_date      :date
#  created_at           :datetime
#  updated_at           :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  position             :integer
#  display              :boolean          default(TRUE), not null
#  facebook_publish     :boolean          default(FALSE), not null
#

class Promotion < ActiveRecord::Base
  # validates :expiration_date, presence: true, date: { after: lambda { |e| e.start_date}, message: "Must proceed the start date." }
  validates :title, :user, :start_date, presence: true
  # validates :facebook_publish, inclusion: { in: [true, false] }
  
  has_attached_file :picture,
                    :styles => { :small => "160x200", :medium => "700x332>", :large => "748x348", :thumb => "100x100>" },
                    :default_url => ":style/promotion_missing.png",
                    :bucket => ENV["AWS_BUCKET"]
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :promotions
  )
  
  def self.all_active
    self.where("current_date between start_date and expiration_date").all(order: "position")
  end
  
  def overdue_by_str
    "#{self.overdue_by} #{@overdue_str}"
  end

  # returns the lowest denomination of how much it's overdue
  def overdue_by
    @overdue_str = "minutes"
    
    overdue = (((self.expiration_date.past?) ? (Time.zone.now - self.expiration_date.to_datetime) : (self.expiration_date.to_datetime - Time.zone.now)) / 60).to_i 

    if overdue > 60
      overdue /=  60
      @overdue_str = "hours"
      if overdue > 24
        overdue /= 24
        @overdue_str = "days"
        if overdue > 7
          overdue /= 7
          @overdue_str = "weeks"
          if overdue > 4
            overdue /= 4
            @overdue_str = "months"
          end
        end
      end
    end
    
    @overdue_str = @overdue_str[0..-2] if overdue == 1
    
    overdue
  end
end
