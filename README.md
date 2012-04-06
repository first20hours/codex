Codex - Simple Single-User Reference Database
=============================================

**Codex is a simple single-user notes database written in Ruby.** Codex uses Sinatra and Datamapper to create, save, update, and delete page records from a simple Postgres database.

Markdown formatting is enabled for all pages, which makes it easy to write complex pages with simple markup.


Deploy Codex to Heroku
----------------------

Clone the codex repo:

  $ git clone 

Add all files to a new Git repo:

  $ git init .
  $ git add -A
  $ git commit -m "Initial commit"

Create a new Heroku application:

  $ heroku create yourappname

Add the shared-database addon to your application:

  $ heroku addons:add shared-database    

Add environment variables for your username and password:

  $ heroku config:add ADMIN_USER=username
  $ heroku config:add ADMIN_PASS=t0psecret
  
Push the master Git branch to Heroku:

  $ git push heroku master
  
Run the setup command in rake:

  $ heroku rake setup
  
Open your new Codex:

  $ heroku open
  
Enjoy!