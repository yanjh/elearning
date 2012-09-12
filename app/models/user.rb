require 'aasm_roles'
class User < ActiveRecord::Base
  include AasmRoles
  
  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :validatable, :trackable
  validates_uniqueness_of :login, :email, :case_sensitive => false
  
  # Relations
  has_and_belongs_to_many :roles
  has_one :profile
  has_many :authentications
  #belongs_to :classuser
  
  # Hooks
  after_create :create_profile, :register!

  attr_accessible :login, :email, :name, :password, :password_confirmation, :identity_url, :language, :unumber, :sname, :state

  before_validation(:set_default, :on => :create)
  
  self.per_page = 20
  
  def self.search(search, page)
    if search  
      paginate :per_page => 100, :page => page, :conditions => ['login LIKE ? OR email LIKE ?', "%#{search}%", "%#{search}%"]
    else  
      all
    end
  end
  
  def site_name
    self.name || self.login || self.email.split("@").first
  end
  
  def set_active
    self.update_attributes(:state=>"active")
  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  def admin?
    has_role?(:admin)
  end
  
  def teacher?
    has_role?(:teacher)
  end
  
  def student?
    has_role?(:student)
  end
  
  def sclasses
    Classuser.where([" user_id=? and ltype=0",self.id]).order("onumber")
  end

  def sclass
    Classuser.where([" user_id=? and ltype=1",self.id]).limit(1).first
  end
  
  def courses
    Courseuser.where([" link_id=? and ltype=0",self.id]).order("onumber")
  end
  
  def facebook?
    self.authentications.find_by_provider('facebook').present?
  end
  
  def has_role?(role)
    role_symbols.include?(role.to_sym) || role_symbols.include?(:admin)
  end
  
  def has_real_role?(role)
    role_symbols.include?(role.to_sym)
  end
  
  def role_symbols
    @role_symbols ||= roles.map {|r| r.name.underscore.to_sym }
  end


  def add_role(role_name)
    role=Role.find_by_name(role_name)
    self.roles << role if !role.nil? 
  end

  def openid_login?
    !identity_url.blank? #|| (AppConfig.enable_facebook_auth && !facebook_id.blank?)
  end

  def twitter_login?
    !twitter_token.blank? && !twitter_secret.blank?
  end
  
  def not_using_openid?
    !openid_login?
  end
  
  def normalize_identity_url
    self.identity_url = OpenIdAuthentication.normalize_url(identity_url) if openid_login?
  rescue
    errors.add_to_base("Invalid OpenID URL")
  end
  
  def self.find_for_database_authentication(conditions={})
    self.where("login = ?", conditions[:login]).limit(1).first ||
      self.where("email = ?", conditions[:login]).limit(1).first
  end

  def apply_omniauth(omniauth)
    case omniauth['provider']
    when 'facebook'
      self.apply_facebook(omniauth)
    end
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :token =>(omniauth['credentials']['token'] rescue nil))
  end

  def facebook
    @fb_user ||= FbGraph::User.me(self.authentications.find_by_provider('facebook').token).fetch
  end

  def self.role_users(rolename)
    role=Role.find_by_name(rolename)
    #puts role.to_s
    #role.nil? Array.new:role.users
    role.users
  end

  protected
  
  def apply_facebook(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      self.email = (extra['email'] rescue '')
    end
  end
  
  def create_profile
    # Give the user a profile
    self.profile = Profile.create    
  end
  
  
  
  private
  
  def set_default

  end
  
end
