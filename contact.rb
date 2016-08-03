require 'active_record'

class Contact < ActiveRecord::Base

  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, length: { minimum: 5 } 

  class << self

    def search(term)
      self.where("name ILIKE ? OR email ILIKE ?", "%#{term}%","%#{term}%").all
    end 

    def to_s
      "ID: #{id} Name: #{name} Email: #{email}"
    end

  end

  def details
    "ID: #{id}\nName: #{name}\nEmail: #{email}"
  end

end 
 






 
