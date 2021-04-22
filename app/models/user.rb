class User < ActiveRecord::Base
    has_secure_password
    has_many :entries
  
    def slug
      @slug = username.gsub(" ","-").downcase
    end
  
    def self.find_by_slug(slug)
        self.all.find {|t| t.slug == slug}
    end
  end