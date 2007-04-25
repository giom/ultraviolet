require 'rubygems'
require 'hoe'

class Hoe 
   # Dirty hack to eliminate Hoe from gem dependencies
   def extra_deps 
      @extra_deps.delete_if{ |x| x.first == 'hoe' }
   end
end

version = /^== *(\d+\.\d+\.\d+)/.match( File.read( 'History.txt' ) )[1]

Hoe.new('ultraviolet', version) do |p|
  p.rubyforge_name = 'ultraviolet'
  p.author = ['Dizan Vasquez']
  p.email  = ['dichodaemon@gmail.com']
  p.email = 'dichodaemon@gmail.com'
  p.summary = 'Syntax highlighting engine'
  p.description = p.paragraphs_of('README.txt', 1 ).join('\n\n')
  p.url = 'http://ultraviolet.rubyforge.org'
  p.rdoc_pattern = /^(lib|bin|ext)|txt$/
  p.changes = p.paragraphs_of('History.txt', 0).join("\n\n")
  p.extra_deps << ['textpow', '>= 0.9.0']
end
