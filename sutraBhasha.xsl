<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <!-- Root HTML wrapper -->
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title><xsl:value-of select="/document/@title"/></title>
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <main>
                    <xsl:apply-templates select="/document"/>
                </main>
            </body>
        </html>
    </xsl:template>
    
    <!-- Remove xml-stylesheet PI -->
    <xsl:template match="processing-instruction('xml-stylesheet')"/>
    
    <!-- Document becomes top-level heading -->
    <xsl:template match="document">
        <h1 class="site-title ">
            <xsl:value-of select="@name"/>
        </h1>
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- adhyaya heading -->
    <xsl:template match="adhyaya">
        <h2 class="adhyaya-title">
            <xsl:value-of select="adhyaya-heading"/>
        </h2>
        <xsl:apply-templates select="pada"/>
    </xsl:template>
    
    <!-- introduction -->
    <xsl:template match="introduction">
        <xsl:variable name="adhyayaIndex" select="count(ancestor::adhyaya/preceding-sibling::adhyaya) + 1"/>
        <xsl:variable name="introIndex" select="count(preceding-sibling::introduction) + 1"/>
        <div id="ADY{format-number($adhyayaIndex, '00')}_I{format-number($introIndex, '00')}">
            <xsl:attribute name="class">
                <xsl:text>introduction</xsl:text>
                <xsl:if test="em[@type='shloka']">
                    <xsl:text> shloka</xsl:text>
                </xsl:if>
            </xsl:attribute>
            <p><xsl:apply-templates/></p>
        </div>
    </xsl:template>
    
    
    
    <!-- sutra -->
    <xsl:template match="sutra">
        <div class="sutra subtitle">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
    <!-- shloka -->
    <xsl:template match="shloka">
        <div class="shloka">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
    <!-- bhashya -->
    <xsl:template match="bhashya">
        <div class="bhashya">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- Explicitly copy <br/> tags as HTML line breaks -->
    <xsl:template match="br">
        <br/>
    </xsl:template>
    
</xsl:stylesheet>
