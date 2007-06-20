~Ultraviolet~
~~Syntax Highlighting Engine~~

#Introduction# | index

=About=

Ultraviolet is a syntax highlighting engine based on 
[Textpow http://textpow.rubyforge.org]. Since it uses [Textmate http://macromates.com] 
syntax files, it offers out of the box syntax highlighting for more than 50 
[languages http://macromates.com/svn/Bundles/trunk/Bundles/] and 20 
[themes > themes].

Ultraviolet is at the same time a stand-alone command line utility and a Ruby
library.

= Requirements = 

* [Textpow http://textpow.rubyforge.org].

= Installation =

If you have [rubygems http://docs.rubygems.org/] installation is straightforward by typing 
(as root if needed):

--------hl shell-unix-generic,,false------
gem install -r ultraviolet --include-dependencies
------------------------------------------

If you prefer to get the sources, the last stable version may be
downloaded [here http://rubyforge.org/frs/?group_id=3513].

= Status =

The current version of Ultraviolet is able to produce html output for all
the syntaxes in textmate's [repository http://macromates.com/svn/Bundles/trunk/Bundles/]. 
Further work will be done to produce latex output.

= To Do =

||  Priority  |  Description                                                              |
| high        | Complete *rdoc* api documentation                                         |
| alpha       | Produce latex output                                                      |
| high        | Implement lazy loading for syntaxes (significant speed increase expected) |
| medium      | Support for user defined syntaxes and themes in user's HOME directory     |

# Usage #

= Command Line =

Some examples of command line usage.

*   Getting help:
    --------hl shell-unix-generic,,false--------
    uv --help
    --------------------------------------------

*   Listing available syntaxes:
    --------hl shell-unix-generic,,false--------
    uv -l syntax
    --------------------------------------------

*   Listing available themes:
    --------hl shell-unix-generic,,false--------
    uv -l themes
    --------------------------------------------

*   Letting uv to guess the parameters:
    --------hl shell-unix-generic,,false--------
    uv lib/uv.rb
    --------------------------------------------

*   Specifying a syntax and a theme
    --------hl shell-unix-generic,,false--------
    uv -s yaml -t espresso_libre syntax/ini.syntax
    --------------------------------------------
    
*   Output results to `index.html` and copy required files (/eg/ css):
    --------hl shell-unix-generic,,false--------
    uv -c . syntax/ini.syntax > index.html
    --------------------------------------------
    
*   Producing output in latex and converting to pdf:
    --------hl shell-unix-generic,,false--------
    uv -h -o latex lib/uv.rb > uv.tex
    pdflatex uv.tex
    --------------------------------------------
    
= Using ultraviolet as a library =

The interface is very similar to the one of the command line.

*   List of available syntaxes:
    --------hl ruby,,false--------
    puts Uv.syntaxes.join( ", " )
    --------------------------------------------

*   Listing available themes:
    --------hl ruby,,false--------
    puts Uv.themes.join( ", " )
    --------------------------------------------

*   Parsing a css string. Produce xhtml output, with line numbers 
    using *amy* theme:
    --------hl ruby,,false--------
    result = Uv.parse( text, "xhtml", "css", true, "amy")
    ------------------------------

*   Output copy required files for `xhtml` format to directory `site`:
    --------hl ruby,,false--------
    Uv.copy_files "xhtml", "site"
    ------------------------------

#Examples#

##Syntax Gallery##

These are just some examples of the languages that ultraviolet handles. The
complete list is [here http://macromates.com/svn/Bundles/trunk/Bundles/].

= C =
--------hl c---------------
void Init_oregexp() {
   mOniguruma = rb_define_module("Oniguruma");
   VALUE cORegexp = rb_define_class_under(mOniguruma, "ORegexp", rb_cObject);
   rb_define_alloc_func(cORegexp, oregexp_allocate);
   rb_define_method( cORegexp, "initialize", oregexp_initialize, 2 );
   rb_define_method( cORegexp, "match", oregexp_match, -1 );
   rb_define_method( cORegexp, "=~", oregexp_match_op, 1 );
   rb_define_method( cORegexp, "gsub", oregexp_m_gsub, -1 );
   rb_define_method( cORegexp, "sub",  oregexp_m_sub,  -1 );
   rb_define_method( cORegexp, "gsub!", oregexp_m_gsub_bang, -1 );
   rb_define_method( cORegexp, "sub!",  oregexp_m_sub_bang,  -1 );
   rb_define_method( cORegexp, "scan",  oregexp_m_scan,  1 );
   rb_define_method( cORegexp, "===",  oregexp_m_eqq,  1 );
   rb_define_const( mOniguruma, "VERSION", rb_str_new2(onig_version()) );
}

---------------------------

= C++ =

--------hl c++-------------
#ifndef UNIT_H_
#define UNIT_H_

#include "Traits.h"
#include <set>
#include <deque>

namespace Learning {
   template <
      typename Real, 
      template <typename> class Son, 
      typename traits = Traits<Real, Son> >
   class Unit {
   public:
      typedef typename traits::vector_type vector_type;
      typedef typename traits::unit_type unit_type;
      
      template <typename InputIterator>
      Unit( 
         InputIterator begin,
         InputIterator end
      ) :
         value( begin, end )
      {} 
            
      virtual void addNeighbor( const unit_type & unit ) {
         neighbors.insert( &unit );
         neighborList.push_back( &unit );
      }
      
      virtual void deleteNeighbor( const unit_type & unit ) {
         neighbors.erase( &unit );
         typename std::deque< const unit_type* >::iterator i;
         for ( i = neighborList.begin(); i != neighborList.end(); i++ ) {
            if ( (*i) == &unit ) {
               neighborList.erase( i );
               break;
            }
         }
      }
      
      bool hasNeighbor( const unit_type & unit ) {
         return neighbors.find( &unit) != neighbors.end();
      }
      
      int getNeighborCount() {
         return neighbors.size();
      }
      
      unit_type & getNeighbor( int pos ) {
         return *( const_cast< unit_type* >(neighborList[pos]) );
      }
      
      vector_type & getValue() {
         return value;
      }
      
      virtual ~Unit() {
      }
   private:
      Unit( const unit_type & );
      std::set< const unit_type * > neighbors;
      std::deque< const unit_type* > neighborList;
      vector_type value;
   };
}


#endif /*UNIT_H_*/
---------------------------

= Bibtex =

----------hl bibtex----------
@String{icra04 = {2004 IEEE Int. Conf. on Robotics and Automation}}
@String{icra04_address = {New Orleans, USA}}

@Article{roweisghahramani99,
  author    = {Sam Roweis and Zoubin Ghahramani},
  title     = {A Unifying Review of Linear Gaussian Models},
  journal   = {Neural Computation},
  year      = {1999},
  number    = {11},
  pages     = {305-345}
}

@PhdThesis{murphy01,
  author    = {Kevin Patrick Murphy},
  title     = {Dynamic Bayesian Networks: Representation, Inference and Learning},
  school    = {University of California, Berkeley},
  year      = {2001}
}
----------------------------

= Latex =

---------hl latex-----------
%------------------------------------------------------------------------------
\subsection{Measuring prediction accuracy}
%------------------------------------------------------------------------------

A common performance metric for probabilistic approaches is the maximum data 
likelihood or approximations like the \ac{bic} (see \S 
\ref{sec:hmm:structure_learning}). However, for our particular application, 
this metric has the drawback of not having any geometric interpretation. 
Intuitively, we would like to know \emph{how far} was the predicted state from 
the real one. Hence, we have preferred to measure the performance of our 
algorithm in terms of the average error, computed as the expected distance between 
the prediction for a time horizon $H$ and the effective observation $O_{t+H}$.

\begin{equation}
  \langle E \rangle = \sum_{i \in \states} P([S_{t+H}=i] \mid O_{1:t}) \lVert
  O_{t+H} - \mu_i \rVert^{1/2}
\label{eq:results:expected_distance}
\end{equation}

\noindent for a single time step. This measure may be generalized for a complete
data set containing $K$ observation sequences: 

\begin{equation}
  \langle E \rangle = 
    \frac{1}{K}
    \sum_{k = 1}^{K}
      \frac{1}{T^k-H}
      \sum_{t = 1}^{T^k - H}
        \sum_{i \in \states}
          P([S_{t+H}=i] \mid O_{1:t}^k) \lVert O^k_{t+H} - \mu_i \rVert^{1/2}
\label{eq:results:expected_distance_general}
\end{equation}

It is worth noting that, as opposed to the standard approach in machine 
learning of conducting tests using a ``learning'' and a ``testing'' data  sets, 
the experiments we have presented here will use only a single data set. The 
reason is that, since learning takes place after prediction, there is no need 
to such separation: every observation sequence is ``unknown'' when prediction
takes place.
----------------------------

= Diff =

--------hl diff-----------
--- /etc/apache2/apache2.conf 2006-11-15 22:13:53.000000000 +0100
+++ /etc/apache2/apache2.conf.dpkg-new 2007-01-15 19:10:51.000000000 +0100
@@ -1,50 +1,91 @@
+#
 # Based upon the NCSA server configuration files originally by Rob McCool.
-# Changed extensively for the Debian package by Daniel Stone <daniel@sfarc.net>
-# and also by Thom May <thom@debian.org>.
+#
+# This is the main Apache server configuration file.  It contains the
+# configuration directives that give the server its instructions.
+# See <URL:http://httpd.apache.org/docs-2.1/> for detailed information about
+# the directives.
--------------------------

= HTML =

---------hl html-----------
<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html 
     PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">

<!--

    RDoc Documentation

  -->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <title>RDoc Documentation</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<frameset rows="20%, 80%">
    <frameset cols="25%,35%,45%">
        <frame src="fr_file_index.html"   title="Files" name="Files" />
        <frame src="fr_class_index.html"  name="Classes" />
        <frame src="fr_method_index.html" name="Methods" />
    </frameset>
    <frame src="files/lib/oniguruma_rb.html" name="docwin" />
</frameset>
</html>
---------------------------

= CSS =

-------hl css--------------
/* === Classes =================================== */

table.header-table {
    color: white;
    font-size: small;
}

.type-note {
    font-size: small;
    color: #DEDEDE;
}

.xxsection-bar {
    background: #eee;
    color: #333;
    padding: 3px;
}

.section-bar {
   color: #333;
   border-bottom: 1px solid #999;
    margin-left: -20px;
}


.section-title {
    background: #79a;
    color: #eee;
    padding: 3px;
    margin-top: 2em;
    margin-left: -30px;
    border: 1px solid #999;
}

.top-aligned-row {  vertical-align: top }
.bottom-aligned-row { vertical-align: bottom }
---------------------------

##Theme Gallery##  | themes

= active4d =

----------hl ruby,active4d-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= all_hallows_eve =

----------hl ruby,all_hallows_eve-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= amy =

----------hl ruby,amy-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= blackboard =

----------hl ruby,blackboard-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= brilliance_black =

----------hl ruby,brilliance_black-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= brilliance_dull =

----------hl ruby,brilliance_dull-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= cobalt =

----------hl ruby,cobalt-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= dawn =

----------hl ruby,dawn-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= eiffel =

----------hl ruby,eiffel-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= espresso_libre =

----------hl ruby,espresso_libre-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= idle =
----------hl ruby,idle-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= iplastic =

----------hl ruby,iplastic-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= lazy =

----------hl ruby,lazy-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= mac_classic =

----------hl ruby,mac_classic-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= magicwb_amiga =

----------hl ruby,magicwb_amiga-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= pastels_on_dark =

----------hl ruby,pastels_on_dark-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= slush_poppies =

----------hl ruby,slush_poppies-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= spacecadet =

----------hl ruby,spacecadet-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= sunburst =

----------hl ruby,sunburst-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= twilight =

----------hl ruby,twilight-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

= zenburnesque =

----------hl ruby,zenburnesque-------
module Uv
   def Uv.parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic"
      init_syntaxes unless @syntaxes
      renderer = File.join( File.dirname(__FILE__), '..',"render", output,"#{render_style}.render")
      css_class = render_style
      render_options = YAML.load( File.open(  renderer ) )
      if output == "xhtml"
         render_processor = HtmlProcessor.new( render_options, line_numbers )
         @syntaxes[syntax_name].parse( text,  render_processor )
         "<pre class =\"#{css_class}\">#{render_processor.string}</pre>"
      else
         raise( ArgumentError, "Output for #{output} is not yet implemented" )
      end
   end
end
---------------------------------

# Links #

= Rubyforge Project page =

* [Ultraviolet http://rubyforge.org/projects/ultraviolet/]

= Requirements =

* [Textpow http://rubyforge.org/projects/ultraviolet/].

= Projects using Ultraviolet =

* [Macaronic markup engine http://mama.rubyforge.org/].
* [Radiograph rails plugin http://agilewebdevelopment.com/plugins/radiograph].
* [SimpleHighlight plugin for SimpleLog http://www.daikini.com/past/2007/6/14/simplehighlight_syntax_highlighting_for_simplelog/]

= Other =

* [Uv tutorial in french http://blog.irrealia.org/articles/2007/06/13/apr-egrave-s-coderay-ultraviolet-utilisation-dans-rails-en-ligne-de-commande-ou-comme-une-librairie]
