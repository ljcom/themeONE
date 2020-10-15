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
    
    <li class="searchres">
      <a class="" onclick="javascript:loadForm('{@code}', '{@GUID}')">
        <span>
          <ix class="fa fa-header"></ix>
        </span>
		<xsl:apply-templates select="fields/field" />
      </a>
    </li>

  </xsl:template>
  
  <xsl:template match="fields/field" >
	<xsl:if test=".!=''">
	<xsl:value-of select="@title" />:&#160;<xsl:value-of select="." />&#160;<br/>
	</xsl:if>
  </xsl:template>
</xsl:stylesheet>


