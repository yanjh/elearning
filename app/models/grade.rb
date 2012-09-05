class Grade < ActiveRecord::Base
    validate :name, :presence => true, :on => :create, :message =>"phrase.cant_blank"

    has_many :sclasses, :order => "name"
  
end
