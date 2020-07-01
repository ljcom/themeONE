<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">

  <xsl:template match="/">
    <script>
      $("#searchBox").val(getSearchText());
      
      //try {
      //$($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode.parentNode.parentNode.parentNode).addClass('active');
      //$($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode.parentNode).addClass('active');
      //$($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode).addClass('active');
      //} catch(e) {}
	  	  setTimeout(function() {
		  var c=getQueryVariable('code').toLowerCase();
		  try {
		  $($('.sidebar-menu').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode.parentNode.parentNode.parentNode).addClass('active');
		  $($('.sidebar-menu').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode.parentNode).addClass('active');
		  $($('.sidebar-menu').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode).addClass('menu-open');
		  $($('.sidebar-menu').children().find('a[href$="='+c+'"]')[0].parentNode).addClass('active');
		  } catch(e) {}
		 }, 1000);
    </script>
	
    <!-- search form -->
    <!--<form method="get" class="sidebar-form">-->
    <div class="user-panel">
      <div class="pull-left image">
        <img src="OPHContent/documents/{sqroot/header/info/suba}/{sqroot/header/info/user/userURL}" class="img-circle" alt="User Image" />
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
      <input type="text" id="searchBox" name="searchBox" class="form-control" placeholder="Search..." onkeypress="return searchText(event, this.value);" value="" />
      <span class="input-group-btn">
        <button type="button" name="search" id="search-btn" class="btn btn-flat" onclick="searchText(event);">
          <ix class="fa fa-search" aria-hidden="true"></ix>
        </button>
      </span>
    </div>
    <!--</form>-->
    <!-- sidebar menu: : style can be found in sidebar.less -->
    <ul class="sidebar-menu">
      <li class="treeview" id="tabMenu">
		<a href="#">
              <span>
                <ix class="fa fa-bars"></ix>
              </span>
              <span class="info">&#160;MENU</span>
              <span class="pull-right-container">
                <ix class="fa fa-angle-left pull-right"></ix>
              </span>
		</a>
		<ul class="treeview-menu browse-left-sidebar">
			<xsl:apply-templates select="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu" />
		
		</ul>			
  	  </li>
    </ul>
	
	
  </xsl:template>

  <xsl:include href="_menu.xslt" />  
  </xsl:stylesheet>
  