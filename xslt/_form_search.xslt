<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">

  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="/sqroot/header">
  </xsl:template>

  <xsl:template match="/sqroot/body/bodyContent/browse/info">
  </xsl:template>
  <xsl:template match="/sqroot/body/bodyContent/browse/header">
  </xsl:template>
  <xsl:template match="/sqroot/body/bodyContent/browse/children">
  </xsl:template>
  <xsl:template match="/sqroot/body/bodyContent/browse/content/row">
    
    <li>
      <a class="info" href="#" onclick="javascript:loadForm('{@code}', '{@GUID}')">
        <span>
          <ix class="fa fa-header"></ix>
        </span><xsl:value-of select="fields/field/." />
      </a>
    </li>

  </xsl:template>
  
</xsl:stylesheet>


