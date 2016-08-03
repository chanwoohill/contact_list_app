require 'active_record'
require_relative 'contact'


class ContactList

  def initialize  
    ActiveRecord::Base.establish_connection(
      :adapter => "postgresql",
      :database => "contacts")
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  def begin

    while true do
      menu
      case input
      when "help" 
        menu
      when "new"  
        contact = Contact.new
        puts "Name of the contact?"
        contact.name = input
        puts "email?"
        contact.email = input

        if contact.save
          puts contact
        else
          puts contact.errors.messages
        end
      when "list" 
        contacts = Contact.all
        puts contacts
      when "show" 
        puts "what is contact id?"
        id = gets.strip
        contact = Contact.find(id)
          if contact.details
            puts contact
          else
            puts "Not found"
          end
      when "search"  
        puts "Search term?"
        term = input
        contact = Contact.search(term)
          puts contact
      when "update" 
        puts "what is contact id?"
        id = gets.strip
        contact = Contact.find(id)
        puts "Which field do you want to edit [name, email]?"
        field = input
        puts "New Value?"
        value = input

        begin
          contact.update!(field => value)
        rescue ActiveRecord::RecordInvalid => ex
          puts contact.errors.messages
        end  
      when "destroy" 
        puts "what is contact id?"
        id = gets.strip
        contact = Contact.find(id)
        contact.destroy 
      when "quit"
        break
      else
        puts "Try again"
      end
    end
    puts "Good Bye!"
  end

    def input
      while true do
        print "> "
        v = gets.strip
        if v.length > 0
          break
        else
          puts "invalid input"
        end
      end
      v
    end

    def menu
      puts "Here is a list of available commands:"
      puts "\thelp - Open menu"
      puts "\tdestroy - Delete a contact"
      puts "\tnew - Create a new contact"
      puts "\tlist - List all contacts"
      puts "\tshow - Show a contact"
      puts "\tsearch - Search contacts"
      puts "\tupdate - Edit contacts"
      puts "\tquit - Exit"
    end

end

ContactList.new.begin


