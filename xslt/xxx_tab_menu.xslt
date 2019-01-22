<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template match="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu">
    <div class="panel top-menu-onphone">
      <a class="top-envi" data-toggle="collapse" data-parent="#accordion2" href="#{@idMenu}">
        <xsl:value-of select="caption/." />&#160;<span class="caret"></span>
      </a>
      <div id="{@idMenu}" class="panel-collapse collapse">
        <ul class="treeview">
          <xsl:if test="(@type)='treeroot'">
            <xsl:apply-templates select="submenus/submenu[@type='treeview']" />&#160;
            <xsl:apply-templates select="submenus/submenu[@type='label']" />&#160;
          </xsl:if>
        </ul>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu[@type='treeview']">
    <li>
      <a data-toggle="collapse" data-parent="#accordion{../../@GUID}" href="#{@idMenu}">
        <xsl:value-of select="caption/." />
      </a>
      <div id="{@idMenu}" class="panel-collapse collapse">
        <ul class="panel-group">
          <xsl:apply-templates select="submenus/submenu[@type='treeview']" />&#160;
          <xsl:apply-templates select="submenus/submenu[@type='label']" />&#160;
        </ul>
      </div>
    </li>
  </xsl:template>

  <xsl:template match="submenus/submenu[@type='treeview']">
    <li>
      <a data-toggle="collapse" data-parent="#accordion{../../@GUID}" href="#{@idMenu}">
        <xsl:value-of select="caption/." />
        &#160;
        <span class="caret"></span>
      </a>
      <div id="{@idMenu}" class="panel-collapse collapse">
        <ul class="panel-group">
          <xsl:apply-templates select="submenus/submenu[@type='treeview']" />&#160;
          <xsl:apply-templates select="submenus/submenu[@type='label']" />&#160;
        </ul>
      </div>
    </li>
  </xsl:template>

  <xsl:template match="submenus/submenu[@type='label']">
    <li>
      <a href="{pageURL/.}">
        <xsl:value-of select="caption/." />
        &#160;
        <xsl:if test="isPending &gt; 0">
          <ix class="fa fa-asterisk" aria-hidden="true" style="font-size: 8px; position:absolute"></ix>
        </xsl:if>
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>