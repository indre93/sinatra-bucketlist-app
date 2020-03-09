# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
  --> Used Sinatra to build this app.
- [x] Use ActiveRecord for storing information in a database
  --> Used SQLite with ActiveRecord for storing information in the database.
- [x] Include more than one model class (e.g. User, Post, Category)
  --> Included User model class and Goal model class.
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
  --> User has_many Goals.
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
  --> Goal belongs_to User.
- [x] Include user accounts with unique login attribute (username or email)
  --> Validates uniqueness of email attribute for each user.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
  --> User is able to create, view, update and destroy their own goals.
- [x] Ensure that users can't modify content created by other users
  --> Created authorized_to_edit?(goal) method to ensure users can only make changes to their own goals.
- [x] Include user input validations
  --> Created logged_in? method and current_user method in the ApplicationController.
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
  --> Used sinatra-flash gem to display error messages (shown in red), as well as successful messages (shown in green). 
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
