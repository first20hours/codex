require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-validations'
require 'dm-types'
require 'dm-migrations'

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

DataMapper.auto_migrate!

task :setup do
  @page = Page.create(:slug => 'home')
  @page.slug = 'home'
  @page.title = 'Home'
  @page.content = 'This is the home page. Press the edit button below to get started.'
  @page.last_updated = Time.now
  @page.sidebar = :no
  @page.save 
end