<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <script>
      $("#searchBox").val(getSearchText());
      var c=getQueryVariable('code').toLowerCase();
      try {
      $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode.parentNode.parentNode.parentNode).addClass('active');
      $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode.parentNode).addClass('active');
      $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode).addClass('active');
      } catch(e) {}
    </script>
    <!-- search form -->
    <!--<form method="get" class="sidebar-form">-->
    <div class="user-panel">
      <div class="pull-left image">
        <img src="OPHContent/documents/{sqroot/header/info/account}/{sqroot/header/info/user/userURL}" class="img-circle" alt="User Image" />
      </div>
      <div class="pull-left info">
        <p>
          <xsl:value-of select="sqroot/header/info/user/userName"/>
        </p>
        <a href="#">
          <ix class="fa fa-circle text-success"></ix> Online
        </a>
      </div>
    </div>
    <div class="input-group sidebar-form">
      <input type="text" id="searchBox" name="searchBox" class="form-control" placeholder="Search..." onkeypress="return searchText(event,this.value);" value="" />
      <span class="input-group-btn">
        <button type="button" name="search" id="search-btn" class="btn btn-flat" onclick="searchText(event);">
          <ix class="fa fa-search" aria-hidden="true"></ix>
        </button>
      </span>
    </div>
    <!--</form>-->
    <!-- sidebar menu: : style can be found in sidebar.less -->
    <ul class="sidebar-menu">
      <xsl:apply-templates select="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu" />
    </ul>
  </xsl:template>

  <xsl:include href="_menu.xslt" />

</xsl:stylesheet>
