#/usr/bin/env ruby
# commentscan-ext.rb
class CommentScanner
  def self.support_regex(re)
    define_method :supports_file? do |filename|
      # the variable re is kept from the context of
      # this block
      return true if filename =~ re
      return false
    end
  end
  
  def self.comment_regex(re)
    define_method :get_comments do |filename|
      lines = File.new(filename, 'r').read
      comments = String.new

      lines.each_line do |l|
        next unless l =~ re
        comments << $1 << "\n"
      end

      return comments
    end
  end
end
# pull in the rest of the class with all its magic
require 'commentscan.rb'