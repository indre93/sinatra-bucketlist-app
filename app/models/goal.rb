class Goal < ActiveRecord::Base
  belongs_to :user
  
  def formatted_created_at
    self.created_at.strftime("%A, %m/%d/%Y at %l:%M %p")
  end
end
