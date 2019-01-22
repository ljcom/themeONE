<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
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
            <span class="pull-right-container">
              <xsl:if test="(@type)='treeroot'">
                <ix class="fa fa-angle-left pull-right"></ix>
              </xsl:if>
              <xsl:if test="nbReject">
                <small class="label pull-right bg-red">
                  <xsl:value-of select="nbReject"/>
                </small>
              </xsl:if>
              <xsl:if test="nbAprv">
                <small class="label pull-right bg-green">
                  <xsl:value-of select="nbAprv"/>
                </small>
              </xsl:if>
            </span>
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
          <xsl:value-of select="caption/." />&#160;
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

        <xsl:if test="(fa/.)!=''">
          <span>
            <ix class="{fa/.}"></ix>&#160;
          </span>
        </xsl:if>
        <span>
          <xsl:value-of select="caption/." />
        </span>
        &#160;
        <!--<xsl:if test="isPending &gt; 0">
          <ix class="fa fa-asterisk" aria-hidden="true" style="font-size: 8px; position: absolute;"></ix>
        </xsl:if>-->
        <span class="pull-right-container">
          <xsl:if test="(@type)='treeroot'">
            <ix class="fa fa-angle-left pull-right"></ix>
          </xsl:if>
          <xsl:if test="nbReject">
            <small class="label pull-right bg-red" title="Records Rejected" data-toggle="tooltip">
              <xsl:value-of select="nbReject"/>
            </small>
          </xsl:if>
          <xsl:if test="nbAprv">
            <small class="label pull-right bg-orange" title="Records Need Your Approval" data-toggle="tooltip">
              <xsl:value-of select="nbAprv"/>
            </small>
          </xsl:if>
        </span>
      </a>
    </li>
  </xsl:template>


</xsl:stylesheet>