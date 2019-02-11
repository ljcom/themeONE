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
            <div class="image image-envi data-logo" style="border: 0px;">

              <span class="fa-layers fa-fw">
                <ix class="fas fa-2x fa-file fa-inverse"></ix>
                <span class="fa-layers-text" data-fa-transform="shrink-11.5 down-3"
                  style="font-weight:900;font-family:arial;font-size:9pt;color:black">
                  <br/>
                  <br/>
                  <xsl:value-of select="translate(substring($sname, 1, 2), $smallcase, $uppercase)" />
                  <br/>
                  <xsl:value-of select="translate(substring($sname, 3, 2), $smallcase, $uppercase)" />
                </span>
              </span>
            </div>
          </div>
          <div class="pull-left info">
            <p>
              <div class="dn-panel" data-toggle="tooltip" title="Doc Number" data-placement="right">
                <xsl:if test="$settingmode='T'">
                  <xsl:value-of select="sqroot/body/bodyContent/form/info/docNo"/>
                </xsl:if>
              </div>
            </p>
            
            <a href="#">
              <xsl:choose>
                <xsl:when test="$settingmode='T'">
                  <xsl:value-of select="sqroot/body/bodyContent/form/info/refNo/."/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="sqroot/body/bodyContent/form/info/id/."/>
                </xsl:otherwise>
              </xsl:choose>
            </a>
          </div>
        </div>
        <!-- search form -->

        <!--div class="input-group sidebar-form">
          <input type="text" id="searchBox" name="searchBox" class="form-control" placeholder="Search..." onkeypress="return searchText(event,this.value);" value="" />
          <span class="input-group-btn">
            <button type="button" name="search" id="search-btn" class="btn btn-flat" onclick="searchText(event);">
              <ix class="fa fa-search" aria-hidden="true"></ix>
            </button>
          </span>
        </div-->
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <div class="input-group sidebar-form">
        <ul class="sidebar-menu">

          <xsl:if test="(sqroot/body/bodyContent/form/children) and (sqroot/body/bodyContent/form/info/GUID)!='00000000-0000-0000-0000-000000000000'">
            <li class="treeview" id ="gotoPanel">
              <a href="#">
                <span>
                  <ix class="fa  fa-arrow-circle-right"></ix>
                </span>
                <span>&#160;GO TO</span>
                <span class="pull-right-container">
                  <ix class="fa fa-angle-left pull-right"></ix>
                </span>
              </a>
              <ul class="treeview-menu view-left-sidebar">
                <li>
                  <a href="#header_title">
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
              <span>&#160;DOCUMENT INFORMATION</span>
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
                <span>&#160;APPROVAL LIST</span>
                <span class="pull-right-container">
                  <ix class="fa fa-angle-left pull-right"></ix>
                </span>
              </a>
              <ul class="treeview-menu view-left-sidebar">
                <li>
                  <div id="approval-info">
                    <table class="fixed-table">
                      <xsl:for-each select="sqroot/body/bodyContent/form/approvals/approval/.">
                        <xsl:variable name="aprvstat">
                          <xsl:choose>
                            <xsl:when test="@status = 400">Approved</xsl:when>
                            <xsl:when test="@status = 300">Rejected</xsl:when>
                            <xsl:otherwise>Not Yet Approved</xsl:otherwise>
                          </xsl:choose>
                        </xsl:variable>
                        <tr data-toggle="tooltip" title="{$aprvstat}">
                          <td width="25px" valign="bottom" style="padding-bottom:5px">
                            <xsl:choose>
                              <xsl:when test="@status = 400">
                                <ix class="fa fa-check-circle fa-lg" />
                              </xsl:when>
                              <xsl:when test="@status = 300">
                                <ix class="fa fa-times-circle fa-lg" style="color:orangered" />
                              </xsl:when>
                              <xsl:otherwise>
                                <ix class="fa fa-minus-circle fa-lg" style="color:darkgray" />
                              </xsl:otherwise>
                            </xsl:choose>
                          </td>
                          <td valign="bottom" style="padding-bottom:5px">
                            <xsl:if test="date">
                              <span class="pull-right" style="font-size:11px">
                                <xsl:value-of select="date" />&#160;<ix class="fa fa-clock-o fa-fw" />
                              </span>
                            </xsl:if>
                            <span class="pull-left">
                              <xsl:choose>
                                <xsl:when test="date">
                                  <strong>
                                    <xsl:value-of select="name"/>
                                  </strong>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:value-of select="name"/>
                                </xsl:otherwise>
                              </xsl:choose>
                            </span>
                          </td>
                        </tr>
                      </xsl:for-each>
                    </table>
                  </div>
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
        </div>
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
        <ul class="sidebar-menu">
          <xsl:apply-templates select="sqroot/header/menus/menu[@code='sidebar']/submenus/submenu" />
        </ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <xsl:template match="sqroot/body/bodyContent/form/children">
    <xsl:apply-templates  select="child"/>
  </xsl:template>

  <xsl:template match="child">
    <a href="#child{code/.}{/sqroot/body/bodyContent/form/info/GUID/.}">
      <span>
        <ix class="fa fa-list-alt"></ix>
      </span>&#160;
      <xsl:value-of select="childTitle"/>
    </a>

  </xsl:template>
  
  <xsl:include href="_form_sidebar.xslt" />
  <xsl:include href="_menu.xslt" />
</xsl:stylesheet>


