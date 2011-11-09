class User < ActiveRecord::Base
  siriable
  has_many  :movies
end
