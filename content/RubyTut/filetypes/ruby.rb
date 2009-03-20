# filetypes/ruby.rb

class RubyScanner < CommentScanner
  def supports_file?(filename)
    # naive awful way to do this - should guess from contents
    # of file but that's impractical
    return true if filename =~ /\.rb$/
    
    return false
  end
  
  def get_comments(filename)
    lines = File.new(filename, 'r').read
    
    comments = String.new
    
    lines.each_line do |l|
      next unless l =~ /#(.*)/
      # what I /should/ do with this regex is be checking
      # for if I'm in quotes, but this is fine for
      # demonstration purposes
      comments << $1 << "\n"
    end
    
    return comments
  end
end