#!/usr/bin/env ruby
require 'rubygems'
require 'active_record'
['post', 'tag'].each{|f|require File.dirname(__FILE__)+"/#{f}.rb"}
ActiveRecord::Base.establish_connection(:adapter=>'sqlite3', :dbfile=>File.dirname(__FILE__)+'/production.sqlite3')

Post.all.each do |p|
	print p.title
	a = p.attributes
	a.delete 'body'
	# a.delete 'excerpt'
	a.delete 'tags'
	a['blog_post'] = true
	a['filter'] = ['markdown']
	a['tags'] = p.tag_string
	a['layout'] = 'post'
	header = a.to_yaml
	path = File.dirname(__FILE__)+'/../content/blog/'+p.created_at.strftime("%Y/%m/%d")
	filename = path +"/#{p.slug}.txt"
	print '.'
	FileUtils.mkdir_p path
	print '.'
	File.open(filename, 'w') do |f|
		f.puts header
		f.puts '--- '
		f.puts p.body
	end
	puts '.Ok'
end
