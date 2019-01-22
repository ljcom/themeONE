<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu">
    <xsl:variable name="className">
      <xsl:choose>
        <xsl:when test="(@type)='treeroot'">treeview main-menu-a</xsl:when>
        <xsl:when test="(@type)='label'">header</xsl:when>
      </xsl:choose>
    </xsl:variable>

    <li class="{$className}">
      <xsl:choose>
        <xsl:when test="(pageURL/.)!=''">
          <a href="{translate(pageURL/., $uppercase, $smallcase)}">
            <xsl:if test="(fa/.)!=''">
              <span>
                <ix class="{fa/.}"></ix>&#160;
              </span>
            </xsl:if>
            <span>
              <xsl:value-of select="caption/." />
            </span>
            <xsl:choose>
              <xsl:when test="(@type)='treeroot'">
                <span class="pull-right-container">
                  <ix class="fa fa-angle-left pull-right"></ix>
                </span>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="tCount/.>0">
                  <span class="pull-right-container">
                    <span class="label label-primary pull-right">
                      <xsl:value-of select="tCount/." />
                    </span>
                  </span>
                </xsl:if>

              </xsl:otherwise>
            </xsl:choose>
          </a>
          <xsl:if test="(@type)='treeroot'">
            <ul class="treeview-menu browse-left-sidebar">
              <xsl:apply-templates select="submenus/submenu[@type='treeview']" />&#160;
              <xsl:apply-templates select="submenus/submenu[@type='label']" />&#160;
            </ul>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <span>
            <xsl:value-of select="caption/." />
          </span>
          <xsl:if test="tCount/.>0">
            <span class="pull-right-container">
              <span class="label label-primary pull-right">
                <xsl:value-of select="tCount/." />
              </span>
            </span>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </li>

  </xsl:template>

  <xsl:template match="submenus/submenu[@type='treeview']">
    <li class="treeview">
      <a href="{translate(pageURL/., $uppercase, $smallcase)}">
        <span>
          <xsl:if test="(fa/.)!=''">
            <ix class="{fa/.}"></ix>&#160;
          </xsl:if>
          <span>
            <xsl:value-of select="caption/." />
          </span>
        </span>
        <span class="pull-right-container">
          <ix class="fa fa-angle-left pull-right"></ix>
        </span>
      </a>
      <ul class="treeview-menu browse-left-sidebar" >
        <xsl:apply-templates select="submenus/submenu[@type='treeview']" />&#160;
        <xsl:apply-templates select="submenus/submenu[@type='label']" />&#160;
      </ul>
    </li>

  </xsl:template>

  <xsl:template match="submenus/submenu[@type='label']">
    <script>//label</script>
    <li>
      <a href="{translate(pageURL/., $uppercase, $smallcase)}">
        <span>
          <xsl:if test="(fa/.)!=''">
            <ix class="{fa/.}"></ix>&#160;
          </xsl:if>
          <span>
            <xsl:value-of select="caption/." />
          </span>
          <xsl:if test="tCount/.>0">
            <span class="pull-right-container">
              <span class="label label-primary pull-right">
                <xsl:value-of select="tCount/." />
              </span>
            </span>
          </xsl:if>
        </span>
        &#160;
        <xsl:if test="isPending &gt; 0">
          <ix class="fa fa-asterisk" aria-hidden="true" style="font-size: 8px; position: absolute;"></ix>
        </xsl:if>
        <!--<xsl:if test="tRecord &gt; 0">
          <span class="label label-default">
            <xsl:value-of select="tRecord"/>
          </span>
        </xsl:if>-->
      </a>
    </li>
  </xsl:template>

  <xsl:template match="sqroot/header/menus/menu[@code='newdocument']/submenus/submenu">
    <li style="height:170px;text-align:center;">
      <a href="{translate(pageURL/., $uppercase, $smallcase)}">
        <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/module.png" />
        <h4>
          <xsl:value-of select="translate(substring(code/.,1,2), $smallcase, $uppercase)" />&#160;
          <br />
          <xsl:value-of select="translate(substring(code/.,3,2), $smallcase, $uppercase)" />&#160;
        </h4>
        <p style="width:150px">
          <span>
            <xsl:value-of select="caption/." />
          </span>
          <xsl:if test="tCount/.>0">
            <span class="pull-right-container">
              <span class="label label-primary pull-right">
                <xsl:value-of select="tCount/." />
              </span>
            </span>
          </xsl:if>
        </p>
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>