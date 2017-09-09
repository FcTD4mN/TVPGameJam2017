return [===[
<!--
    This is the HTML 4.01 Frameset DTD, which should be
    used for documents with frames. This DTD is identical
    to the HTML 4.01 Transitional DTD except for the
    content model of the "HTML" element: in frameset 
    documents, the "FRAMESET" element replaces the "BODY" 
    element.

          Draft: $Date: 1999/12/24 23:37:45 $

          Authors:
              Dave Raggett <dsr@w3.org>
              Arnaud Le Hors <lehors@w3.org>
              Ian Jacobs <ij@w3.org>

    Further information about HTML 4.01 is available at:

          http://www.w3.org/TR/1999/REC-html401-19991224.
-->
<!ENTITY % HTML.Version "-//W3C//DTD HTML 4.01 Frameset//EN"
  -- Typical usage:

    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
            "http://www.w3.org/TR/html4/frameset.dtd">
    <html>
    <head>
    ...
    </head>
    <frameset>
    ...
    </frameset>
    </html>
-->

<!ENTITY % HTML.Frameset "INCLUDE">
<!ENTITY % HTML4.dtd PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
%HTML4.dtd;
]===]