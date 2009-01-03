#!/usr/bin/env ruby
require 'rubygems'
require 'active_record'
['post', 'tag'].each{|f|require File.dirname(__FILE__)+"/#{f}.rb"}
ActiveRecord::Base.establish_connection(:adapter=>'sqlite3', :dbfile=>File.dirname(__FILE__)+'/production.sqlite3')

p = Post.first
a = p.attributes
a.delete 'body'
a.delete 'excerpt'
a.delete 'tags'
a['blog_post'] = true
a['filter'] = ['textile']
a['tags'] = p.tag_string
header = a.to_yaml
path = File.dirname(__FILE__)+'/../content/blog/'+p.created_at.strftime("%Y/%m/%d")
filename = path +"/#{p.slug}.txt"
FileUtils.mkdir_p path
File.open(filename, 'w') do |f|
	f.puts header
	f.puts p.body.to_yaml
end
