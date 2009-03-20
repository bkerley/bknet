# filetypes/tex.rb

class TexScanner < CommentScanner
  support_regex /\.tex$/
  comment_regex /%(.*)/
end