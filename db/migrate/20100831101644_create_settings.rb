class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string :label
      t.string :identifier
      t.text   :description
      t.string :field_type, :default => 'string'
      t.text   :value

      t.timestamps
    end
    
    Setting.create!(:label =>"资源服务根URL器", :identifier => "resourse-url", :description => "", :field_type =>"string", :value =>"")
    Setting.create!(:label =>"IM服务器地址", :identifier => "im-server-address", :description => "", :field_type =>"string", :value =>"")
    Setting.create!(:label =>"IM登录域", :identifier => "im-domain", :description => "", :field_type =>"string", :value =>"yucai.im")
  end

  def self.down
      ["resourse-url", "im-server-address", "im-domain"].each do |x|
      Settings.find_by_identifier(x).destroy!
    end
        
    drop_table :settings
  end
end
