<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:variable name="colMenu">
    <xsl:choose>
      <xsl:when test="count(/sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)=0">12</xsl:when>
      <xsl:when test="count(/sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)=1">12</xsl:when>
      <xsl:when test="count(/sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)=2">6</xsl:when>
      <xsl:otherwise>4</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="/">
    <script>
      var meta = document.createElement('meta');
      meta.charset = "UTF-8";
      loadMeta(meta);

      var meta = document.createElement('meta');
      meta.httpEquiv = "X-UA-Compatible";
      meta.content = "IE=edge";
      loadMeta(meta);

      var meta = document.createElement('meta');
      meta.name = "viewport";
      meta.content = "width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no";
      loadMeta(meta);

      $("body").addClass("skin-blue");
      $("body").addClass("hold-transition");
      $("body").addClass("sidebar-mini");
      $("body").addClass("fixed");

      <!--loadStyle('OPHContent/cdn/bootstrap/css/bootstrap.min.css');
      loadStyle('OPHContent/cdn/font-awesome-4.7.0/css/font-awesome.min.css');

      //loadStyle('https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css');
      loadStyle('OPHContent/cdn/daterangepicker/daterangepicker.css');
      loadStyle('OPHContent/cdn/datepicker/datepicker3.css');
      loadStyle('OPHContent/cdn/iCheck/all.css');
      loadStyle('OPHContent/cdn/colorpicker/bootstrap-colorpicker.min.css');
      loadStyle('OPHContent/cdn/timepicker/bootstrap-timepicker.min.css');
      loadStyle('OPHContent/cdn/select2/select2.min.css');
      loadStyle('OPHContent/cdn/admin-LTE/css/AdminLTE.min.css');
      loadStyle('OPHContent/cdn/admin-LTE/css/skins/_all-skins.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/custom-me.css');

      loadScript('OPHContent/cdn/jQuery/jquery-2.2.3.min.js');
      loadScript('OPHContent/cdn/bootstrap/js/bootstrap.min.js');
      --><!--loadScript('OPHContent/cdn/select2/select2.full.min.js');--><!--
      loadScript('OPHContent/cdn/input-mask/jquery.inputmask.js');
      loadScript('OPHContent/cdn/input-mask/jquery.inputmask.date.extensions.js');
      loadScript('OPHContent/cdn/input-mask/jquery.inputmask.extensions.js');
      loadScript('OPHContent/cdn/moment/moment.min.js');

      loadScript('OPHContent/cdn/datepicker/bootstrap-datepicker.js');
      loadScript('OPHContent/cdn/colorpicker/bootstrap-colorpicker.min.js');
      loadScript('OPHContent/cdn/timepicker/bootstrap-timepicker.min.js');
      loadScript('OPHContent/cdn/slimScroll/jquery.slimscroll.min.js');
      loadScript('OPHContent/cdn/iCheck/icheck.min.js');
      loadScript('OPHContent/cdn/fastclick/fastclick.js');
      loadScript('OPHContent/cdn/admin-LTE/js/demo.js');-->
      loadScript('OPHContent/cdn/admin-LTE/js/app.min.js');

      document.title='Page Not Found';

      resetBrowseCookies();
      //loadContent(1);
	  
		var n=new Date(Date.now());
		$('#cp').html($('#cp').html().split('#year#').join(n.getFullYear()));
	  
    </script>
    <xsl:apply-templates select="sqroot" />
  </xsl:template>


  <xsl:template match="sqroot">

    <div style="display:none" id="pageName">&#xA0;</div>
    <div style="display:none" id="themeName">&#xA0;</div>

    <header class="main-header">
      <a href="javascript:goHome();" class="logo visible-phone" style="text-align:left;">
        <span class="logo-mini" style="font-size:9px; text-align:center">
          <img width="30" src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/oph4_logo.png" alt="Logo Image" />
        </span>
        <span class="logo-lg" style="font-size:22px;">
          <div class="pull-left" style="margin-right:10px;">
            <img width="30" style="margin-top:-9px;" src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/oph4_logo.png" alt="Logo Image" />
          </div>
          <xsl:value-of select="header/info/company" />
        </span>
      </a>
      <nav class="navbar navbar-static-top">
        <a href="#" class="sidebar-toggle visible-phone" data-toggle="push-menu" role="button" >
          <span class="sr-only">Toggle navigation</span>
        </a>
        <div id ="button-menu-phone" class="unvisible-phone" style="color:white;  margin:0; display:inline-table; margin-top:15px; margin-left:10px"
             data-toggle="collapse" data-target="#mobilemenupanel">
          <a href="#" style="color:white;">
            <span>
              <img width="30" style="margin-top:-9px;" src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/oph4_logo.png" alt="Logo Image" />
            </span>&#160;
            <xsl:value-of select="header/info/code/name"/>&#160;(<xsl:value-of select="header/info/code/id"/>)<span class="caret"></span>
          </a>
        </div>
        <div class="accordian-body collapse top-menu-div" id="mobilemenupanel" style="color:white; position:absolute; background:#222D32; z-index:100; width:100%; right:0px; top:50px; ">
          <div class="input-group sidebar-form">
            <input type="text" id="searchBox1" name="searchBox1" class="form-control" placeholder="Search..." onkeypress="return searchText(event,this.value);" value="" />
            <span class="input-group-btn">
              <button type="button" name="search" id="search-btn" class="btn btn-flat" onclick="searchText(event);">
                <ix class="fa fa-search" aria-hidden="true"></ix>
              </button>
            </span>
          </div>

          <div class="navbar-collapse pull-left collapse in" id="navbar-collapse" aria-expanded="true" style="">
            <ul class="nav navbar-nav">
              <xsl:for-each select="/sqroot/header/menus/menu[@code='sidebar']/submenus/submenu" >
                <xsl:variable name="className">
                  <xsl:choose>
                    <xsl:when test="(@type)='treeroot'">dropdown</xsl:when>
                    <xsl:when test="(@type)='label'">header</xsl:when>
                  </xsl:choose>
                </xsl:variable>

                <li class="{$className}">

                  <xsl:choose>
                    <xsl:when test="(pageURL/.)!=''">
                      <a href="{translate(pageURL/., $uppercase, $smallcase)}" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                        <xsl:if test="(fa/.)!=''">
                          <span>
                            <ix class="{fa/.}"></ix>&#160;
                          </span>
                        </xsl:if>
                        <span class="info">
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
                        <ul class="dropdown-menu" role="menu">
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
              </xsl:for-each>

            </ul>
          </div>
          <!--ul class="sidebar-menu">
            <xsl:apply-templates select="header/menus/menu[@code='sidebar']/submenus/submenu" />
          </ul-->


        </div>
        <div class="navbar-custom-menu">
          <ul class="nav navbar-nav">
            <li>
              <a style="cursor:pointer;" onclick="Sideshow.start();" data-toggle="tooltip" data-placement="bottom" title="Help?">
                <ix class="fa fa-question-circle fa-lg"></ix>
              </a>
            </li>
            <li class="dropdown user user-menu">
              <xsl:choose>
                <xsl:when test="not(/sqroot/header/info/user/userId)">
                  <a href="?code=login">
                    <span>
                      <ix class="fa fa-sign-in"></ix>&#160;
                    </span>
                    <span>Sign in</span>
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                    <img src="OPHContent/documents/{/sqroot/header/info/account}/{/sqroot/header/info/user/userURL}" class="user-image" alt="User Image"/>
                    <span class="hidden-xs">
                      <xsl:value-of select="/sqroot/header/info/user/userName"/>
                    </span>
                  </a>
                  <ul class="dropdown-menu">
                    <!-- User image -->
                    <li class="user-header">
                      <img src="OPHContent/documents/{/sqroot/header/info/account}/{/sqroot/header/info/user/userURL}" class="img-circle" alt="User Image"/>
                      <p>
                        <xsl:value-of select="/sqroot/header/info/user/userName"/>
                        <small>
                          Active since <xsl:value-of select="/sqroot/header/info/user/dateCreate"/>
                        </small>
                      </p>
                    </li>
                    <!-- Menu Body -->
                    <li class="user-body">
                      <div class="row">
                        <xsl:for-each select="/sqroot/header/menus/menu[@code='primaryback']/submenus/submenu">
                          <div class="col-xs-{$colMenu} text-center">
                            <a class="withBorder" href="{pageURL}">
                              <xsl:value-of select="caption" />&#160;
                            </a>
                          </div>
                        </xsl:for-each>
                      </div>
                    </li>
                    <!-- Menu Footer-->
                    <li class="user-footer">
                      <div class="pull-left">
                        <a href="?code=profile" class="btn btn-default btn-flat">
                          <span>
                            <ix class="fa fa-user"></ix>
                          </span>
                          <span>Profile</span>
                        </a>
                      </div>
                      <div class="pull-right">
                        <a href="javascript:signOut()" class="btn btn-default btn-flat">
                          <span>
                            <ix class="fa fa-power-off"></ix>
                          </span>
                          <span>Sign out</span>
                        </a>
                      </div>
                    </li>
                  </ul>
                </xsl:otherwise>
              </xsl:choose>
            </li>
            <xsl:if test="/sqroot/header/info/code/ShowDocInfo=1">
              <!--li>
              <a href="#" data-toggle="control-sidebar">
                <ix class="fas fa-list"></ix>
              </a>
            </li-->
            </xsl:if>
          </ul>
        </div>
      </nav>
    </header>

    <!-- *** LOGIN MODAL ***
_________________________________________________________ -->

    <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="signinLabel" aria-hidden="true">
      <div class="modal-dialog modal-sm" role="document">

        <div class="modal-content">
          <form id="signinForm" method="post" action="">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&#215;</button>
              <h4 class="modal-title" id="signinLabel">Sign in</h4>
            </div>

            <div class="modal-body">
              <div class="form-group">
                <input type="text" class="form-control" id="userid" placeholder="user id" />
              </div>
              <div class="form-group">
                <input type="password" class="form-control" id="pwd" placeholder="password" />
              </div>

              <!--p class="text-center text-muted">Not registered yet?</p>
              <p class="text-center text-muted">
                <a href="customer-register.html">
                  <strong>Register now</strong>
                </a>! It is easy and done in 1&#160;minute and gives you access to special discounts and much more!
              </p-->

            </div>
            <div class="modal-footer">

              <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
              <a href="javascript: signIn();">
                <button type="button" class="btn btn-primary">
                  <span>
                    <ix class="fa fa-sign-in"></ix>&#160;
                  </span>Sign In
                </button>
              </a>

            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- *** LOGIN MODAL END *** -->

    <!-- Left side column. contains the logo and sidebar -->
    <aside  class="main-sidebar">
      <!-- sidebar: style can be found in sidebar.less -->
      <section id="sidebarWrapper" class="sidebar">


      </section>

      <!-- /.sidebar -->
    </aside>
    <!-- Content Wrapper. Contains page content -->
    <div id="contentWrapper" class="content-wrapper" style="background:white">
      <section class="content-header">
        <h1>
          404 Error Page
        </h1>
        <ol class="breadcrumb">
          <li>
            <a href="?">
              <ix class="fa fa-dashboard"></ix> Home
            </a>
          </li>
          <li class="active">404 error</li>
        </ol>
      </section>

      <!-- Main content -->
      <section class="content">
        <div class="error-page">
          <h2 class="headline text-yellow"> 404</h2>

          <div class="error-content">
            <h3>
              <span>
                <ix class="fa fa-warning text-yellow"></ix>
              </span> Oops! Page not found.
            </h3>

            <p>
              We could not find the page you were looking for.
              Meanwhile, you may <a href="?">return to HOME</a> or try using the search form.
            </p>

            <form class="search-form" action="?">
              <div class="input-group">
                <input type="text" name="code" class="form-control" placeholder="Search"/>

                <div class="input-group-btn">
                  <button type="submit" class="btn btn-warning btn-flat">
                    <ix class="fa fa-search"></ix>
                  </button>
                </div>
              </div>
              <!-- /.input-group -->
            </form>
          </div>
          <!-- /.error-content -->
        </div>
        <!-- /.error-page -->
      </section>
    </div>
    <!-- /.content-wrapper -->
    <footer class="main-footer">
      <div class="pull-right hidden-xs">
        <b>Version</b> 4.0
      </div>
	  <div id="cp">
      <strong>
        Copyright &#169; #year# <a href="#">operahouse.systems</a>.
      </strong> All rights reserved.
	  </div>
    </footer>

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
      <!-- Create the tabs -->
      <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
        <li>
          <a href="#control-sidebar-home-tab" data-toggle="tab">
            <ix class="fa fa-home"></ix>
          </a>
        </li>
        <li>
          <a href="#control-sidebar-settings-tab" data-toggle="tab">
            <ix class="fa fa-gears"></ix>
          </a>
        </li>
      </ul>

    </aside>
    <!-- /.control-sidebar -->
    <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
    <div class="control-sidebar-bg"></div>

    <!-- ./wrapper -->
    <script>
      $(document).ready(function(){
      $("#button-menu-phone").click(function(){
      $('#right-menu-phone').removeClass("in");

      });
      $("#button-menu-phone2").click(function(){
      $('#mobilemenupanel').removeClass("in");


      });
      $('.expand-td').click(function(){
      var target = $(this).attr('data-target');
      // alert(target);
      var ids = $('.browse-data').map(function() {
      var id = this.id;
      if ('#'+id != target){
      // alert(id);
      $('#'+id).attr('class', 'browse-data accordian-body collapse');
      }
      // this.id.removeClass(in)
      // alert(this.id);
      })

      // alert(ids); // Result: a,b,c,d
      });
      });
    </script>

  </xsl:template>

  <xsl:template match="sqroot/header/menus/menu[@code='primary']/submenus/submenu/submenus/submenu">
    <li>
      <a href="{pageURL/.}">
        <xsl:value-of select="caption/." />
      </a>
    </li>
  </xsl:template>


  <xsl:include href="_menu.xslt" />
</xsl:stylesheet>
