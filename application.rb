# Inspired by the following:
# http://rubylearning.com/blog/2009/03/20/interview-ryan-tomayko-on-sinatra/
# https://gist.github.com/8ff54cdfd44e1a6485e2
# http://ididitmyway.heroku.com/past/2010/11/9/sinatra_settings_and_configuration/

require 'rubygems'
require 'sinatra'
require 'sinatra/flash'
require 'dm-core'
require 'dm-validations'
require 'dm-types'
require 'dm-migrations'
require 'dm-postgres-adapter'
require 'rdiscount'
require 'rack-ssl-enforcer'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/database.db")

class Page 
  include DataMapper::Resource
  property :id,           Serial
  property :slug,         String
  property :title,        String
  property :content,      Text
  property :last_updated, DateTime  
  property :sidebar,      Enum[ :yes, :no ], :default => :no
end

DataMapper.finalize

# Authentication
use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == [ENV['ADMIN_USER'], ENV['ADMIN_PASS']]
end

# Force all connections to use SSL
use Rack::SslEnforcer

# Converts page name into post slug
def slugify(content)
  content.downcase.gsub(/ /, '-').gsub(/[^a-z0-9_-]/, '').squeeze('-')
end

# Sets index page as "home"
get '/' do
  redirect '/home/'
end

# Creates new note from "new page" form
post '/' do
  if params[:userinput].empty?
    redirect '/'
  else 
  @page = Page.first_or_create(:title => params[:userinput], :slug => slugify(params[:userinput]))
  @page.content = "This is a new page. Add content by clicking the Edit button below."
  @page.last_updated = Time.now
  @page.save
  flash[:notice] = "Page successfully created."
  redirect "/#{@page.slug}/"
  end
end

# List all pages in database
get '/all/' do
  @page = Page.new
  @page.title = 'All Pages'
  @page.slug = 'all'
  @pages = Page.all
  @sidebars = Page.all(:sidebar => 'yes')
  erb :all
end

# Displays requested note
get '/:url/' do
  @page = Page.first(:slug => params[:url])
  if @page == nil
    flash[:notice] = "Requested page not found!"
    redirect '/home/'
  else  
    @pages = Page.all
    @sidebars = Page.all(:sidebar => 'yes')
    erb :show
  end
end

# Edits requested note
get '/:url/edit' do
  @page = Page.first(:slug => params[:url])
  @sidebars = Page.all(:sidebar => 'yes')
  erb :edit
end

# Saves user edits to note
post '/:url/edit' do
  @page = Page.first(:slug => params[:url])
  @page.title = params[:title]
  @page.content = params[:content]
  @page.sidebar = params[:sidebar]
  @page.last_updated = Time.now
  if @page.slug != 'home' 
    @page.slug = slugify(params[:title])
  end
  @page.save
  flash[:notice] = "Page edit saved."
  redirect "/#{@page.slug}/"
end

# Readies requested note for deletion
get '/:url/delete' do
  @page = Page.first(:slug => params[:url])
  @pages = Page.all
  @sidebars = Page.all(:sidebar => 'yes')
  erb :delete
end

# Deletes specified note
delete '/:url/' do
  @page = Page.first(:slug => params[:url])
  @page.destroy
  flash[:notice] = "Page deleted."
  redirect '/home/'
end

# Redirects user to homepage if a note is not found
not_found do
  flash[:notice] = "Requested page not found!"
  redirect '/home/'
end