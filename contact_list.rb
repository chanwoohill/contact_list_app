require_relative 'contact'
require 'pg'

class ContactList

  class NoContactFound < StandardError
  end

  def initialize
    @command, @parameter = ARGV
  end

  def begin
    case @command
    when "help" then menu
    when "new"  then create_contact 
    when "list" then list_contacts(Contact.all)
    when "show" then find_contact(@parameter)
    when "search" then list_contacts(Contact.search(@parameter))
    when "update" then update_contact(@parameter)
    when "destroy" then destroy_contact(@parameter)
    end
  end

  def find_contact(id)
    begin
      contact = Contact.find(id)
      raise NoContactFound if contact.nil?
      puts "Name: #{contact.name}, Email: #{contact.email}"
    rescue NoContactFound
      puts "There is no contact with id ##{id}."
    end
  end

  def update_contact(id)
    contact = Contact.find(id)
    puts "Which field do you want to edit [name, email]?"
    field = $stdin.gets.chomp
    puts "New Value?"
    value = $stdin.gets.chomp
    contact.send("#{field}=", value)
    contact.save 
  end 

  def create_contact
    name = prompt_name
    email = prompt_email
    contact = Contact.new(name, email)
    contact.save
  end

  def destroy_contact(id)
    contact = Contact.find(id)
    contact.destroy
  end 

  def prompt_name
    print "Enter new contact's name: "
    $stdin.gets.chomp
  end

  def prompt_email
    print "Enter new contact's e-mail: "
    $stdin.gets.chomp
  end

  def list_contacts(contacts)
    contacts.each do |contact|
      puts contact.to_s
    end
    puts "---"
    puts "#{contacts.size} records total"
  end

  def menu
    puts "Here is a list of available commands:"
    puts "\tdestroy - Delete a contact"
    puts "\tnew - Create a new contact"
    puts "\tlist - List all contacts"
    puts "\tshow - Show a contact"
    puts "\tsearch - Search contacts"
    puts "\tupdate - Edit contacts"
  end

end




