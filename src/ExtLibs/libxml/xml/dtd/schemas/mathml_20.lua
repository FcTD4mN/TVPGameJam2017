return [===[
<!-- MathML 2.0 DTD  ....................................................... -->
<!-- file: mathml2.dtd
-->

<!-- MathML 2.0 DTD

     This is the Mathematical Markup Language (MathML) 2.0, an XML
     application for describing mathematical notation and capturing
     both its structure and content.

     Copyright &#xa9; 1998-2003 W3C&#xae; (MIT, ERCIM, Keio), All Rights 
     Reserved. W3C liability, trademark, document use and software
     licensing rules apply. 

     Permission to use, copy, modify and distribute the MathML 2.0 DTD and
     its accompanying documentation for any purpose and without fee is
     hereby granted in perpetuity, provided that the above copyright notice
     and this paragraph appear in all copies.  The copyright holders make
     no representation about the suitability of the DTD for any purpose.

     It is provided "as is" without expressed or implied warranty.

        Revision:   $Id: mathml2.dtd,v 1.12 2003/11/04 13:14:35 davidc Exp $

     This entity may be identified by the PUBLIC and SYSTEM identifiers:

       PUBLIC "-//W3C//DTD MathML 2.0//EN"
       SYSTEM "mathml2.dtd"

     Revisions: editor and revision history at EOF
-->
<!-- Entity used to enable marked sections which enforces stricter		
     checking of MathML syntax rules		
-->
<!ENTITY % MathMLstrict "IGNORE">		

<!-- MathML Qualified Names module ............................... -->
<!ENTITY % mathml-qname.module "INCLUDE" >
<![%mathml-qname.module;[
<!ENTITY % mathml-qname.mod
     PUBLIC "-//W3C//ENTITIES MathML 2.0 Qualified Names 1.0//EN"
            "mathml2-qname-1.mod" >
%mathml-qname.mod;]]>

<!-- if %NS.prefixed; is INCLUDE, include all NS attributes, 
     otherwise just those associated with MathML
-->
<![%NS.prefixed;[
  <!ENTITY % MATHML.NamespaceDecl.attrib 
         "%NamespaceDecl.attrib;"
>
]]>
<!ENTITY % MATHML.NamespaceDecl.attrib 
     "%MATHML.xmlns.attrib;"
>


<!-- Attributes shared by all elements  .......................... -->

<!ENTITY % MATHML.Common.attrib
     "%MATHML.NamespaceDecl.attrib;
      %XLINK.prefix;:href   CDATA           #IMPLIED		
      %XLINK.prefix;:type   CDATA           #IMPLIED	
      class        CDATA                    #IMPLIED
      style        CDATA                    #IMPLIED
      id           ID                       #IMPLIED
      xref         IDREF                    #IMPLIED
      other        CDATA                    #IMPLIED"
>

<!-- Presentation element set  ................................... -->

<!-- Attribute definitions -->

<!ENTITY % att-fontsize
     "fontsize     CDATA                    #IMPLIED" >
<!ENTITY % att-fontweight
     "fontweight   ( normal | bold )        #IMPLIED" >
<!ENTITY % att-fontstyle
     "fontstyle    ( normal | italic )      #IMPLIED" >
<!ENTITY % att-fontfamily
     "fontfamily   CDATA                    #IMPLIED" >
<!ENTITY % att-color
     "color        CDATA                    #IMPLIED" >

<!-- MathML2 typographically-distinguished symbol attributes -->

<![%MathMLstrict;[
  <!ENTITY % att-mathvariant
     "mathvariant     ( normal | bold | italic | bold-italic | double-struck | 
                        bold-fraktur | script | bold-script | fraktur |
                        sans-serif | bold-sans-serif | sans-serif-italic |
                        sans-serif-bold-italic | monospace )
                                                                   #IMPLIED" >
]]>
<!ENTITY % att-mathvariant
     "mathvariant     CDATA                    #IMPLIED" >
<!ENTITY % att-mathsize
     "mathsize     CDATA                    #IMPLIED" >
<!ENTITY % att-mathcolor
     "mathcolor     CDATA                    #IMPLIED" >
<!ENTITY % att-mathbackground
     "mathbackground     CDATA                    #IMPLIED" >

<!ENTITY % att-fontinfo
     "%att-fontsize;
      %att-fontweight;
      %att-fontstyle;
      %att-fontfamily;
      %att-color;
      %att-mathvariant;
      %att-mathsize;
      %att-mathcolor;
      %att-mathbackground;"
>

<!ENTITY % att-form
     "form         ( prefix | infix | postfix )  #IMPLIED" >
<!ENTITY % att-fence
     "fence        ( true | false )         #IMPLIED" >
<!ENTITY % att-separator
     "separator    ( true | false )         #IMPLIED" >
<!ENTITY % att-lspace
     "lspace       CDATA                    #IMPLIED" >
<!ENTITY % att-rspace
     "rspace       CDATA                    #IMPLIED" >
<!ENTITY % att-stretchy
     "stretchy     ( true | false )         #IMPLIED" >
<!ENTITY % att-symmetric
     "symmetric    ( true | false )         #IMPLIED" >
<!ENTITY % att-maxsize
     "maxsize      CDATA                    #IMPLIED" >
<!ENTITY % att-minsize
     "minsize      CDATA                    #IMPLIED" >
<!ENTITY % att-largeop
     "largeop      ( true | false)          #IMPLIED" >
<!ENTITY % att-movablelimits
     "movablelimits ( true | false )        #IMPLIED" >
<!ENTITY % att-accent
     "accent       ( true | false )         #IMPLIED" >

<!ENTITY % att-opinfo
     "%att-form;
      %att-fence;
      %att-separator;
      %att-lspace;
      %att-rspace;
      %att-stretchy;
      %att-symmetric;
      %att-maxsize;
      %att-minsize;
      %att-largeop;
      %att-movablelimits;
      %att-accent;"
>
<!ENTITY % att-width
     "width        CDATA                    #IMPLIED" >
<!ENTITY % att-height
     "height       CDATA                    #IMPLIED" >
<!ENTITY % att-depth
     "depth        CDATA                    #IMPLIED" >
<!ENTITY % att-linebreak
     "linebreak    CDATA                    #IMPLIED" >
<!ENTITY % att-sizeinfo
     "%att-width;
      %att-height;
      %att-depth;"
>
<!ENTITY % att-lquote               
     "lquote       CDATA                    #IMPLIED" >
<!ENTITY % att-rquote               
     "rquote       CDATA                    #IMPLIED" >
<!ENTITY % att-linethickness        
     "linethickness CDATA                   #IMPLIED" >
<!ENTITY % att-scriptlevel          
     "scriptlevel  CDATA                    #IMPLIED" >
<!ENTITY % att-displaystyle         
     "displaystyle ( true | false )         #IMPLIED" >
<!ENTITY % att-scriptsizemultiplier 
     "scriptsizemultiplier CDATA            #IMPLIED" >
<!ENTITY % att-scriptminsize        
     "scriptminsize CDATA                   #IMPLIED" >
<!ENTITY % att-background           
     "background   CDATA                    #IMPLIED" >
<!ENTITY % att-veryverythinmathspace           
     "veryverythinmathspace   CDATA         #IMPLIED" >
<!ENTITY % att-verythinmathspace           
     "verythinmathspace   CDATA             #IMPLIED" >
<!ENTITY % att-thinmathspace           
     "thinmathspace   CDATA                 #IMPLIED" >
<!ENTITY % att-mediummathspace           
     "mediummathspace   CDATA               #IMPLIED" >
<!ENTITY % att-thickmathspace           
     "thickmathspace   CDATA                #IMPLIED" >
<!ENTITY % att-verythickmathspace           
     "verythickmathspace   CDATA            #IMPLIED" >
<!ENTITY % att-veryverythickmathspace           
     "veryverythickmathspace   CDATA        #IMPLIED" >
<!ENTITY % att-open                 
     "open         CDATA                    #IMPLIED" >
<!ENTITY % att-close                
     "close        CDATA                    #IMPLIED" >
<!ENTITY % att-separators          
     "separators   CDATA                    #IMPLIED" >
<!ENTITY % att-subscriptshift       
     "subscriptshift CDATA                  #IMPLIED" >
<!ENTITY % att-superscriptshift     
     "superscriptshift CDATA                #IMPLIED" >
<!ENTITY % att-accentunder          
     "accentunder  ( true | false )         #IMPLIED" >
<!ENTITY % att-align       
     "align        CDATA                    #IMPLIED" >
<![%MathMLstrict;[
  <!ENTITY % att-numalign	
     "numalign     ( left | center | right )         #IMPLIED" >
  <!ENTITY % att-denomalign
     "denomalign   ( left | center | right )         #IMPLIED" >
]]>
<!ENTITY % att-numalign		
     "numalign        CDATA                    #IMPLIED" >		
<!ENTITY % att-denomalign		
     "denomalign        CDATA                    #IMPLIED" >		
<!ENTITY % att-rowalign-list		
     "rowalign     CDATA                    #IMPLIED" >		
<!ENTITY % att-columnalign-list		
     "columnalign  CDATA                    #IMPLIED" >		
<![%MathMLstrict;[
  <!ENTITY % att-rowalign
     "rowalign     ( top | bottom |	center | baseline | axis )    #IMPLIED" >
  <!ENTITY % att-columnalign
     "columnalign  ( left | center | right )        #IMPLIED" >
]]>
<!ENTITY % att-rowalign      
     "rowalign     CDATA                    #IMPLIED" >
<!ENTITY % att-columnalign     
     "columnalign  CDATA                    #IMPLIED" >
<!ENTITY % att-columnwidth   
     "columnwidth  CDATA                    #IMPLIED" >
<!ENTITY % att-groupalign-list		
     "groupalign   CDATA                    #IMPLIED" >		
<![%MathMLstrict;[
  <!ENTITY % att-groupalign
     "groupalign   ( left | right | center | decimalpoint )   #IMPLIED" >
]]>
<!ENTITY % att-groupalign      
     "groupalign   CDATA                    #IMPLIED" >
<!ENTITY % att-alignmentscope 
     "alignmentscope CDATA                  #IMPLIED" >
<!ENTITY % att-rowspacing           
     "rowspacing   CDATA                    #IMPLIED" >
<!ENTITY % att-columnspacing      
     "columnspacing CDATA                   #IMPLIED" >
<!ENTITY % att-rowlines            
     "rowlines     CDATA                    #IMPLIED" >
<!ENTITY % att-columnlines        
     "columnlines  CDATA                    #IMPLIED" >
<!ENTITY % att-frame            
     "frame       ( none | solid | dashed ) #IMPLIED" >
<!ENTITY % att-side		
     "side       ( left | right | leftoverlap | rightoverlap ) #IMPLIED" >		
<!ENTITY % att-framespacing         
     "framespacing CDATA                    #IMPLIED" >
<!ENTITY % att-minlabelspacing		
     "minlabelspacing CDATA                 #IMPLIED" >		
<![%MathMLstrict;[
  <!ENTITY % att-equalrows
     "equalrows    ( true | false )         #IMPLIED" >
  <!ENTITY % att-equalcolumns
     "equalcolumns ( true | false )         #IMPLIED" >
]]>
<!ENTITY % att-equalrows        
     "equalrows    CDATA                    #IMPLIED" >
<!ENTITY % att-equalcolumns         
     "equalcolumns CDATA                    #IMPLIED" >

<!ENTITY % att-tableinfo            
     "%att-align;
      %att-rowalign-list;	
      %att-columnalign-list;	
      %att-columnwidth;
      %att-groupalign-list;	
      %att-alignmentscope;
      %att-side;		
      %att-rowspacing;
      %att-columnspacing;
      %att-rowlines;
      %att-columnlines;
      %att-width;		
      %att-frame;
      %att-framespacing;
      %att-minlabelspacing;		
      %att-equalrows;
      %att-equalcolumns;
      %att-displaystyle;" 
>

<!ENTITY % att-rowspan              
     "rowspan      CDATA                    #IMPLIED" >
<!ENTITY % att-columnspan           
     "columnspan   CDATA                    #IMPLIED" >
<!ENTITY % att-edge        
     "edge         ( left | right )         #IMPLIED" >
<!ENTITY % att-actiontype          
     "actiontype   CDATA                    #IMPLIED" >
<!ENTITY % att-selection       
     "selection    CDATA                    #IMPLIED" >

<!ENTITY % att-name                 
     "name         CDATA                    #IMPLIED" >
<!ENTITY % att-alt              
     "alt          CDATA                    #IMPLIED" >
<!ENTITY % att-index           
     "index        CDATA                    #IMPLIED" >

<![%MathMLstrict;[
  <!ENTITY % att-bevelled
     "bevelled      ( true | false )        #IMPLIED" >
]]>
<!ENTITY % att-bevelled       
     "bevelled      CDATA                    #IMPLIED" >

<!-- Presentation schemata with content -->

<!ENTITY % ptoken                   
     "%mi.qname; | %mn.qname; | %mo.qname;
      | %mtext.qname; | %ms.qname;" >

<!ATTLIST %mi.qname;
      %MATHML.Common.attrib;
      %att-fontinfo;
>

<!ATTLIST %mn.qname;      
      %MATHML.Common.attrib; 
      %att-fontinfo;
>

<!ATTLIST %mo.qname;     
      %MATHML.Common.attrib; 
      %att-fontinfo;
      %att-opinfo;
>

<!ATTLIST %mtext.qname;  
      %MATHML.Common.attrib;
      %att-fontinfo;
>

<!ATTLIST %ms.qname;     
      %MATHML.Common.attrib;
      %att-fontinfo;
      %att-lquote;
      %att-rquote;
>

<!-- Empty presentation schemata -->

<!ENTITY % petoken                  
     "%mspace.qname;" >
<!ELEMENT %mspace.qname;  EMPTY >

<!ATTLIST %mspace.qname; 
      %att-sizeinfo;
      %att-linebreak;
      %MATHML.Common.attrib;
>

<!-- Presentation: general layout schemata -->

<!ENTITY % pgenschema               
     "%mrow.qname; | %mfrac.qname; | %msqrt.qname; | %mroot.qname; 
      | %menclose.qname; | %mstyle.qname; | %merror.qname; 
      | %mpadded.qname; | %mphantom.qname; | %mfenced.qname;" >

<!ATTLIST %mrow.qname;        
      %MATHML.Common.attrib;
>

<!ATTLIST %mfrac.qname;     
      %MATHML.Common.attrib;
      %att-bevelled;		
      %att-numalign;		
      %att-denomalign;		
      %att-linethickness;
>

<!ATTLIST %msqrt.qname;     
      %MATHML.Common.attrib;
>

<!ATTLIST %menclose.qname;  
      %MATHML.Common.attrib;
      notation CDATA 'longdiv' >

<!ATTLIST %mroot.qname;    
      %MATHML.Common.attrib;
>

<!ATTLIST %mstyle.qname;  
      %MATHML.Common.attrib;
      %att-fontinfo;
      %att-opinfo;
      %att-lquote;
      %att-rquote;
      %att-linethickness;
      %att-scriptlevel;
      %att-scriptsizemultiplier;
      %att-scriptminsize;
      %att-background;
      %att-veryverythinmathspace;
      %att-verythinmathspace;
      %att-thinmathspace;
      %att-mediummathspace;
      %att-thickmathspace;
      %att-verythickmathspace;
      %att-veryverythickmathspace;
      %att-open;
      %att-close;
      %att-separators;
      %att-subscriptshift;
      %att-superscriptshift;
      %att-accentunder;
      %att-tableinfo;
      %att-rowspan;
      %att-columnspan;
      %att-edge;
      %att-selection;
      %att-bevelled;	
      %att-height;		
      %att-depth;		
>

<!ATTLIST %merror.qname;   
      %MATHML.Common.attrib;
>

<!ATTLIST %mpadded.qname;     
      %MATHML.Common.attrib;
      %att-sizeinfo;
      %att-lspace;
>

<!ATTLIST %mphantom.qname;      
      %MATHML.Common.attrib;
>

<!ATTLIST %mfenced.qname;     
      %MATHML.Common.attrib;
      %att-open;
      %att-close;
      %att-separators;
>

<!-- Presentation layout schemata: scripts and limits -->

<!ENTITY % pscrschema               
     "%msub.qname; | %msup.qname; | %msubsup.qname; | %munder.qname; 
      | %mover.qname; | %munderover.qname; | %mmultiscripts.qname;" >

<!ATTLIST %msub.qname;      
      %MATHML.Common.attrib;
      %att-subscriptshift;
>

<!ATTLIST %msup.qname;         
      %MATHML.Common.attrib;
      %att-superscriptshift;
>

<!ATTLIST %msubsup.qname;    
      %MATHML.Common.attrib;
      %att-subscriptshift;
      %att-superscriptshift;
>

<!ATTLIST %munder.qname;   
      %MATHML.Common.attrib;
      %att-accentunder;
>

<!ATTLIST %mover.qname;   
      %MATHML.Common.attrib;
      %att-accent;
>

<!ATTLIST %munderover.qname;   
      %MATHML.Common.attrib;
      %att-accent;
      %att-accentunder;
>

<!ATTLIST %mmultiscripts.qname;   
      %MATHML.Common.attrib;
      %att-subscriptshift;
      %att-superscriptshift;
>

<!-- Presentation layout schemata: empty elements for scripts -->

<!ENTITY % pscreschema              
     "%mprescripts.qname; | %none.qname;" >

<!ELEMENT %mprescripts.qname;  EMPTY >
<!ATTLIST %mprescripts.qname;   
      %MATHML.xmlns.attrib; >

<!ELEMENT %none.qname;  EMPTY >
<!ATTLIST %none.qname;    
      %MATHML.xmlns.attrib; >

<!-- Presentation layout schemata: tables -->

<![%MathMLstrict;[
<!-- in strict mode only allow mtable at top level.
     mtr ,mlabledtr and mtd only allowed inside mtable.
-->
  <!ENTITY % ptabschema    "%mtable.qname;" >
]]>

<!ENTITY % ptabschema               
     "%mtable.qname; | %mtr.qname; | %mlabeledtr.qname; | %mtd.qname;" >

<!ATTLIST %mtable.qname;
      %MATHML.Common.attrib;
      %att-tableinfo;
>

<!ATTLIST %mtr.qname;    
      %MATHML.Common.attrib;
      %att-rowalign;
      %att-columnalign-list;	
      %att-groupalign-list;	
>

<!ATTLIST %mlabeledtr.qname;  
      %MATHML.Common.attrib;
      %att-rowalign;
      %att-columnalign-list;	
      %att-groupalign-list;	
>

<!ATTLIST %mtd.qname;   
      %MATHML.Common.attrib;
      %att-rowalign;
      %att-columnalign;
      %att-groupalign-list;	
      %att-rowspan;
      %att-columnspan;
>
<!ENTITY % plschema                 
     "%pgenschema; | %pscrschema; | %ptabschema;" >

<!-- Empty presentation layout schemata -->

<!ENTITY % peschema                 
     "%maligngroup.qname; | %malignmark.qname;" >

<!ELEMENT %malignmark.qname;  EMPTY >

<!ATTLIST %malignmark.qname;  
      %att-edge; >

<!ELEMENT %maligngroup.qname;  EMPTY >
<!ATTLIST %maligngroup.qname;  
      %MATHML.Common.attrib;
      %att-groupalign;
>


<!ELEMENT %mglyph.qname;  EMPTY >
<!ATTLIST %mglyph.qname;    
      %att-alt;
      %att-fontfamily;
      %att-index; >

<!-- Presentation action schemata -->

<!ENTITY % pactions                 
     "%maction.qname;" >
<!ATTLIST %maction.qname;    
      %MATHML.Common.attrib;
      %att-actiontype;
      %att-selection;
>

<!-- The following entity for substitution into
     content constructs excludes elements that
     are not valid as expressions.
-->

<!ENTITY % PresInCont               
     "%ptoken; | %petoken; |
      %plschema; | %peschema; | %pactions;" >

<!-- Presentation entity: all presentation constructs -->


<![%MathMLstrict;[
<!-- In strict mode don't allow prescripts and none at top level.-->
  <!ENTITY % Presentation "%PresInCont;">             
]]>
<!ENTITY % Presentation             
     "%ptoken; | %petoken; | %pscreschema; |
      %plschema; | %peschema; | %pactions;">

<!-- Content element set  ........................................ -->

<!-- Attribute definitions -->

<!ENTITY % att-base                 
     "base         CDATA                    '10'" >
<!ENTITY % att-closure              
     "closure      CDATA                    'closed'" >
<!ENTITY % att-definition           
     "definitionURL CDATA                   ''" >
<!ENTITY % att-encoding             
     "encoding     CDATA                    ''" >
<!ENTITY % att-nargs             
     "nargs        CDATA                    '1'" >
<!ENTITY % att-occurrence           
     "occurrence   CDATA                    'function-model'" >
<!ENTITY % att-order   
     "order        CDATA                    'numeric'" >
<!ENTITY % att-scope                
     "scope        CDATA                    'local'" >
<!ENTITY % att-type                 
     "type         CDATA                    #IMPLIED" >

<!-- Content elements: leaf nodes -->

<!ENTITY % ctoken               
     "%csymbol.qname; | %ci.qname; | %cn.qname;" >

<!ATTLIST %ci.qname;     
      %MATHML.Common.attrib;
      %att-type;
      %att-definition;
      %att-encoding;
>

<!ATTLIST %csymbol.qname;   
      %MATHML.Common.attrib;
      %att-encoding;
      %att-type;
      %att-definition;
>

<!ATTLIST %cn.qname;    
      %MATHML.Common.attrib;
      %att-type;
      %att-base;
      %att-definition;
      %att-encoding;
>

<!-- Content elements: specials -->

<!ENTITY % cspecial                 
     "%apply.qname; | %reln.qname; |
      %lambda.qname;" >

<!ATTLIST %apply.qname;   
      %MATHML.Common.attrib;
>

<!ATTLIST %reln.qname;   
      %MATHML.Common.attrib;
>

<!ATTLIST %lambda.qname;      
      %MATHML.Common.attrib;
>

<!-- Content elements: others -->

<!ENTITY % cother                   
     "%condition.qname; | %declare.qname; | %sep.qname;" >

<!ATTLIST %condition.qname;     
      %MATHML.Common.attrib;
>

<!ATTLIST %declare.qname;    
      %MATHML.Common.attrib;
      %att-type;
      %att-scope;
      %att-nargs;
      %att-occurrence;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %sep.qname;  EMPTY >
<!ATTLIST %sep.qname;         
      %MATHML.xmlns.attrib; >

<!-- Content elements: semantic mapping -->

<![%MathMLstrict;[
<!-- in strict mode only allow semantics at top level.
     annotation and annotation-xml only allowed in semantics
-->
  <!ENTITY % csemantics  "%semantics.qname;" >
]]>
<!ENTITY % csemantics               
     "%semantics.qname; | %annotation.qname; |
      %annotation-xml.qname;" >

<!ATTLIST %semantics.qname;  
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ATTLIST %annotation.qname;  
      %MATHML.Common.attrib;
      %att-encoding;
>

<!ATTLIST %annotation-xml.qname; 
      %MATHML.Common.attrib;
      %att-encoding;
>

<!-- Content elements: constructors -->

<!ENTITY % cconstructor             
     "%interval.qname; | %list.qname; | %matrix.qname; 
      | %matrixrow.qname; | %set.qname; | %vector.qname;
      | %piecewise.qname; " >

<!ATTLIST %interval.qname;   
      %MATHML.Common.attrib;
      %att-closure;
>

<!ATTLIST %set.qname;        
      %MATHML.Common.attrib;
      %att-type;
>

<!ATTLIST %list.qname;          
      %MATHML.Common.attrib;
      %att-order;
>

<!ATTLIST %vector.qname;    
      %MATHML.Common.attrib;
>

<!ATTLIST %matrix.qname;    
      %MATHML.Common.attrib;
>

<!ATTLIST %matrixrow.qname;     
      %MATHML.Common.attrib;
>

<!ATTLIST %piecewise.qname;   
      %MATHML.Common.attrib;
>

<!ATTLIST %piece.qname;   
      %MATHML.Common.attrib;
>

<!ATTLIST %otherwise.qname;   
      %MATHML.Common.attrib;
>


<!-- Content elements: symbols -->

<!ENTITY % c0ary              
    "%integers.qname; |
     %reals.qname; |
     %rationals.qname; |
     %naturalnumbers.qname; |
     %complexes.qname; |
     %primes.qname; |
     %exponentiale.qname; |
     %imaginaryi.qname; |
     %notanumber.qname; |
     %true.qname; |
     %false.qname; |
     %emptyset.qname; |
     %pi.qname; |
     %eulergamma.qname; |
     %infinity.qname;" >

<!ELEMENT %integers.qname;  EMPTY >
<!ATTLIST %integers.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %reals.qname;  EMPTY >
<!ATTLIST %reals.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %rationals.qname;  EMPTY >
<!ATTLIST %rationals.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %naturalnumbers.qname;  EMPTY >
<!ATTLIST %naturalnumbers.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %complexes.qname;  EMPTY >
<!ATTLIST %complexes.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %primes.qname;  EMPTY >
<!ATTLIST %primes.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %exponentiale.qname;  EMPTY >
<!ATTLIST %exponentiale.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %imaginaryi.qname;  EMPTY >
<!ATTLIST %imaginaryi.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %notanumber.qname;  EMPTY >
<!ATTLIST %notanumber.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %true.qname;  EMPTY >
<!ATTLIST %true.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %false.qname;  EMPTY >
<!ATTLIST %false.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %emptyset.qname;  EMPTY >
<!ATTLIST %emptyset.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %pi.qname;  EMPTY >
<!ATTLIST %pi.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %eulergamma.qname;  EMPTY >
<!ATTLIST %eulergamma.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %infinity.qname;  EMPTY >
<!ATTLIST %infinity.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!-- Content elements: operators -->

<!ENTITY % cfuncop1ary              
     "%inverse.qname; | %ident.qname;|
      %domain.qname; |  %codomain.qname; | 
      %image.qname;  " >

<!ELEMENT %inverse.qname;  EMPTY >
<!ATTLIST %inverse.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %domain.qname;  EMPTY >
<!ATTLIST %domain.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %codomain.qname;  EMPTY >
<!ATTLIST %codomain.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %image.qname;  EMPTY >
<!ATTLIST %image.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>



<!ENTITY % cfuncopnary              
     "%fn.qname; | %compose.qname;" >

<!ATTLIST %fn.qname;     
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %ident.qname;  EMPTY >
<!ATTLIST %ident.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %compose.qname;  EMPTY >
<!ATTLIST %compose.qname;  
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % carithop1ary             
     "%abs.qname; | %conjugate.qname; | %exp.qname; | %factorial.qname; |
      %arg.qname; | %real.qname; | %imaginary.qname; |
      %floor.qname; | %ceiling.qname;" >

<!ELEMENT %exp.qname;  EMPTY >
<!ATTLIST %exp.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %abs.qname;  EMPTY >
<!ATTLIST %abs.qname;        
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %arg.qname;  EMPTY >
<!ATTLIST %arg.qname;     
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %real.qname;  EMPTY >
<!ATTLIST %real.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %imaginary.qname;  EMPTY >
<!ATTLIST %imaginary.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %conjugate.qname;  EMPTY >
<!ATTLIST %conjugate.qname;  
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %factorial.qname;  EMPTY >
<!ATTLIST %factorial.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>


<!ELEMENT %floor.qname;  EMPTY >
<!ATTLIST %floor.qname;     
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %ceiling.qname;  EMPTY >
<!ATTLIST %ceiling.qname;     
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>
<!ENTITY % carithop1or2ary          
     "%minus.qname;" >

<!ELEMENT %minus.qname;  EMPTY >
<!ATTLIST %minus.qname;     
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % carithop2ary             
     "%quotient.qname; | %divide.qname; | %power.qname; | %rem.qname;" >

<!ELEMENT %quotient.qname;  EMPTY >
<!ATTLIST %quotient.qname;       
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %divide.qname;  EMPTY >
<!ATTLIST %divide.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %power.qname;  EMPTY >
<!ATTLIST %power.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %rem.qname;  EMPTY >
<!ATTLIST %rem.qname;       
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % carithopnary             
     "%plus.qname; | %times.qname; | %max.qname; 
      | %min.qname; | %gcd.qname; | %lcm.qname;" >

<!ELEMENT %plus.qname;  EMPTY >
<!ATTLIST %plus.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %max.qname;  EMPTY >
<!ATTLIST %max.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %min.qname;  EMPTY >
<!ATTLIST %min.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %times.qname;  EMPTY >
<!ATTLIST %times.qname;      
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %gcd.qname;  EMPTY >
<!ATTLIST %gcd.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %lcm.qname;  EMPTY >
<!ATTLIST %lcm.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % carithoproot             
     "%root.qname;" >

<!ELEMENT %root.qname;  EMPTY >
<!ATTLIST %root.qname;     
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % clogicopquant            
     "%exists.qname; | %forall.qname;" >

<!ELEMENT %exists.qname;  EMPTY >
<!ATTLIST %exists.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %forall.qname;  EMPTY >
<!ATTLIST %forall.qname;     
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % clogicopnary             
     "%and.qname; | %or.qname; | %xor.qname;" >

<!ELEMENT %and.qname;  EMPTY >
<!ATTLIST %and.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %or.qname;  EMPTY >
<!ATTLIST %or.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %xor.qname;  EMPTY >
<!ATTLIST %xor.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % clogicop1ary             
     "%not.qname;" >

<!ELEMENT %not.qname;  EMPTY >
<!ATTLIST %not.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % clogicop2ary             
     "%implies.qname;" >

<!ELEMENT %implies.qname;  EMPTY >
<!ATTLIST %implies.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % ccalcop                  
     "%log.qname; | %int.qname; | %diff.qname; | %partialdiff.qname; |
      %divergence.qname; | %grad.qname; | %curl.qname; | %laplacian.qname;" >

<!ELEMENT %divergence.qname;  EMPTY >
<!ATTLIST %divergence.qname;     
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %grad.qname;  EMPTY >
<!ATTLIST %grad.qname;  
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %curl.qname;  EMPTY >
<!ATTLIST %curl.qname;     
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %laplacian.qname;  EMPTY >
<!ATTLIST %laplacian.qname;     
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %log.qname;  EMPTY >
<!ATTLIST %log.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %int.qname;  EMPTY >
<!ATTLIST %int.qname;    
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %diff.qname;  EMPTY >
<!ATTLIST %diff.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %partialdiff.qname;  EMPTY >
<!ATTLIST %partialdiff.qname;  
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % ccalcop1ary              
     "%ln.qname;" >

<!ELEMENT %ln.qname;  EMPTY >
<!ATTLIST %ln.qname;   
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % csetop1ary               
     "%card.qname;" >

<!ELEMENT %card.qname;  EMPTY >
<!ATTLIST %card.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % csetop2ary               
     "%setdiff.qname;" >

<!ELEMENT %setdiff.qname;  EMPTY >
<!ATTLIST %setdiff.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % csetopnary               
     "%union.qname; | %intersect.qname; | %cartesianproduct.qname; " >

<!ELEMENT %union.qname;  EMPTY >
<!ATTLIST %union.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %intersect.qname;  EMPTY >
<!ATTLIST %intersect.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %cartesianproduct.qname;  EMPTY >
<!ATTLIST %cartesianproduct.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % cseqop                   
     "%sum.qname; | %product.qname; | %limit.qname;" >

<!ELEMENT %sum.qname;  EMPTY >
<!ATTLIST %sum.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %product.qname;  EMPTY >
<!ATTLIST %product.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %limit.qname;  EMPTY >
<!ATTLIST %limit.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % ctrigop                  
     "%sin.qname; | %cos.qname; | %tan.qname; 
      | %sec.qname; | %csc.qname; | %cot.qname; 
      | %sinh.qname; | %cosh.qname; | %tanh.qname; 
      | %sech.qname; | %csch.qname; | %coth.qname; 
      | %arcsin.qname; | %arccos.qname; | %arctan.qname;
      | %arccosh.qname; | %arccot.qname; | %arccoth.qname;
      | %arccsc.qname; | %arccsch.qname; | %arcsec.qname;
      | %arcsech.qname; | %arcsinh.qname; | %arctanh.qname;
      " >

<!ELEMENT %sin.qname;  EMPTY >
<!ATTLIST %sin.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %cos.qname;  EMPTY >
<!ATTLIST %cos.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %tan.qname;  EMPTY >
<!ATTLIST %tan.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %sec.qname;  EMPTY >
<!ATTLIST %sec.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %csc.qname;  EMPTY >
<!ATTLIST %csc.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %cot.qname;  EMPTY >
<!ATTLIST %cot.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %sinh.qname;  EMPTY >
<!ATTLIST %sinh.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %cosh.qname;  EMPTY >
<!ATTLIST %cosh.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %tanh.qname;  EMPTY >
<!ATTLIST %tanh.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %sech.qname;  EMPTY >
<!ATTLIST %sech.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %csch.qname;  EMPTY >
<!ATTLIST %csch.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %coth.qname;  EMPTY >
<!ATTLIST %coth.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %arcsin.qname;  EMPTY >
<!ATTLIST %arcsin.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %arccos.qname;  EMPTY >
<!ATTLIST %arccos.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %arctan.qname;  EMPTY >
<!ATTLIST %arctan.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %arccosh.qname;  EMPTY >
<!ATTLIST %arccosh.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>


<!ELEMENT %arccot.qname;  EMPTY >
<!ATTLIST %arccot.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %arccoth.qname;  EMPTY >
<!ATTLIST %arccoth.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>


<!ELEMENT %arccsc.qname;  EMPTY >
<!ATTLIST %arccsc.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %arccsch.qname;  EMPTY >
<!ATTLIST %arccsch.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %arcsec.qname;  EMPTY >
<!ATTLIST %arcsec.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %arcsech.qname;  EMPTY >
<!ATTLIST %arcsech.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %arcsinh.qname;  EMPTY >
<!ATTLIST %arcsinh.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %arctanh.qname;  EMPTY >
<!ATTLIST %arctanh.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>



<!ENTITY % cstatopnary              
     "%mean.qname; | %sdev.qname; |
      %variance.qname; | %median.qname; |
      %mode.qname;" >

<!ELEMENT %mean.qname;  EMPTY >
<!ATTLIST %mean.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %sdev.qname;  EMPTY >
<!ATTLIST %sdev.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %variance.qname;  EMPTY >
<!ATTLIST %variance.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %median.qname;  EMPTY >
<!ATTLIST %median.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %mode.qname;  EMPTY >
<!ATTLIST %mode.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % cstatopmoment            
     "%moment.qname;" >

<!ELEMENT %moment.qname;  EMPTY >
<!ATTLIST %moment.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % clalgop1ary              
     "%determinant.qname; |
      %transpose.qname;" >

<!ELEMENT %determinant.qname;  EMPTY >
<!ATTLIST %determinant.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %transpose.qname;  EMPTY >
<!ATTLIST %transpose.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % clalgop2ary              
     "%vectorproduct.qname; 
      | %scalarproduct.qname; 
      | %outerproduct.qname;" >

<!ELEMENT %vectorproduct.qname;  EMPTY >
<!ATTLIST %vectorproduct.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %scalarproduct.qname;  EMPTY >
<!ATTLIST %scalarproduct.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %outerproduct.qname;  EMPTY >
<!ATTLIST %outerproduct.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % clalgopnary              
     "%selector.qname;" >

<!ELEMENT %selector.qname;  EMPTY >
<!ATTLIST %selector.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!-- Content elements: relations -->

<!ENTITY % cgenrel2ary             
     "%neq.qname; | %factorof.qname;" >

<!ELEMENT %neq.qname;  EMPTY >
<!ATTLIST %neq.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %factorof.qname;  EMPTY >
<!ATTLIST %factorof.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % cgenrelnary              
     "%eq.qname; | %leq.qname; | %lt.qname; | %geq.qname; 
      | %gt.qname;| %equivalent.qname; | %approx.qname;" >

<!ELEMENT %eq.qname;  EMPTY >
<!ATTLIST %eq.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %equivalent.qname;  EMPTY >
<!ATTLIST %equivalent.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %approx.qname;  EMPTY >
<!ATTLIST %approx.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %gt.qname;  EMPTY >
<!ATTLIST %gt.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %lt.qname;  EMPTY >
<!ATTLIST %lt.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %geq.qname;  EMPTY >
<!ATTLIST %geq.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %leq.qname;  EMPTY >
<!ATTLIST %leq.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % csetrel2ary              
     "%in.qname; | %notin.qname; | %notsubset.qname; | %notprsubset.qname;" >

<!ELEMENT %in.qname;  EMPTY >
<!ATTLIST %in.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %notin.qname;  EMPTY >
<!ATTLIST %notin.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %notsubset.qname;  EMPTY >
<!ATTLIST %notsubset.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %notprsubset.qname;  EMPTY >
<!ATTLIST %notprsubset.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % csetrelnary       
     "%subset.qname; | %prsubset.qname;" >

<!ELEMENT %subset.qname;  EMPTY >
<!ATTLIST %subset.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ELEMENT %prsubset.qname;  EMPTY >
<!ATTLIST %prsubset.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
>

<!ENTITY % cseqrel2ary              
     "%tendsto.qname;" >

<!ELEMENT %tendsto.qname;  EMPTY >
<!ATTLIST %tendsto.qname;
      %MATHML.Common.attrib;
      %att-definition;
      %att-encoding;
      %att-type;
>

<!-- Content elements: quantifiers -->

<!ENTITY % cquantifier            
     "%lowlimit.qname; | %uplimit.qname; | %bvar.qname; 
      | %degree.qname; | %logbase.qname;
      | %momentabout.qname; | %domainofapplication.qname; " >

<!ATTLIST %lowlimit.qname;
      %MATHML.Common.attrib;
>

<!ATTLIST %uplimit.qname;
      %MATHML.Common.attrib;
>

<!ATTLIST %bvar.qname;
      %MATHML.Common.attrib;
>

<!ATTLIST %degree.qname;
      %MATHML.Common.attrib;
>

<!ATTLIST %logbase.qname;
      %MATHML.Common.attrib;
>

<!ATTLIST %momentabout.qname;
      %MATHML.Common.attrib;
>

<!ATTLIST %domainofapplication.qname;
      %MATHML.Common.attrib;
>

<!-- Operator groups -->

<!ENTITY % cop1ary                  
     "%cfuncop1ary; | %carithop1ary; | %clogicop1ary; |
      %ccalcop1ary; | %ctrigop; | %clalgop1ary; |
      %csetop1ary;" >

<!ENTITY % cop2ary                  
     "%carithop2ary; | %clogicop2ary;| %clalgop2ary; | %csetop2ary;" >

<!ENTITY % copnary                  
     "%cfuncopnary; | %carithopnary; | %clogicopnary; |
      %csetopnary; | %cstatopnary; | %clalgopnary;" >

<!ENTITY % copmisc                  
     "%carithoproot; | %carithop1or2ary; | %ccalcop; |
      %cseqop; | %cstatopmoment; | %clogicopquant;" >

<!-- Relation groups -->

<!ENTITY % crel2ary                 
     "%cgenrel2ary; | %csetrel2ary; | %cseqrel2ary;" >

<!ENTITY % crelnary                 
     "%cgenrelnary; | %csetrelnary;" >

<!-- Content constructs: all -->

<!ENTITY % Content                  
     "%ctoken; | %cspecial; | %cother; | %csemantics; | %c0ary;
      | %cconstructor; | %cquantifier; | %cop1ary; | %cop2ary; 
      | %copnary; |%copmisc; | %crel2ary; | %crelnary;" >

<!-- Content constructs for substitution in presentation structures -->

<!ENTITY % ContInPres               
     "%ci.qname; |%csymbol.qname;| %cn.qname; | %c0ary; |
      %apply.qname; | %fn.qname; |
      %lambda.qname; | %reln.qname; |
      %cconstructor; |
      %semantics.qname; |%declare.qname;" >

<!-- ............................................................. -->
<!-- Recursive definition for content of expressions. Include
     presentation constructs at lowest level so presentation
     layout schemata hold presentation or content elements.
     Include content constructs at lowest level so content
     elements hold PCDATA or presentation elements at leaf
     level (for permitted substitutable elements in context)
-->
<![%MathMLstrict;[
<!-- in strict mode don't allow presentation in content
     except where allowed by chapter 5:
     ci, cn, csymbol, semantics
-->
  <!ENTITY % ContentExpression  "(%Content;)*" >
  <!ENTITY % semanticsContentExpression        
       "(%Content; | %PresInCont; |
         %annotation.qname; | %annotation-xml.qname;)*" >
]]>
<!ENTITY % ContentExpression        
     "(%Content; | %PresInCont;)*" >
<!ENTITY % semanticsContentExpression    "%ContentExpression;">    


<!ENTITY % PresExpression      
     "(%Presentation; | %ContInPres;)*" >
<!ENTITY % MathExpression           
     "(%PresInCont; | %ContInPres;)*" >

<!-- PCDATA or MathML character elements -->
<!ENTITY % MathMLCharacters         
     "#PCDATA | %mglyph.qname; " >

<!-- Content elements: tokens                       -->
<!-- (may contain embedded presentation constructs) -->

<!ELEMENT %ci.qname;                 (%MathMLCharacters; | %PresInCont;)* >
<!ELEMENT %csymbol.qname;            (%MathMLCharacters; | %PresInCont;)* >
<!ELEMENT %cn.qname;                 (%MathMLCharacters; | %sep.qname; | %PresInCont;)* >

<!-- Content elements: special -->

<!ELEMENT %apply.qname;              (%ContentExpression;) >
<!ELEMENT %reln.qname;               (%ContentExpression;) >
<!ELEMENT %lambda.qname;             (%ContentExpression;) >

<!-- Content elements: other -->

<!ELEMENT %condition.qname;          (%ContentExpression;) >
<!ELEMENT %declare.qname;            (%ContentExpression;) >

<!-- Content elements: semantics -->

<!ELEMENT %semantics.qname;          (%semanticsContentExpression;) >
<!ENTITY % Annotation.content  "( #PCDATA )" >
<!ELEMENT %annotation.qname;         %Annotation.content; >

<!ENTITY % Annotation-xml.content "ANY" >
<!ELEMENT %annotation-xml.qname;     %Annotation-xml.content; >

<!-- Content elements: constructors -->

<!ELEMENT %interval.qname;           (%ContentExpression;) >
<!ELEMENT %set.qname;                (%ContentExpression;) >
<!ELEMENT %list.qname;               (%ContentExpression;) >
<!ELEMENT %vector.qname;             (%ContentExpression;) >
<!ELEMENT %matrix.qname;             (%ContentExpression;) >
<!ELEMENT %matrixrow.qname;          (%ContentExpression;) >

<!ELEMENT %piecewise.qname;          ((%piece.qname;)*, (%otherwise.qname;)? ) >
<!ELEMENT %piece.qname;              (%ContentExpression;) >
<!ELEMENT %otherwise.qname;          (%ContentExpression;) >

<!-- Content elements: operator (user-defined) -->

<!ELEMENT %fn.qname;                 (%ContentExpression;) >

<!-- Content elements: quantifiers -->

<!ELEMENT %lowlimit.qname;           (%ContentExpression;) >
<!ELEMENT %uplimit.qname;            (%ContentExpression;) >
<!ELEMENT %bvar.qname;               (%ContentExpression;) >
<!ELEMENT %degree.qname;             (%ContentExpression;) >
<!ELEMENT %logbase.qname;            (%ContentExpression;) >
<!ELEMENT %momentabout.qname;        (%ContentExpression;) >
<!ELEMENT %domainofapplication.qname; (%ContentExpression;) >

<!-- ............................................................. -->
<!-- Presentation layout schemata contain tokens,
     layout and content schemata.
-->



<![%MathMLstrict;[
<!-- In strict mode enforce mfrac has exactly two children
      same for msub etc -->
  <!ENTITY % onePresExpression
       "(%Presentation; | %ContInPres;)" >
  <!ENTITY % twoPresExpression
       "(%onePresExpression;,%onePresExpression;)" >
  <!ENTITY % threePresExpression
       "(%onePresExpression;,%onePresExpression;,%onePresExpression;)" >
  <!ENTITY % mtrPresExpression
       "(%mtr.qname;|%mlabeledtr.qname;)*" >
  <!ENTITY % mtdPresExpression
       "(%mtd.qname;)*" >
  <!ENTITY % prscrPresExpression " (%onePresExpression;,
  ((%onePresExpression;|%none.qname;),(%onePresExpression;|%none.qname;))*,
  (%mprescripts.qname;,
  ((%onePresExpression;|%none.qname;),(%onePresExpression;|%none.qname;))*)?
  )">
]]>


<!-- By default keep them as they were in MathML 2.0  -->
<!ENTITY % onePresExpression   "%PresExpression;">
<!ENTITY % twoPresExpression   "%PresExpression;">
<!ENTITY % threePresExpression "%PresExpression;">
<!ENTITY % mtrPresExpression   "%PresExpression;">
<!ENTITY % mtdPresExpression   "%PresExpression;">
<!ENTITY % prscrPresExpression "%PresExpression;">

<!ELEMENT %mstyle.qname;             (%PresExpression;) >
<!ELEMENT %merror.qname;             (%PresExpression;) >
<!ELEMENT %mphantom.qname;           (%PresExpression;) >
<!ELEMENT %mrow.qname;               (%PresExpression;) >
<!ELEMENT %mfrac.qname;              (%twoPresExpression;) >
<!ELEMENT %msqrt.qname;              (%PresExpression;) >
<!ELEMENT %menclose.qname;           (%PresExpression;) >
<!ELEMENT %mroot.qname;              (%twoPresExpression;) >
<!ELEMENT %msub.qname;               (%twoPresExpression;) >
<!ELEMENT %msup.qname;               (%twoPresExpression;) >
<!ELEMENT %msubsup.qname;            (%threePresExpression;) >
<!ELEMENT %mmultiscripts.qname;      (%prscrPresExpression;) >
<!ELEMENT %munder.qname;             (%twoPresExpression;) >
<!ELEMENT %mover.qname;              (%twoPresExpression;) >
<!ELEMENT %munderover.qname;         (%threePresExpression;) >
<!ELEMENT %mtable.qname;             (%mtrPresExpression;) >
<!ELEMENT %mtr.qname;                (%mtdPresExpression;) >
<!ELEMENT %mlabeledtr.qname;         (%mtdPresExpression;) >
<!ELEMENT %mtd.qname;                (%PresExpression;) >
<!ELEMENT %maction.qname;            (%PresExpression;) >
<!ELEMENT %mfenced.qname;            (%PresExpression;) >
<!ELEMENT %mpadded.qname;            (%PresExpression;) >

<!-- Presentation elements contain PCDATA or malignmark constructs. -->

<!ELEMENT %mi.qname;                 (%MathMLCharacters; |
      %malignmark.qname;)* >
<!ELEMENT %mn.qname;                 (%MathMLCharacters; |
      %malignmark.qname;)* >
<!ELEMENT %mo.qname;                 (%MathMLCharacters; |
      %malignmark.qname;)* >
<!ELEMENT %mtext.qname;              (%MathMLCharacters; |
      %malignmark.qname;)* >
<!ELEMENT %ms.qname;                 (%MathMLCharacters; |
      %malignmark.qname;)* >

<!-- Browser interface definition  ............................... -->

<!-- Attributes for top-level element "math" -->

<!ENTITY % att-macros               
     "macros       CDATA                    #IMPLIED" >
<!ENTITY % att-mode                 
     "mode         CDATA                    #IMPLIED" >
<![%MathMLstrict;[
  <!ENTITY % att-display
     "display      ( block | inline )                    'inline'" >
]]>
<!ENTITY % att-display                
     "display      CDATA                    #IMPLIED" >

<!ENTITY % att-schemalocation               
     "%Schema.prefix;:schemaLocation CDATA  #IMPLIED">		

<!ENTITY % att-topinfo          
     "%MATHML.Common.attrib;
      %att-schemalocation;		
      %att-macros;
      %att-mode;
      %att-display;" >

<!-- Attributes for browser interface element -->

<!ENTITY % att-baseline             
     "baseline     CDATA                    #IMPLIED" >
<!ENTITY % att-overflow            
     "overflow  ( scroll | elide | truncate | scale ) 'scroll'" >
<!ENTITY % att-altimg               
     "altimg       CDATA                    #IMPLIED" >
<!ENTITY % att-alttext           
     "alttext      CDATA                    #IMPLIED" >

<!ENTITY % att-browif           
     "%att-type;
      %att-name;
      %att-height;
      %att-width;
      %att-baseline;
      %att-overflow;
      %att-altimg;
      %att-alttext;" >

<!-- ............................................................. -->
<!-- The top-level element "math" contains MathML encoded
     mathematics. The "math" element has the browser info
     attributes iff it is also the browser interface element.
-->

<!ELEMENT %math.qname;               (%MathExpression;) >

<!ATTLIST %math.qname;
      %att-topinfo;
      %att-browif; >

<!-- MathML Character Entities .............................................. -->
<!ENTITY % mathml-charent.module "INCLUDE" >
<![%mathml-charent.module;[
<!-- Entity sets from ISO Technical Report 9573-13 ..... -->

<!ENTITY % ent-isoamsa
      PUBLIC "-//W3C//ENTITIES Added Math Symbols: Arrow Relations for MathML 2.0//EN"
             "iso9573-13/isoamsa.ent" >
%ent-isoamsa;

<!ENTITY % ent-isoamsb
      PUBLIC "-//W3C//ENTITIES Added Math Symbols: Binary Operators for MathML 2.0//EN"
             "iso9573-13/isoamsb.ent" >
%ent-isoamsb;

<!ENTITY % ent-isoamsc
      PUBLIC "-//W3C//ENTITIES Added Math Symbols: Delimiters for MathML 2.0//EN"
             "iso9573-13/isoamsc.ent" >
%ent-isoamsc;

<!ENTITY % ent-isoamsn
      PUBLIC "-//W3C//ENTITIES Added Math Symbols: Negated Relations for MathML 2.0//EN"
             "iso9573-13/isoamsn.ent" >
%ent-isoamsn;

<!ENTITY % ent-isoamso
      PUBLIC "-//W3C//ENTITIES Added Math Symbols: Ordinary for MathML 2.0//EN"
             "iso9573-13/isoamso.ent" >
%ent-isoamso;

<!ENTITY % ent-isoamsr
      PUBLIC "-//W3C//ENTITIES Added Math Symbols: Relations for MathML 2.0//EN"
             "iso9573-13/isoamsr.ent" >
%ent-isoamsr;

<!ENTITY % ent-isogrk3
      PUBLIC "-//W3C//ENTITIES Greek Symbols for MathML 2.0//EN"
             "iso9573-13/isogrk3.ent" >
%ent-isogrk3;

<!ENTITY % ent-isomfrk
      PUBLIC "-//W3C//ENTITIES Math Alphabets: Fraktur for MathML 2.0//EN"
             "iso9573-13/isomfrk.ent" >
%ent-isomfrk;

<!ENTITY % ent-isomopf
      PUBLIC "-//W3C//ENTITIES Math Alphabets: Open Face for MathML 2.0//EN"
             "iso9573-13/isomopf.ent" >
%ent-isomopf;

<!ENTITY % ent-isomscr
      PUBLIC "-//W3C//ENTITIES Math Alphabets: Script for MathML 2.0//EN"
             "iso9573-13/isomscr.ent" >
%ent-isomscr;

<!ENTITY % ent-isotech
      PUBLIC "-//W3C//ENTITIES General Technical for MathML 2.0//EN"
             "iso9573-13/isotech.ent" >
%ent-isotech;

<!-- Entity sets from informative annex to ISO 8879:1986 (SGML) ....... -->

<!ENTITY % ent-isobox
      PUBLIC "-//W3C//ENTITIES Box and Line Drawing for MathML 2.0//EN"
             "iso8879/isobox.ent" >
%ent-isobox;

<!ENTITY % ent-isocyr1
      PUBLIC "-//W3C//ENTITIES Russian Cyrillic for MathML 2.0//EN"
             "iso8879/isocyr1.ent" >
%ent-isocyr1;

<!ENTITY % ent-isocyr2
      PUBLIC "-//W3C//ENTITIES Non-Russian Cyrillic for MathML 2.0//EN"
             "iso8879/isocyr2.ent" >
%ent-isocyr2;

<!ENTITY % ent-isodia
      PUBLIC "-//W3C//ENTITIES Diacritical Marks for MathML 2.0//EN"
             "iso8879/isodia.ent" >
%ent-isodia;

<!ENTITY % ent-isolat1
      PUBLIC "-//W3C//ENTITIES Added Latin 1 for MathML 2.0//EN"
             "iso8879/isolat1.ent" >
%ent-isolat1;

<!ENTITY % ent-isolat2
      PUBLIC "-//W3C//ENTITIES Added Latin 2 for MathML 2.0//EN"
             "iso8879/isolat2.ent" >
%ent-isolat2;

<!ENTITY % ent-isonum
      PUBLIC "-//W3C//ENTITIES Numeric and Special Graphic for MathML 2.0//EN"
             "iso8879/isonum.ent" >
%ent-isonum;

<!ENTITY % ent-isopub
      PUBLIC "-//W3C//ENTITIES Publishing for MathML 2.0//EN"
             "iso8879/isopub.ent" >
%ent-isopub;

<!-- New characters defined by MathML ............................ -->

<!ENTITY % ent-mmlextra
      PUBLIC "-//W3C//ENTITIES Extra for MathML 2.0//EN"
             "mathml/mmlextra.ent" >
%ent-mmlextra;

<!-- MathML aliases for characters defined above ................. -->

<!ENTITY % ent-mmlalias
      PUBLIC "-//W3C//ENTITIES Aliases for MathML 2.0//EN"
             "mathml/mmlalias.ent" >
%ent-mmlalias;

<!-- end of MathML Character Entity section -->]]>

<!-- Revision History:

       Initial draft (syntax = XML) 1997-05-09
          Stephen Buswell
       Revised 1997-05-14
          Robert Miner
       Revised 1997-06-29 and 1997-07-02
          Stephen Buswell
       Revised 1997-12-15
          Stephen Buswell
       Revised 1998-02-08
          Stephen Buswell
       Revised 1998-04-04
          Stephen Buswell
       Entities and small revisions 1999-02-21
          David Carlisle
       Added attribute definitionURL to ci and cn 1999-10-11
          Nico Poppelier
       Additions for MathML 2  1999-12-16
          David Carlisle
       Namespace support 2000-01-14
          David Carlisle
       XHTML Compatibility 2000-02-23
          Murray Altheim
       New content elements 2000-03-26
          David Carlisle
       Further revisions for MathML2 CR draft 2000-07-11
          David Carlisle
       Further revisions for MathML2 CR draft 2000-10-31		
          David Carlisle		
       Revisions for Unicode 3.2  2002-05-21		
          David Carlisle		
       Add width and side attributes to mtable (to align with the specification)  2002-06-05		
          David Carlisle		
       Use %XLINK.prefix rather than hardwired xlink:, add xlink:type 2002-06-12		
          David Carlisle		
       Add missing numalign and denomalign attributes for mfrac 2002-07-05		
          David Carlisle		
       Add MathMLstrict entity and related extra constraints 2002-12-05		
          David Carlisle		
       Add support for xi:schemaLocation 2003-04-05		
          David Carlisle		
       Removed actiontype from mstyle (to match spec) 2003-04-07		
          David Carlisle		
       Additional constraints for MathMLstrict code (From Simon		
          Pepping on www-math list) 2003-05-22		
          David Carlisle		
       Add missing minlabelspacing attribute (From Simon		
          Pepping on www-math list) 2003-05-22		
          David Carlisle		
       Removed restricted menclose notation checking from MathMLstrict 2003-09-08		
          David Carlisle		

-->

<!-- end of MathML 2.0 DTD  ................................................ -->
<!-- ....................................................................... -->
]===]