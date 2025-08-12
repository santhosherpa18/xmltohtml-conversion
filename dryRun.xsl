<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- Still HTML output with indentation -->
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
   
    <!-- === NEW: produce a real HTML wrapper and link CSS === -->
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title><xsl:value-of select="/*/@title"/></title>
                <!-- Link your CSS so browser applies styles -->
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <!-- apply templates to the document element (keeps your element names) -->
                <xsl:apply-templates select="/*"/>
            </body>
        </html>
    </xsl:template>
    
    <!-- === NEW: prevent copying xml-stylesheet PI into the output === -->
    <xsl:template match="processing-instruction('xml-stylesheet')"/>
    
    <!-- Identity template (unchanged) -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Your existing shloka ID generation (kept as-is) -->
    <xsl:template match="shloka">
        <xsl:variable name="chapter" select="parent::chapter"/>
        <xsl:variable name="chapterIndex" select="count($chapter/preceding-sibling::chapter) + 1"/>
        <xsl:variable name="shlokaIndex" select="count(preceding-sibling::shloka) + 1"/>
        
        <xsl:copy>
            <xsl:attribute name="id">
                <xsl:text>SMV_C</xsl:text>
                <xsl:value-of select="format-number($chapterIndex, '00')"/>
                <xsl:text>_S</xsl:text>
                <xsl:value-of select="format-number($shlokaIndex, '00')"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*[name() != 'id']"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Your existing introduction ID generation (kept as-is) -->
    <xsl:template match="introduction">
        <xsl:variable name="chapter" select="parent::chapter"/>
        <xsl:variable name="chapterIndex" select="count($chapter/preceding-sibling::chapter) + 1"/>
        <xsl:variable name="introIndex" select="count(preceding-sibling::introduction) + 1"/>
        
        <xsl:copy>
            <xsl:attribute name="id">
                <xsl:text>SMV_C</xsl:text>
                <xsl:value-of select="format-number($chapterIndex, '00')"/>
                <xsl:text>_I</xsl:text>
                <xsl:value-of select="format-number($introIndex, '00')"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*[name() != 'id']"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    
</xsl:stylesheet>
