Codex - Simple Single-User Reference Database
=============================================

![Codex](https://eurekacodex.heroku.com/img/screenshot.png)

**Codex is a simple single-user notes database written in Ruby.** Codex uses [Sinatra](http://www.sinatrarb.com/) and [Datamapper](http://datamapper.org/) to create, save, update, and delete page records from a simple Postgres database. The application is ready for immediate deployment on [Heroku](http://www.heroku.com/).

[Markdown](http://daringfireball.net/projects/markdown/basics) formatting is enabled for all pages, which makes it easy to write complex pages with simple markup. [HTTP authentication](http://www.sinatrarb.com/faq.html#auth) and [forced SSL](https://github.com/tobmatth/rack-ssl-enforcer) for all traffic keeps your information secure. [Bootstrap](http://twitter.github.com/bootstrap/) styling makes your pages look clean and attractive.

History
-------

I developed Codex for two reasons:

1. **It's useful.** If you need a simple reference database for business or personal use, Codex is a good fit. It's simple, free, and inexpensive to maintain. (At present, Heroku's basic plan is free and has more than enough power to run Codex.)
2. **It's educational.** The code at the heart of Codex contains all of the major concepts in CRUD-style application development: connecting to the database, creating records, updating records, and deleting records. It's also a good illustration of various data types, conditionals, helpers, and methods.

Codex is one of my first exercises in Ruby web application development. Developing Codex was my first introduction to good version control practices, Datamapper, Basic HTTP-Authentication, SSL, and deploying database-driven applications on Heroku.

Deploy Codex to Heroku
----------------------

Clone the codex repo:

    $ git clone git@github.com:eurekaoverdrive/codex.git

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