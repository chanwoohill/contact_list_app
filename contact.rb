class Contact

  attr_accessor :name, :email
  attr_reader :id 

  def initialize(name, email, id=nil)
    @name = name 
    @email = email
    @id = id
  end

  def to_s
    "#{@id}: #{@name}, #{@email}"
  end

  #Write/update and save the contacts to a new row in the database 
  def save
    if id 
      Contact.connection.exec_params('UPDATE contacts SET name = $1, email = $2 WHERE id = $3::int;', [name, email, id])
    else 
      result = Contact.connection.exec_params('INSERT INTO contacts (name, email) VALUES ($1, $2) RETURNING id;', [name, email])
      @id = result[0]['id']
    end 
  end

  #Delete a contract 
  def destroy
    Contact.connection.exec_params(
     'DELETE FROM contacts WHERE id = $1',
     [id])
  end

  class << self

  @@connection = nil
  def connection
    @@connection || PG::Connection.open(dbname: 'contacts')
  end

  #Select all the contacts from the database 
  def all
    result = connection.exec_params('SELECT * FROM contacts ORDER BY id;')
    result.map do |row|
      Contact.new(row['name'], row['email'], row['id'])
    end
  end

  #Find a contact by id and display its details 
  def find(id)
    begin 
      result = connection.exec_params('SELECT * FROM contacts WHERE id = $1::int;', [id])
      Contact.new(result[0]['name'], result[0]['email'], result[0]['id'])
    rescue IndexError
      nil
    end
  end

  #Search for contact name or email by term 
  def search(term)
    result = connection.exec_params('SELECT * FROM contacts WHERE name ILIKE $1 OR email ILIKE $1 ORDER BY id;', ["%#{term}%"])
    contacts = result.map do |row|
      Contact.new(row['name'], row['email'], row['id'])
    end
  end



  end 

end 
 





 
