require 'fileutils'
require 'textpow'
require 'uv/render_processor.rb'


module Uv

   def Uv.paths
      @paths ||= [File.join(File.dirname(__FILE__), ".." ) ]
   end
   
   def Uv.copy_files output, output_dir
      Uv.paths.each do |dir|
         dir_name = File.join( dir, "render", output, "files" )
         FileUtils.cp_r( Dir.glob(File.join( dir_name, "." )), output_dir ) if File.exists?( dir_name )
      end
   end

   def Uv.init_syntaxes
      @syntaxes = {}
      Uv.paths.each do |dir|
        Dir.glob( File.join(dir, 'syntax', '*.syntax') ).each do |f| 
          @syntaxes[File.basename(f, '.syntax')] = Textpow::SyntaxNode.load( f )
        end
      end
   end

   def Uv.syntaxes
      Uv.paths.collect do |dir|
         Dir.glob( File.join(dir, 'syntax', '*.syntax') ).collect do |f| 
            File.basename(f, '.syntax')
         end
      end.flatten
   end
   
   def Uv.themes
      Uv.paths.collect do |dir|
         Dir.glob( File.join(dir, 'render', 'xhtml', 'files', 'css', '*.css') ).collect do |f| 
            File.basename(f, '.css')
         end
      end.flatten
   end
   
   def Uv.renderer(output, render_style)
     Uv.paths.each do |dir|
       render_path = File.join(dir, 'render', output , "#{render_style}.render")
       return render_path if File.exist?(render_path)
     end
     raise( ArgumentError, "Style #{render_style} could not be found for #{output}" )
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
   
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "mac_classic", headers = false
      init_syntaxes unless @syntaxes
      renderer = self.renderer(output, render_style)
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      render_processor = RenderProcessor.new( render_options, line_numbers, headers )
      @syntaxes[syntax_name].parse( text,  render_processor )
      render_processor.string
   end

   def Uv.debug text, syntax_name
      unless @syntaxes
         @syntaxes = {}
         Dir.glob( File.join(File.dirname(__FILE__), '..', 'syntax', '*.syntax') ).each do |f| 
            @syntaxes[File.basename(f, '.syntax')] = Textpow::SyntaxNode.load( f )
         end
      end
      processor = Textpow::DebugProcessor.new

      @syntaxes[syntax_name].parse( text, processor )
   end
end