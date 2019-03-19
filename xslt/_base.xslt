<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">


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

  <xsl:template match="sqroot">
    <script>
      $('.sidebar-toggle').click(function() {
      if ($('body').hasClass('sidebar-collapse')) $('body').removeClass('sidebar-collapse');
      else $('body').addClass('sidebar-collapse');
      });

    </script>
    <div style="display:none" id="pageName">&#xA0;</div>
    <div style="display:none" id="themeName">&#xA0;</div>

    <header class="main-header">
      <a href="javascript:goHome();" class="logo visible-phone" style="text-align:left;">
        <span class="logo-mini" style="font-size:9px; text-align:center">
          <img width="30" src="OPHContent/themes/{header/info/themeFolder}/images/oph4_logo.png" alt="Logo Image" />
        </span>
        <span class="logo-lg" style="font-size:22px;">
          <div class="pull-left" style="margin-right:10px;">
            <img width="30" style="margin-top:-9px;" src="OPHContent/themes/{header/info/themeFolder}/images/oph4_logo.png" alt="Logo Image" />
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
              <img width="30" style="margin-top:-9px;" src="OPHContent/themes/{header/info/themeFolder}/images/oph4_logo.png" alt="Logo Image" />
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
                <xsl:when test="not(header/info/user/userId)">
                  <a href="#" data-toggle="modal" data-target="#login-modal">
                    <span>
                      <ix class="fa fa-sign-in"></ix>&#160;
                    </span>
                    <span>Sign in</span>
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                    <img src="OPHContent/documents/{header/info/account}/{header/info/user/userURL}" class="user-image" alt="User Image"/>
                    <span class="hidden-xs">
                      <xsl:value-of select="header/info/user/userName"/>
                    </span>
                  </a>
                  <ul class="dropdown-menu">
                    <!-- User image -->
                    <li class="user-header">
                      <img src="OPHContent/documents/{header/info/account}/{header/info/user/userURL}" class="img-circle" alt="User Image"/>
                      <p>
                        <xsl:value-of select="header/info/user/userName"/>
                        <small>
                          Active since <xsl:value-of select="header/info/user/dateCreate"/>
                        </small>
                      </p>
                    </li>
                    <!-- Menu Body -->
                    <li class="user-body">
                      <div class="row">
                        <xsl:for-each select="header/menus/menu[@code='primaryback']/submenus/submenu">
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

    
    <!-- *** LOGIN MODAL ***-->
    <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="signinLabel" aria-hidden="true">
      <div class="modal-dialog modal-sm" role="document">

        <div class="modal-content">
          <form id="signinForm" method="post">
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

              <p class="text-center text-muted">Not registered yet?</p>
              <p class="text-center text-muted">
                <a href="customer-register.html">
                  <strong>Register now</strong>
                </a>! It is easy and done in 1&#160;minute and gives you access to special discounts and much more!
              </p>

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

    <!-- *** NOTIFICATION MODAL -->
    <div id="notiModal" class="modal fade" role="dialog" tabindex="-1">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&#215;</button>
            <h4 class="modal-title" id="notiTitle">Modal Header</h4>
          </div>
          <div class="modal-body" id="notiContent">
            <p>Some text in the modal.</p>
          </div>
          <div class="modal-footer">
            <button id="modal-btn-close" type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
            <button id="modal-btn-cancel" type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
			<button id="modal-btn-confirm" type="button" class="btn btn-warning" data-dismiss="modal">Confirm</button>

          </div>
        </div>

      </div>
    </div>
    <!-- *** NOTIFICATION MODAL END -->

    <!-- Left side column. contains the logo and sidebar -->
    <aside  class="main-sidebar">
      <!-- sidebar: style can be found in sidebar.less -->
      <section id="sidebarWrapper" class="sidebar">
        <div class="overlay">
          <ix class="fas fa-spinner fa-pulse"></ix>
        </div>
      </section>
    </aside>
    <aside class="control-sidebar ">
      <!-- Create the tabs -->
      <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
        <li class="">
          <a href="#control-sidebar-theme-demo-options-tab" data-toggle="tab" aria-expanded="false">
            <ix class="fa fa-wrench"></ix>
          </a>
        </li>
        <li class="active">
          <a href="#control-sidebar-home-tab" data-toggle="tab" aria-expanded="true">
            <ix class="fa fa-home"></ix>
          </a>
        </li>
        <li class="">
          <a href="#control-sidebar-settings-tab" data-toggle="tab" aria-expanded="false">
            <ix class="fa fa-gears"></ix>
          </a>
        </li>
      </ul>
      <!-- Tab panes -->
      <div class="tab-content">
        <!-- Home tab content -->
        <div class="tab-pane active" id="control-sidebar-home-tab">
          <h3 class="control-sidebar-heading">Recent Activity</h3>
          <ul class="control-sidebar-menu">
            <li>
              <a href="javascript:void(0)">
                <ix class="menu-icon fa fa-birthday-cake bg-red"></ix>

                <div class="menu-info">
                  <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                  <p>Will be 23 on April 24th</p>
                </div>
              </a>
            </li>
            <li>
              <a href="javascript:void(0)">
                <ix class="menu-icon fa fa-user bg-yellow"></ix>

                <div class="menu-info">
                  <h4 class="control-sidebar-subheading">Frodo Updated His Profile</h4>

                  <p>New phone +1(800)555-1234</p>
                </div>
              </a>
            </li>
            <li>
              <a href="javascript:void(0)">
                <ix class="menu-icon fa fa-envelope-o bg-light-blue"></ix>

                <div class="menu-info">
                  <h4 class="control-sidebar-subheading">Nora Joined Mailing List</h4>

                  <p>nora@example.com</p>
                </div>
              </a>
            </li>
            <li>
              <a href="javascript:void(0)">
                <ix class="menu-icon fa fa-file-code-o bg-green"></ix>

                <div class="menu-info">
                  <h4 class="control-sidebar-subheading">Cron Job 254 Executed</h4>

                  <p>Execution time 5 seconds</p>
                </div>
              </a>
            </li>
          </ul>
          <!-- /.control-sidebar-menu -->

          <h3 class="control-sidebar-heading">Tasks Progress</h3>
          <ul class="control-sidebar-menu">
            <li>
              <a href="javascript:void(0)">
                <h4 class="control-sidebar-subheading">
                  Custom Template Design
                  <span class="label label-danger pull-right">70%</span>
                </h4>

                <div class="progress progress-xxs">
                  <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
                </div>
              </a>
            </li>
            <li>
              <a href="javascript:void(0)">
                <h4 class="control-sidebar-subheading">
                  Update Resume
                  <span class="label label-success pull-right">95%</span>
                </h4>

                <div class="progress progress-xxs">
                  <div class="progress-bar progress-bar-success" style="width: 95%"></div>
                </div>
              </a>
            </li>
            <li>
              <a href="javascript:void(0)">
                <h4 class="control-sidebar-subheading">
                  Laravel Integration
                  <span class="label label-warning pull-right">50%</span>
                </h4>

                <div class="progress progress-xxs">
                  <div class="progress-bar progress-bar-warning" style="width: 50%"></div>
                </div>
              </a>
            </li>
            <li>
              <a href="javascript:void(0)">
                <h4 class="control-sidebar-subheading">
                  Back End Framework
                  <span class="label label-primary pull-right">68%</span>
                </h4>

                <div class="progress progress-xxs">
                  <div class="progress-bar progress-bar-primary" style="width: 68%"></div>
                </div>
              </a>
            </li>
          </ul>
          <!-- /.control-sidebar-menu -->

        </div>
        <div id="control-sidebar-theme-demo-options-tab" class="tab-pane">
          <div>
            <h4 class="control-sidebar-heading">Layout Options</h4>
            <div class="form-group">
              <label class="control-sidebar-subheading">
                <input type="checkbox" data-layout="fixed" class="pull-right"/> Fixed layout
              </label>
              <p>Activate the fixed layout. You can't use fixed and boxed layouts together</p>
            </div>
            <div class="form-group">
              <label class="control-sidebar-subheading">
                <input type="checkbox" data-layout="layout-boxed" class="pull-right"/> Boxed Layout
              </label>
              <p>Activate the boxed layout</p>
            </div>
            <div class="form-group">
              <label class="control-sidebar-subheading">
                <input type="checkbox" data-layout="sidebar-collapse" class="pull-right"/> Toggle Sidebar
              </label>
              <p>Toggle the left sidebar's state (open or collapse)</p>
            </div>
            <div class="form-group">
              <label class="control-sidebar-subheading">
                <input type="checkbox" data-enable="expandOnHover" class="pull-right"/> Sidebar Expand on Hover
              </label>
              <p>Let the sidebar mini expand on hover</p>
            </div>
            <div class="form-group">
              <label class="control-sidebar-subheading">
                <input type="checkbox" data-controlsidebar="control-sidebar-open" class="pull-right"/> Toggle Right Sidebar Slide
              </label>
              <p>Toggle between slide over content and push content effects</p>
            </div>
            <div class="form-group">
              <label class="control-sidebar-subheading">
                <input type="checkbox" data-sidebarskin="toggle" class="pull-right"/> Toggle Right Sidebar Skin
              </label>
              <p>Toggle between dark and light skins for the right sidebar</p>
            </div>
            <h4 class="control-sidebar-heading">Skins</h4>
            <ul class="list-unstyled clearfix">
              <li style="float:left; width: 33.33333%; padding: 5px;">
                <a href="javascript:void(0)" data-skin="skin-blue" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 7px; background: #367fa9"></span>
                    <span class="bg-light-blue" style="display:block; width: 80%; float: left; height: 7px;"></span>
                  </div>
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 20px; background: #222d32"></span>
                    <span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7"></span>
                  </div>
                </a>
                <p class="text-center no-margin">Blue</p>
              </li>
              <li style="float:left; width: 33.33333%; padding: 5px;">
                <a href="javascript:void(0)" data-skin="skin-black" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
                  <div style="box-shadow: 0 0 2px rgba(0,0,0,0.1)" class="clearfix">
                    <span style="display:block; width: 20%; float: left; height: 7px; background: #fefefe"></span>
                    <span style="display:block; width: 80%; float: left; height: 7px; background: #fefefe"></span>
                  </div>
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 20px; background: #222"></span>
                    <span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7"></span>
                  </div>
                </a>
                <p class="text-center no-margin">Black</p>
              </li>
              <li style="float:left; width: 33.33333%; padding: 5px;">
                <a href="javascript:void(0)" data-skin="skin-purple" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 7px;" class="bg-purple-active"></span>
                    <span class="bg-purple" style="display:block; width: 80%; float: left; height: 7px;"></span>
                  </div>
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 20px; background: #222d32"></span>
                    <span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7"></span>
                  </div>
                </a>
                <p class="text-center no-margin">Purple</p>
              </li>
              <li style="float:left; width: 33.33333%; padding: 5px;">
                <a href="javascript:void(0)" data-skin="skin-green" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 7px;" class="bg-green-active"></span>
                    <span class="bg-green" style="display:block; width: 80%; float: left; height: 7px;"></span>
                  </div>
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 20px; background: #222d32"></span>
                    <span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7"></span>
                  </div>
                </a>
                <p class="text-center no-margin">Green</p>
              </li>
              <li style="float:left; width: 33.33333%; padding: 5px;">
                <a href="javascript:void(0)" data-skin="skin-red" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 7px;" class="bg-red-active"></span>
                    <span class="bg-red" style="display:block; width: 80%; float: left; height: 7px;"></span>
                  </div>
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 20px; background: #222d32"></span>
                    <span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7"></span>
                  </div>
                </a>
                <p class="text-center no-margin">Red</p>
              </li>
              <li style="float:left; width: 33.33333%; padding: 5px;">
                <a href="javascript:void(0)" data-skin="skin-yellow" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 7px;" class="bg-yellow-active"></span>
                    <span class="bg-yellow" style="display:block; width: 80%; float: left; height: 7px;"></span>
                  </div>
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 20px; background: #222d32"></span>
                    <span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7"></span>
                  </div>
                </a>
                <p class="text-center no-margin">Yellow</p>
              </li>
              <li style="float:left; width: 33.33333%; padding: 5px;">
                <a href="javascript:void(0)" data-skin="skin-blue-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 7px; background: #367fa9"></span>
                    <span class="bg-light-blue" style="display:block; width: 80%; float: left; height: 7px;"></span>
                  </div>
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc"></span>
                    <span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7"></span>
                  </div>
                </a>
                <p class="text-center no-margin" style="font-size: 12px">Blue Light</p>
              </li>
              <li style="float:left; width: 33.33333%; padding: 5px;">
                <a href="javascript:void(0)" data-skin="skin-black-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
                  <div style="box-shadow: 0 0 2px rgba(0,0,0,0.1)" class="clearfix">
                    <span style="display:block; width: 20%; float: left; height: 7px; background: #fefefe"></span>
                    <span style="display:block; width: 80%; float: left; height: 7px; background: #fefefe"></span>
                  </div>
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc"></span>
                    <span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7"></span>
                  </div>
                </a>
                <p class="text-center no-margin" style="font-size: 12px">Black Light</p>
              </li>
              <li style="float:left; width: 33.33333%; padding: 5px;">
                <a href="javascript:void(0)" data-skin="skin-purple-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 7px;" class="bg-purple-active"></span>
                    <span class="bg-purple" style="display:block; width: 80%; float: left; height: 7px;"></span>
                  </div>
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc"></span>
                    <span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7"></span>
                  </div>
                </a>
                <p class="text-center no-margin" style="font-size: 12px">Purple Light</p>
              </li>
              <li style="float:left; width: 33.33333%; padding: 5px;">
                <a href="javascript:void(0)" data-skin="skin-green-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 7px;" class="bg-green-active"></span>
                    <span class="bg-green" style="display:block; width: 80%; float: left; height: 7px;"></span>
                  </div>
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc"></span>
                    <span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7"></span>
                  </div>
                </a>
                <p class="text-center no-margin" style="font-size: 12px">Green Light</p>
              </li>
              <li style="float:left; width: 33.33333%; padding: 5px;">
                <a href="javascript:void(0)" data-skin="skin-red-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 7px;" class="bg-red-active"></span>
                    <span class="bg-red" style="display:block; width: 80%; float: left; height: 7px;"></span>
                  </div>
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc"></span>
                    <span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7"></span>
                  </div>
                </a>
                <p class="text-center no-margin" style="font-size: 12px">Red Light</p>
              </li>
              <li style="float:left; width: 33.33333%; padding: 5px;">
                <a href="javascript:void(0)" data-skin="skin-yellow-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 7px;" class="bg-yellow-active"></span>
                    <span class="bg-yellow" style="display:block; width: 80%; float: left; height: 7px;"></span>
                  </div>
                  <div>
                    <span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc"></span>
                    <span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7"></span>
                  </div>
                </a>
                <p class="text-center no-margin" style="font-size: 12px">Yellow Light</p>
              </li>
            </ul>
          </div>
        </div>
        <!-- /.tab-pane -->

        <!-- Settings tab content -->
        <div class="tab-pane" id="control-sidebar-settings-tab">
          <form method="post">
            <h3 class="control-sidebar-heading">General Settings</h3>

            <div class="form-group">
              <label class="control-sidebar-subheading">
                Report panel usage
                <input type="checkbox" class="pull-right" checked=""/>
              </label>

              <p>
                Some information about this general settings option
              </p>
            </div>
            <!-- /.form-group -->

            <div class="form-group">
              <label class="control-sidebar-subheading">
                Allow mail redirect
                <input type="checkbox" class="pull-right" checked=""/>
              </label>

              <p>
                Other sets of options are available
              </p>
            </div>
            <!-- /.form-group -->

            <div class="form-group">
              <label class="control-sidebar-subheading">
                Expose author name in posts
                <input type="checkbox" class="pull-right" checked=""/>
              </label>

              <p>
                Allow the user to show his name in blog posts
              </p>
            </div>
            <!-- /.form-group -->

            <h3 class="control-sidebar-heading">Chat Settings</h3>

            <div class="form-group">
              <label class="control-sidebar-subheading">
                Show me as online
                <input type="checkbox" class="pull-right" checked=""/>
              </label>
            </div>
            <!-- /.form-group -->

            <div class="form-group">
              <label class="control-sidebar-subheading">
                Turn off notifications
                <input type="checkbox" class="pull-right"/>
              </label>
            </div>
            <!-- /.form-group -->

            <div class="form-group">
              <label class="control-sidebar-subheading">
                Delete chat history
                <a href="javascript:void(0)" class="text-red pull-right">
                  <ix class="fa fa-trash-o"></ix>
                </a>
              </label>
            </div>
            <!-- /.form-group -->
          </form>
        </div>
        <!-- /.tab-pane -->
      </div>
    </aside>
    <!-- Content Wrapper. Contains page content -->
    <div id="contentWrapper" class="content-wrapper">
      <div style="padding-top: 10px; padding-right: 10px; padding-bottom: 10px; padding-left: 10px">
        <div class="overlay">
          <ix class="fas fa-spinner fa-pulse"></ix>
        </div>
      </div>
    </div>
    <!-- /.content-wrapper -->
    <footer class="main-footer">
      <div class="pull-right hidden-xs">
        <b>Version</b> 4.0
      </div>
      <strong>
        Copyright &#169; 2019 <a href="#">Operahouse.systems</a>.
      </strong> All rights reserved.
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
    <div class="control-sidebar-bg">&#160;</div>

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

  <xsl:include href="_menu.xslt" />
</xsl:stylesheet>