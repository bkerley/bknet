#!/usr/bin/env ruby
# homepage.rb
require 'rubygems'
require 'markaby'
p = Markaby::Builder.new

p.html {
  head {
    title "My Homepage"
  }
  body {
    h1 "Welcome!"
    p "This is my page."
    p {
      text "This is a link to my "
      a 'Ruby Tutorial', :href=>'http://brycekerley.net/RubyTut/'
      text '.'
    }
    ul {
      li "First list item"
      li "Second list item"
      li {
        s "crossed out"
      }
    }
  }
}

puts p.to_s