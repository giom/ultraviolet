require 'textpow'
require 'uv/html_processor.rb'


module Uv

   def Uv.init_syntaxes
      @syntaxes = {}
      Dir.glob( File.join(File.dirname(__FILE__), '..', 'syntax', '*.yaml') ).each do |f| 
         @syntaxes[File.basename(f, '.yaml')] = Textpow::SyntaxNode.load( f )
      end
   end
   
   def Uv.syntaxes
      Dir.glob( File.join(File.dirname(__FILE__), '..', 'syntax', '*.yaml') ).collect do |f| 
         File.basename(f, '.yaml')
      end
   end
   
   def Uv.themes
      Dir.glob( File.join(File.dirname(__FILE__), '..', 'render', '*.css') ).collect do |f| 
         File.basename(f, '.css')
      end
   end

   def Uv.syntax_for_file file_name
      init_syntaxes unless @syntaxes
      first_line = ""
      File.open( file_name, 'r' ) { |f|
         while (first_line = f.readline).strip.size == 0; end
      }
      result = []
      @syntaxes.each do |key, value|
         assigned = false
         if value.fileTypes
            value.fileTypes.each do |t|
               if t == File.basename( file_name ) || t == File.extname( file_name )[1..-1]
                  result << [key, value] 
                  assigned = true
                  break
               end
            end
         end
         unless assigned
            if value.firstLineMatch && value.firstLineMatch =~ first_line
               result << [key, value] 
            end
         end
      end
      result
   end
   
   def Uv.parse text, syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render","#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      render_processor = HtmlProcessor.new( render_options, line_numbers )

      @syntaxes[syntax_name].parse( text,  render_processor )
      "<pre class =\"#{css_class}\">\n#{render_processor.string}\n</pre>"
   end

   def Uv.debug text, syntax_name
      unless @syntaxes
         @syntaxes = {}
         Dir.glob( File.join(File.dirname(__FILE__), '..', 'syntax', '*.yaml') ).each do |f| 
            @syntaxes[File.basename(f, '.yaml')] = Textpow::SyntaxNode.load( f )
         end
      end
      processor = Textpow::DebugProcessor.new

      @syntaxes[syntax_name].parse( text, processor )
   end

end