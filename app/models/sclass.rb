class Sclass < ActiveRecord::Base
  belongs_to :grade,:foreign_key => "cid"

  
end
