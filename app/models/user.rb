class User < ActiveRecord::Base
  has_secure_password
  has_one :bucket_list
  has_many :goals through :bucket_list

end