require 'cgi'

module Uv   
   

   class HtmlProcessor
      @@score_manager = Textpow::ScoreManager.new
      
      attr_reader :string
      attr_accessor :escapeHTML
      
      def initialize render_options, line_numbers = false, headers = true, score_manager = nil
         @score_manager = score_manager || @@score_manager
         @render_options = render_options
         @options = {}
         @headers = headers
         @line_numbers = line_numbers
         @escapeHTML = true
      end
      
      def start_parsing
         @stack = []
         @string = ""
         @line = nil
         @line_number = 0
         print @render_options["document"]["begin"] if @headers
         print @render_options["listing"]["begin"]
      end
      
      def print string
         @string << string
      end
      
      def escape string
         if @render_options["filter"]
            @escaped = string
            @escaped = self.instance_eval( @render_options["filter"] )
            @escaped
         else
            string
         end
      end
      
      def open_tag name, position
         @stack << name
         print escape(@line[@position...position]) if position > @position
         @position = position
         opt = options
         print opt["begin"] if opt
      end
      
      def close_tag name, position
         print escape(@line[@position...position]) if position > @position
         @position = position
         opt = options
         print opt["end"] if opt
         @stack.pop
      end
      
      def new_line line
         print escape(@line[@position..-1]).gsub(/\n|\r/, '') if @line 
         print @render_options["line"]["end"] if @line_number > 0
         print "\n" if @line
         @position = 0
         @line_number += 1
         @line = line
         print @render_options["line"]["begin"]
         if @line_numbers
            print @render_options["line-numbers"]["begin"] 
            print @line_number.to_s.rjust(4).ljust(5)
            print @render_options["line-numbers"]["end"] 
            print " "
         end
      end
      
      def end_parsing
         print escape(@line[@position..-1].gsub(/\n|\r/, '')) if @line 
         print @render_options["line"]["end"] if @line_number > 0
         print "\n" if @line
         while ! @stack.empty?
            opt = options
            print opt["end"] if opt
            @stack.pop
         end
         print @render_options["listing"]["end"]
         print @render_options["document"]["end"] if @headers
      end
      
      def options
         ref = @stack.join ' '
         return @options[ref] if @options.has_key? ref
         
         result = @render_options['tags'].max do |a, b| 
            @score_manager.score( a['selector'], ref ) <=> @score_manager.score( b['selector'], ref )
         end
         result = nil if @score_manager.score( result['selector'], ref ) == 0
         @options[ref] = result
      end
   end
end

