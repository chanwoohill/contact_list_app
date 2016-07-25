This multi-day project will combine some of the skills you have learned so far. It will encourage you to write object-oriented code that separates concerns and encapsulates common behaviours in different objects.

You will build an application to help users manage their contacts through a request-response command-line program. The user will issue commands like this.

ruby contact_list.rb show 1
Following are explanations of each part of that command.

ruby invokes the ruby interpreter, just as you would use it for any other script.
contact_list.rb is the name of the script file. This file is following the naming convention for OOP because the class inside that file is named ContactList.
show is the command being issued to the app. There is a full list of commands in the activity section.
1 is an argument being passed to the command. Not all commands will take parameters.
Table of contents
Resources
Command line arguments
Saving data to a CSV
Exercise
Setup: Create a repository
Command 1: Main menu and user input
Command 2: Contact index (list command)
Command 3: Contact creation (new command)
Command 4: Contact details (show command)
Command 5: Contact search (search command)
Extra 1: Prevent duplicate emails
Extra 2: Multiple phone numbers
Extra 3: Pagination
Extra 4: Make it executable
Resources
Familiarize yourself with these resources in order to complete this project's tasks. You will need to learn some new skills in order to implement some of the features of this app. The following topics may be new to you, but are crucial to understand to build this app.

Command-line arguments
This application expects to receive user input from the arguments passed to the script from the command line. These arguments are made available in the argument vector ARGV. ARGV is an array-like object that contains the strings that followed the script name when it was invoked. For example:

ruby my_script.rb list of args
Would result in ARGV containing ["list", "of", "args"]. Notice that it splits the text following the script name at the space character into separate strings.

More information about ARGV can be found at the following link.

http://stackoverflow.com/questions/13329132/whats-the-point-of-argv-in-ruby
ARGV Quick Example
Explanation of ARGV
Saving data to a CSV
This application saves its data to a CSV file. Ruby includes a utility for reading and writing to this standard format. Here is some information about interacting with CSV files using Ruby.

http://www.sitepoint.com/guide-ruby-csv-library-part/
http://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html
Exercise
This activity is broken into multiple features. Take things one step at a time and remember to commit before tackling each feature.

Setup: Create a repository
The project will be written in an object-oriented way. Each contact will be represented by an instance of the Contact class. The main application (responsible for user input and output) is managed using an instance of the ContactList class. There is a third object, the Contact class object, that has methods for managing the collection of contacts in the CSV file.

Start with the code provided in the Gist by copying it into a new repository. Don't fork the Gist.

Remember to work incrementally. Implement one feature at a time and commit frequently.

Command 1: Main menu and user input
When the app is run with no command, it should display a menu like this and then exit.

Here is a list of available commands:
    new    - Create a new contact
    list   - List all contacts
    show   - Show a contact
    search - Search contacts
This is not a REPL app. There should be no looping. When a command is issued the program terminates after completing that one task.

Command 2: Contact index (list command)
When the user enters the list command, like this:

ruby contact_list.rb list
...the program should display a list of all contacts in the CSV, one on each line. Following is some example output.

1: Khurram Virani (kvirani@lighthouselabs.ca)
2: Don Burks (don@lighthouselabs.ca)
---
2 records total
The number should start with 1 and represents an index (at first) or unique ID (during the second part) for each contact. Once the contacts are printed out the program should exit.

In order to check that this functionality is working, you'll have to seed your CSV file with some initial contacts. Manually enter some rows into the CSV file so that you can test that your list command is working properly.

Your CSV file will look similar to the example below and also should have the extension .csv:

Jane Doe,jane.doe@example.com
John D,john.d@example.com
Ron Burgendy,ron@channel4news.com
Command 3: Contact creation (new command)
When the user enters the new command, the program should further prompt them for information about the contact they wish to create. It should ask for a full name and email address, separately. Once the user has entered the details about the contact, the application should save this information to the CSV file. The program should also display a message indicating that the contact was created successfully, possibly showing the id of the newly created contact.

Note: to verify this, open the CSV file in your code editor and check the new record where properly inserted.

Before implementing this feature, think about whether or not you need to store an ID for each contact in the CSV. Which approach is better and what are the pros and cons? Discuss this with your peers and mentors.

Command 4: Contact details (show command)
When on the user enters the show command along with an ID (index) of the contact, the app should display their details. If a contact with that index/ID is found, the program displays their details with each field being printed on an separate line. If the contact cannot be found, it displays a custom "not found" message.

Command 5: Contact search (search command)
When the user enters the search command along with a search term, the program will display the contact details of any contacts which have the search term contained within their name or email.

For example, the command ruby contact_list.rb search don would produce the following output.

2: Don Burks (don@lighthouselabs.ca)
---
1 record total
Extra 1: Prevent duplicate emails
If a user tries to input the the same email address for a new contact, output an error saying that the contact already exists and cannot be created.

Extra 2: Multiple phone numbers
When creating a contact, add the ability to store contact’s phone numbers. Contacts can have a limitless amount of phone numbers. Each phone number has a label and the number itself (for example, "mobile" and "444-555-3123").

How would you represent this label/data value in one CSV cell?

Extra 3: Pagination
Whenever outputting contacts, display 5 and then prompt for the enter key before printing another 5.

Extra 4: Make it executable
You can make your contact_list.rb file run just like a command-line app from Linux/Unix. This involves the use of two modifications. Here are some key terms that you should Google to accomplish this.

Shebang (No, not the Ricky Martin song!)
Making shell scripts executable
When this is done, you should be able to do the following from the command line:

./contact_list search don
And it will run and produce the correct output.