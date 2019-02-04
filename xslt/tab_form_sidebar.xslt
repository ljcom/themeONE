<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">

  <xsl:output method="xml" indent="yes"/>
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:variable name="docStatus" select="sqroot/body/bodyContent/form/info/state/status/." />

  <xsl:template match="/">
    <xsl:variable name="settingmode">
      <xsl:value-of select="/sqroot/body/bodyContent/form/info/settingMode/."/>
    </xsl:variable>
    <xsl:variable name="gotoActive"></xsl:variable>
    <xsl:if test="count(sqroot/body/bodyContent/form/talks/talk)=0">active</xsl:if>
    <xsl:variable name="chatActive">
      <xsl:if test="count(sqroot/body/bodyContent/form/talks/talk)>0">active</xsl:if>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="/sqroot/body/bodyContent/form/info/permission/ShowDocInfo/.=1">
        <div class="user-panel">
          <div class="pull-left image">
            <xsl:variable name="sname">
              <xsl:choose>
                <xsl:when test="sqroot/header/info/code/shortName != ''">
                  <xsl:value-of select="/sqroot/header/info/code/shortName" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>

                    <xsl:when test="sqroot/header/info/code/settingMode = 't' or sqroot/header/info/code/settingMode = 'T'">
                      <xsl:value-of select="translate(substring(sqroot/header/info/code/id, 3, 4), $smallcase, $uppercase)" />
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="translate(substring(sqroot/header/info/code/id, 1, 2), $smallcase, $uppercase)" />
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
              <span class="fa-layers fa-fw fa-4x">
                <ix class="fas fa-4x fa-inverse fa-square"></ix>
                <span class="fa-layers-text fa-text-1x" data-fa-transform="shrink-11.5 down-4">
                  <p style="padding:0;margin:0">
                    <xsl:value-of select="translate(substring($sname, 1, 2), $smallcase, $uppercase)" />
                  </p>
                  <p style="padding:0;margin:0">
                  <xsl:value-of select="translate(substring($sname, 3, 2), $smallcase, $uppercase)" />
                  </p>
                </span>
              </span>
            </div>
          <div class="pull-left info">
            <p>
              <div class="dn-panel" data-toggle="tooltip" title="Doc Number" data-placement="right">
                <xsl:if test="$settingmode='T'">
                  <xsl:value-of select="sqroot/body/bodyContent/form/info/docNo"/>&#160;
                </xsl:if>
              </div>
            </p>

            <a href="#">
              <xsl:choose>
                <xsl:when test="$settingmode='T'">
                  <xsl:value-of select="sqroot/body/bodyContent/form/info/refNo/."/>&#160;
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="sqroot/body/bodyContent/form/info/id/."/>&#160;
                </xsl:otherwise>
              </xsl:choose>
            </a>
          </div>
        </div>

        <!-- search form -->
        <!--form action="#" method="get" class="sidebar-form">
      <div class="input-group">
        <input type="text" id="searchBox" name="q" class="form-control" placeholder="Search..." />
        <span class="input-group-btn">
          <button type="submit" name="search" id="search-btn" class="btn btn-flat">
            <ix class="fa fa-search" aria-hidden="true"></ix>
          </button>
        </span>
      </div>
    </form-->
        <!-- sidebar menu: : style can be found in sidebar.less -->
        
        <ul class="sidebar-menu">
          <xsl:if test="(sqroot/body/bodyContent/form/children) and (sqroot/body/bodyContent/form/info/GUID)!='00000000-0000-0000-0000-000000000000'">
            <li class="treeview" id ="gotoPanel">
              <a href="#">
                <span>
                  <ix class="fa  fa-arrow-circle-right"></ix>
                </span>
                <span class="info">&#160;GO TO</span>
                <span class="pull-right-container">
                  <ix class="fa fa-angle-left pull-right"></ix>
                </span>
              </a>
              <ul class="treeview-menu view-left-sidebar">
                <li>
                  <a href="#" onclick="$(&quot;a[href='#tab_1']&quot;).click()">
                    <span>
                      <ix class="fa fa-header"></ix>
                    </span>&#160;HEADER
                  </a>
                </li>
                <li>
                  <xsl:apply-templates select="sqroot/body/bodyContent/form/children"/>
                </li>
              </ul>
            </li>
          </xsl:if>

          <!--Document Information-->
          <li class="treeview active" id="docInfoPanel">
            <a href="#">
              <span>
                <ix class="fa fa-info-circle"></ix>
              </span>
              <span class="info">&#160;DOCUMENT INFORMATION</span>
              <span class="pull-right-container">
                <ix class="fa fa-angle-left pull-right"></ix>
              </span>
            </a>
            <xsl:apply-templates select="sqroot/body/bodyContent/form/info"/>
          </li>

          <!--Approvals-->
          <xsl:if test="sqroot/body/bodyContent/form/approvals/approval" >
            <li class="treeview" id="aprvPanel">
              <a href="#">
                <span>
                  <ix class="fa fa-users"></ix>
                </span>
                <span class="info">&#160;APPROVAL LIST</span>
                <span class="pull-right-container">
                  <ix class="fa fa-angle-left pull-right"></ix>
                </span>
              </a>
              <ul class="treeview-menu view-left-sidebar">
                <li>
                  <dl id="approval-info">
                    <xsl:for-each select="sqroot/body/bodyContent/form/approvals/approval/.">
                      <dt style="margin: 10px 0 0 0;">
                        <xsl:choose>
                          <xsl:when test="@status = 400">
                            <ix class="fa fa-check-circle"></ix>
                          </xsl:when>
                          <xsl:otherwise>
                            <ix class="fa fa-minus-circle"></ix>
                          </xsl:otherwise>
                        </xsl:choose>
                        &#160;<xsl:value-of select="name"/><!--(Lv. <xsl:value-of select="@level"/>)-->
                        <br/>
                        <xsl:if test="@status =0">
                          &#160;

                          <div class="input-group">
                            <input type="password" id="txtpwd{aprvUserGUID}" name="message" placeholder="Type Password ..." class="form-control" />
                            <span class="input-group-btn">
                              <button type="button" class="btn btn-primary btn-flat" style="color:white;background-color: #ff9900" onclick="javascript:executeFunction('{/sqroot/body/bodyContent/form/info/code/.}','{/sqroot/body/bodyContent/form/info/GUID/.}','execute','21','{aprvUserGUID}' )">Approve</button>
                            </span>
                          </div>

                        </xsl:if>
                      </dt>

                      <dd style="margin-left:15px;">
                        <xsl:value-of select="date"/>
                      </dd>

                      <!--<xsl:choose>
                    <xsl:when test="@status = 400">
                      <dt>
                        <ix class="fa fa-check-circle"></ix> 
                          <xsl:value-of select="name"/> (Lv. <xsl:value-of select="@level"/>)
                      </dt>
                      <dd style="margin-left:15px;"><xsl:value-of select="date"/></dd>
                    </xsl:when>
                    <xsl:otherwise>
                      <dt>
                        <ix class="fa fa-minus-circle"></ix>
                          <xsl:value-of select="name"/> (Lv. <xsl:value-of select="@level"/>)
                      </dt>
                      <dd style="margin-left:15px;"><xsl:value-of select="date"/></dd>
                    </xsl:otherwise>
                  </xsl:choose>-->
                    </xsl:for-each>
                  </dl>
                </li>
              </ul>
            </li>
          </xsl:if>

          <xsl:if test="$settingmode!='C' and /sqroot/body/bodyContent/form/info/permission/ShowDocTalk/.=1">
            <script>
              setTimeout(function () { refreshTalk('<xsl:value-of select="sqroot/body/bodyContent/form/info/GUID" />', '', 20); }, 1000 * 60);
            </script>

            <li class="treeview" id="docTalkPanel">
              <a href="#">
                <span>
                  <ix class="fa fa-comments"></ix>
                </span>
                <span>&#160;DOC TALK</span>
                <span class="pull-right-container">
                  <ix class="fa fa-angle-left pull-right"></ix>
                </span>
              </a>

              <ul class="treeview-menu view-left-sidebar">
                <li>
                  <div id="chatMessages" class="direct-chat-messages">
                    <xsl:apply-templates select="sqroot/body/bodyContent/form/talks/talk"/>
                    <script>
                      var d = $('.direct-chat-messages');
                      d.scrollTop(d.prop("scrollHeight"));
                    </script>
                    <!-- /.direct-chat-msg -->
                  </div>
                </li>
                <li>
                  <div class="input-group">
                    <input type="text" id="message" name="message" placeholder="Type Message ..." class="form-control" onkeypress="javascript:enterTalk('{@GUID}', event, '20')" autocomplete="off"/>
                    <span class="input-group-btn">
                      <button type="button" class="btn btn-primary btn-flat" onclick="javascript:submitTalk('{@GUID}', '20')">Send</button>
                    </span>
                  </div>

                </li>
              </ul>
            </li>
          </xsl:if>
        </ul>
      </xsl:when>
      <xsl:otherwise>
        <script>
          $("#searchBox").val(getSearchText());
          var c=getQueryVariable('code').toLowerCase();
          try {
          $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode.parentNode.parentNode.parentNode).addClass('active');
          $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode.parentNode.parentNode).addClass('active');
          $($('.treeview').children().find('a[href$="='+c+'"]')[0].parentNode).addClass('active');
          } catch(e) {}
        </script>

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
          <input type="text" id="searchBox" name="searchBox" class="form-control" placeholder="Search..." onkeypress="return searchText(event, this.value);" value="" />
          <span class="input-group-btn">
            <button type="button" name="search" id="search-btn" class="btn btn-flat" onclick="return searchText(event);">
              <ix class="fa fa-search" aria-hidden="true"></ix>
            </button>
          </span>
        </div>
        <ul class="sidebar-menu" data-widget="tree">
          <xsl:apply-templates select="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu" />
        </ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/form/children">
    <xsl:apply-templates  select="child"/>
  </xsl:template>

  <xsl:template match="child">
    <a href="#" onclick="$(&quot;a[href='#tab_{code/.}']&quot;).click()" >
      <span>
        <ix class="fa fa-list-alt"></ix>
      </span>&#160;
      <xsl:value-of select="childTitle"/>
    </a>

  </xsl:template>

  <xsl:include href="_form_sidebar.xslt" />
  <xsl:include href="_menu.xslt" />
</xsl:stylesheet>


