# == Schema Information
#
# Table name: promotions
#
#  id                    :integer          not null, primary key
#  title                 :string(255)      not null
#  user_id               :integer          not null
#  highlight             :text
#  body                  :text
#  start_date            :date
#  expiration_date       :date
#  created_at            :datetime
#  updated_at            :datetime
#  picture_file_name     :string(255)
#  picture_content_type  :string(255)
#  picture_file_size     :integer
#  picture_updated_at    :datetime
#  position              :integer
#  display               :boolean          default(TRUE), not null
#  facebook_publish      :boolean          default(FALSE), not null
#  carousel_display      :boolean          default(FALSE), not null
#  facebook_published_at :datetime
#  facebook_id           :integer
#

class Promotion < ActiveRecord::Base
  # validates :expiration_date, presence: true, date: { after: lambda { |e| e.start_date}, message: "Must proceed the start date." }
  validates :title, :user, :start_date, presence: true
  # validates :facebook_publish, inclusion: { in: [true, false] }
  
  has_attached_file :picture,
                    :styles => { :small => "160x86", :medium => "700x332>", :large => "748x348", :thumb => "100x100>" },
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
  
  # def mirror_facebook
 #
 #  end
  
  # can refactor this to work with all models
  def model_path
    Rails.application.routes.url_helpers.promotion_path(self)
  end
  
  def model_url(host = "http://clark-travel.com")
    Rails.application.routes.url_helpers.promotion_url(self, host: host)
  end
  
  def facebook_options(host = "http://clark-travel.com")
    @options ||= (start_date.past?) ? {
      message: body,
      description: highlight,
      link: model_url,
      picture: picture.url
    } : {
      message: body,
      description: highlight,
      link: model_url,
      picture: picture.url,
      scheduled_publish_time: start_date.to_time.advance(hours: 5).to_i,
      published: false
    }
    
    # scheduled_publish_time must be in UNIX timestamp (aka # seconds since 1970 GMT)
  end
  
  def publish_to_facebook!(skip_check = false)
    if (skip_check || publish_to_facebook?)

      # grab the page access token, make a Koala FB API instance and create a wall post with it.
      # the restult is a {"id" => "12131231"} hash. Saves the id for future updates.
      self.facebook_id = Koala::Facebook::API.new(user.facebook.get_page_access_token("clarktravelagency")).put_object("clarktravelagency", "feed", facebook_options)["id"].to_i
      self.facebook_published_at = DateTime.now
      self.save!
    else
      false
    end
  end  
  
  def publish_to_facebook?
    facebook_publish && facebook_published_at.nil?# REMOVE (only publish once)|| (facebook_published_at < updated_at)
  end
  
  def self.all_active
    self.where("current_date between start_date and expiration_date").all(order: "position")
  end
  
  def self.all_active_carousel
    self.where(carousel_display: true).where("current_date between start_date and expiration_date").all(order: "position")
  end
  
  def overdue_by_str
    "#{self.overdue_by} #{@overdue_str} #{@overdue_or_left}"
  end

  # returns the lowest denomination of how much it's overdue
  def overdue_by
    @overdue_str = "minutes"
    @overdue_or_left = "overdue"
    
    overdue = (Time.zone.now - self.expiration_date.to_datetime)
    
    if (overdue < 0)
      overdue *= -1
      @overdue_or_left = "left"
    end
    
    overdue /= 60
    
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
            if overdue > 12
              overdue /= 12
              @overdue_str = "yrs"
            end
          end
        end
      end
    end
    
    @overdue_str = @overdue_str[0..-2] if overdue == 1
    
    overdue.round
  end
end
