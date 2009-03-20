#!/usr/bin/env ruby
# commentscan.rb

class CommentScanner
  def supports_file?(filename)
    #return true if I can pull comments from this file
    false #this base class is worthless :)
  end
  
  def get_comments(filename)
    #return a string full of comments
    return nil unless supports_file?(filename)
    
    return ""
  end
  
  #hold the list of registered scanners
  @@scanners = [CommentScanner]
  def self.inherited(child)
    @@scanners << child
  end
  
  def self.get_comments(filename)
    @@scanners.each do |c|
      x = c.new
      return x.get_comments(filename) if x.supports_file?(filename)
    end
    return ''
  end
end

# load all the ruby files from the filetypes directory
Dir['filetypes/*.rb'].each do |f|
  load f
end
