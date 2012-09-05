class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  validate :name, :presence => true, :on => :create, :message => "can't be blank"
  
  def self.admin
    @@admin ||= find_by_name("admin")
  end
  
  def self.student
    @@student ||= find_by_name("student")
  end
  
  def add_user(user) 
      users << user
  end 
  
end