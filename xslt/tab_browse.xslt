<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>

  <xsl:variable name="state" select="/sqroot/body/bodyContent/browse/info/curState/@substateCode" />
  <xsl:variable name="allowAccess" select="/sqroot/body/bodyContent/browse/info/permission/allowAccess" />
  <xsl:variable name="allowForce" select="/sqroot/body/bodyContent/browse/info/permission/allowForce" />
  <xsl:variable name="allowDelete" select="/sqroot/body/bodyContent/browse/info/permission/allowDelete" />
  <xsl:variable name="allowWipe" select="/sqroot/body/bodyContent/browse/info/permission/allowWipe" />
  <xsl:variable name="allowOnOff" select="/sqroot/body/bodyContent/browse/info/permission/allowOnOff" />
  <xsl:variable name="settingMode" select="/sqroot/header/info/code/settingMode" />
  <!--Table colspan-->
  <xsl:variable name="cMandatory">
    <xsl:value-of select="count(sqroot/body/bodyContent/browse/header/column[@mandatory=1])"/>
  </xsl:variable>
  <xsl:variable name="cSummary">
    <xsl:choose>
      <xsl:when test="sqroot/body/bodyContent/browse/header/column[@mandatory=0]">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="cDelegated">
    <xsl:value-of select="sqroot/body/bodyContent/browse/info/isDelegated"/>
  </xsl:variable>
  <xsl:variable name="cDelegator">
    <xsl:choose>
      <xsl:when test="sqroot/body/bodyContent/browse/info/isDelegator = 0">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="tMode">
    <xsl:choose>
      <xsl:when test="$settingMode='T'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="tcolspan" select="$cMandatory + $cSummary + $cDelegated + $cDelegator + $tMode + 1"/>

  <xsl:template match="/">
    <!--Re-Modeled by eLs-->
    <script>
      //loadScript('OPHContent/cdn/select2/select2.full.min.js');
      <xsl:if test="sqroot/body/bodyContent/browse/info/buttons">
        buttons=<xsl:value-of select="sqroot/body/bodyContent/browse/info/buttons"/>;
        loadExtraButton(buttons, 'browse-action-button');
      </xsl:if>


      setCookie('stateid','<xsl:value-of select="$state" />');

    </script>

    <!--Delegator Action Modal-->
    <xsl:if test="sqroot/body/bodyContent/browse/info/isDelegator = 1">
      <div id="delegatorModal" class="modal fade" role="dialog">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="delegatorModal(0, '{sqroot/header/info/code/id}')">
                <span aria-hidden="true">&#215;</span>
              </button>
              <h3>Are you sure you want to revoke your delegation?</h3>
            </div>
            <div class="modal-body">
              <p>
                Since you have delegated this module to someone else, you need to revoke your delegation to gain your full access to this module.
                But if you choose not to revoke your delegation, you will have no fully access to this module.
              </p>
              <p>If you want to set / modify your delegation later, please abandon this notification and go to your menu profile instead.</p>
            </div>
            <div class="modal-footer">
              <button id="btnRevokeLater" type="button" class="btn btn-default" data-dismiss="modal" onclick="delegatorModal(false)">No, I'll do it later</button>
              <button id="btnRevoke" type="button" class="btn btn-primary" data-loading-text="Revoking in process..." onclick="delegatorModal(true)">Yes, Revoke my delegate now</button>
            </div>
          </div>
        </div>
      </div>
      <script>
        $(document).ready(function(){
        var isShow = 1;
        var cname = '<xsl:value-of select="sqroot/header/info/code/id"/>_dmc';
        isShow = (getCookie(cname) == null || getCookie(cname) == undefined || getCookie(cname) == '') ? 1 : 0;
        if (isShow == 1) {
        $('#delegatorModal').modal({ backdrop: "static" });
        }
        });
      </script>
    </xsl:if>

    <!--Delegation Info alert-->
    <xsl:if test="sqroot/body/bodyContent/browse/info/isDelegated = 1 and sqroot/body/bodyContent/browse/info/isDelegator = 0">
      <div id="delegationAlert" class="alert alert-warning alert-dismissable fade in">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&#215;</button>
        <h4>
          <ix class="icon far fa-info"></ix>&#160; Attention
        </h4>
        You are assigned as a delegation for this module. Expand the "Advanced Filters Box" below to filtering between your documents or the delegators.
      </div>
      <script>
        $("#delegationAlert").fadeTo(10000, 800).slideUp(800, function(){
        $("#delegationAlert").slideUp(800);
        });
      </script>
    </xsl:if>
    <!--Reject Modal-->
    <div id="rejectModal" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&#215;</button>
            <h4 class="modal-title" id="rejectTitle">Reject Reason</h4>
          </div>
          <div class="modal-body" id="rejectContent">
            <p>Please mention your reject reason: (required)</p>
            <textarea id="rejectComment" placeholder="Enter your reject reason." class="form-control">&#160;</textarea>
          </div>
          <div class="modal-footer">
            <button id="rejectBtn" type="button" class="btn btn-secondary" data-dismiss="modal" style="visibility:hidden">Reject</button>
            <button id="rejectCancelBtn" type="button" class="btn btn-primary btn-default" data-dismiss="modal">Cancel</button>
          </div>
        </div>
      </div>
    </div>
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        <xsl:value-of select="sqroot/header/info/code/name"/>
      </h1>
      <ol class="breadcrumb">
        <li>
          <a href="javascript:goHome();">
            <span>
              <ix class="far fa-home"></ix>
            </span>&#160;Home
          </a>
        </li>
        <li class="active">
          <xsl:value-of select="sqroot/header/info/code/name"/>&#160;(<xsl:value-of select="sqroot/header/info/code/id"/>)
        </li>
      </ol>
    </section>

    <!-- Main content-->
    <section class="content">
      <!--Access Authority and Permission-->
      <xsl:choose>
        <xsl:when test="$allowAccess = 1">
          <xsl:if test="sqroot/body/bodyContent/browse/info/nbPages > 1">
            <script>
              addpagenumber('pagenumbers', '<xsl:value-of select ="sqroot/body/bodyContent/browse/info/pageNo"/>', '<xsl:value-of select ="sqroot/body/bodyContent/browse/info/nbPages"/>')
              addpagenumber('mobilepagenumbers', '<xsl:value-of select ="sqroot/body/bodyContent/browse/info/pageNo"/>', '<xsl:value-of select ="sqroot/body/bodyContent/browse/info/nbPages"/>')
            </script>
          </xsl:if>

          <div class="row visible-phone">
            <!--Status and Button-->
            <div class="col-md-8 btn-group visible-phone">
              <xsl:apply-templates select="sqroot/body/bodyContent/browse/info/states/state/substate" />
            </div>
            <div class="col-md-4 text-right" style="padding-bottom:10px">
              <div class="text-right">
                <xsl:if test="sqroot/body/bodyContent/browse/info/permission/allowExport = 1">
                  <button id="btnExport" class="btn btn-success" data-clicked="0" onclick="window.location='?code={sqroot/header/info/code/id}&amp;mode=export'">
                    <strong>EXPORT DATA</strong>
                  </button>
                </xsl:if>
                <button id="newdoc" class="btn btn-warning" onclick="window.location='?code={sqroot/header/info/code/id}&amp;guid=00000000-0000-0000-0000-000000000000'">
                  <xsl:if test="sqroot/body/bodyContent/browse/info/permission/allowAdd = 0">
                    <xsl:attribute name="disabled">disabled</xsl:attribute>
                  </xsl:if>
                  <strong>NEW DOCUMENT</strong>
                </button>
              </div>
            </div>

          </div>


          <div class="row displayblock-phone">
            <div class="col-xs-6 browse-dropdown-status">
              <div class="dropdown">
                <button id="statusFilter" class="dropdown-toggle" type="button" data-toggle="dropdown" >
                  <ix class="far fa-file-text-o" aria-hidden="true"></ix>&#160;
                  <span style="font-family: 'Source Sans Pro','Helvetica Neue',Helvetica,Arial,sans-serif; font-weight:bold; font-size:smaller">
                    <xsl:value-of select="translate(sqroot/body/bodyContent/browse/info/curState/@substateName, $smallcase, $uppercase)"/>
                  </span>
                </button>
                <ul id="statusContent" class="dropdown-menu browse-dropdown-content">
                  <xsl:for-each select="sqroot/body/bodyContent/browse/info/states/state/substate">
                    <xsl:variable name="titleState">
                      <xsl:choose>
                        <xsl:when test="@tRecord &gt; 0">
                          <xsl:value-of select="@tRecord"/> records in total
                        </xsl:when>
                        <xsl:when test="@tRecord = 0">
                          No record yet
                        </xsl:when>
                      </xsl:choose>
                    </xsl:variable>

                    <li data-toggle="tooltip" data-placement="right" title="{$titleState}">
                      <a href="javascript:changestateid({@code})">
                        <xsl:value-of select="translate(., $smallcase, $uppercase)"/>
                        <xsl:if test="@tRecord">
                          &#160;
                          <span class="label label-default">
                            <xsl:value-of select="@tRecord"/>
                          </span>
                        </xsl:if>
                      </a>
                    </li>
                  </xsl:for-each>
                </ul>
              </div>
            </div>
            <div class="col-xs-6 text-right" style="padding-bottom:10px">
              <xsl:if test="sqroot/body/bodyContent/browse/info/permission/allowExport = 1">
                <button id="btnExport" class="btn btn-success" data-clicked="0" onclick="window.location='?code={sqroot/header/info/code/id}&amp;mode=export'">
                  <strong>EXPORT DATA</strong>
                </button>
              </xsl:if>
              <button id="newdoc" class="btn btn-warning" onclick="window.location='?code={sqroot/header/info/code/id}&amp;guid=00000000-0000-0000-0000-000000000000'">
                <xsl:if test="sqroot/body/bodyContent/browse/info/permission/allowAdd = 0">
                  <xsl:attribute name="disabled">disabled</xsl:attribute>
                </xsl:if>
																																										 
																							 
																		   
						   
                <strong>NEW DOCUMENT</strong>
              </button>
            </div>
          </div>

          <!--Browse Filters-->
          <xsl:if test="sqroot/body/bodyContent/browse/info/filters">
            <div class="col-md-12">
              <div id="bfBox">
                <xsl:attribute name="class">
                  <xsl:choose>
                    <xsl:when test="sqroot/body/bodyContent/browse/info/filters/*/value">box box-default</xsl:when>
                    <xsl:otherwise>box box-default collapsed-box</xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <div class="box-header with-border">
                  <button id="btnAdvancedFilter" type="button" class="btn btn-box-tool" data-widget="collapse">
                    <ix aria-hidden="true">
                      <xsl:attribute name="class">
                        <xsl:choose>
                          <xsl:when test="sqroot/body/bodyContent/browse/info/filters/*/value">far fa-minus</xsl:when>
                          <xsl:otherwise>far fa-plus</xsl:otherwise>
                        </xsl:choose>
                      </xsl:attribute>
                    </ix>
                    Advanced Filters
                    <xsl:if test="sqroot/body/bodyContent/browse/info/filters/*/value">(ACTIVE)</xsl:if>
                  </button>
                  <div class="box-body">
                    <form id="formFilter">
                      <xsl:apply-templates select="sqroot/body/bodyContent/browse/info/filters" />
                    </form>
                  </div>
                </div>
                <div class="box-body">
                  <form id="formFilter">
                    <xsl:apply-templates select="sqroot/body/bodyContent/browse/info/filters" />
                  </form>
                </div>
              </div>
            </div>
          </xsl:if>


          <!-- browse for pc/laptop -->
          <div class="row visible-phone">
            <div class="col-md-12">
              <div class="box">
                <table id="tblBrowse" class="table table-condensed table-stripped dataTable">
                  <thead id="browseHead">
                    <tr>
                      <xsl:if test="sqroot/body/bodyContent/browse/info/isDelegator = 0">
                        <th style="width:10px;" name="th_checkbox">
                          <input type="checkbox" id="pinnedAll" class="pinned header far fa-square fa-lg" onclick="checkedBox(this)" />
                        </th>
                      </xsl:if>
                      <xsl:if test="sqroot/body/bodyContent/browse/header/column[@mandatory=1]">
                        <xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column[@mandatory=1]" />
                      </xsl:if>
                      <xsl:if test="sqroot/body/bodyContent/browse/header/column[@mandatory=0]">
                        <th class="text-left">SUMMARY</th>
                      </xsl:if>
                      <xsl:if test="sqroot/body/bodyContent/browse/info/isDelegated = 1">
                        <th>&#160;</th>
                      </xsl:if>
                      <xsl:if test="$settingMode='T'">
                        <th>&#160;</th>
                      </xsl:if>
                      <xsl:if test="sqroot/body/bodyContent/browse/info/isDelegator = 0">
                        <th id="actionHeader" class="text-right">
                          <span>ACTION</span>
                          <!--action button all, keep hidden for a while-->
                          <div style="display:none;">
                            <xsl:if test="$settingMode='T'">
                              <xsl:choose>
                                <xsl:when test="$state=0 or $state=300">
                                  <a href="javascript:btn_function('{/sqroot/header/info/code/id}', null, 'execute', '1', 10)" data-toggle="tooltip">
                                    <xsl:attribute name="title">
                                      <xsl:choose>
                                        <xsl:when test="$state=0">Submit All</xsl:when>
                                        <xsl:when test="$state=300">Re-submit All</xsl:when>
																				  
                                      </xsl:choose>
                                    </xsl:attribute>
                                    <ix class="far fa-check"></ix>
                                  </a>
                                </xsl:when>
                                <xsl:when test="$state &gt;= 100 and $state &lt;300">
                                  <a href="javascript:btn_function('{/sqroot/header/info/code/id}', null, 'execute', '{sqroot/body/bodyContent/browse/info/pageNo}', 10)" data-toggle="tooltip" title="Approve All">
                                    <ix class="far fa-check"></ix>
                                  </a>
                                  <a href="javascript:rejectPopup('{/sqroot/header/info/code/id}', null, 'force', '{sqroot/body/bodyContent/browse/info/pageNo}', 10)" data-toggle="tooltip" title="Reject All">
                                    <ix class="far fa-times"></ix>
                                  </a>
                                </xsl:when>
                                <xsl:when test="$allowForce = 1 and $state &gt;= 400 and $state &lt; 500">
                                  <a href="javascript:btn_function('{/sqroot/header/info/code/id}', null, 'force', '{sqroot/body/bodyContent/browse/info/pageNo}', 10)" data-toggle="tooltip" title="Close All">
                                    <ix class="far fa-archive"></ix>
                                  </a>
                                </xsl:when>
                                <xsl:when test="$allowForce = 1 and $state = 500">
                                  <a href="javascript:btn_function('{/sqroot/header/info/code/id}', null, 'reopen', '{sqroot/body/bodyContent/browse/info/pageNo}', 10)" data-toggle="tooltip" title="ReOpen All">
                                    <ix class="far fa-undo"></ix>
                                  </a>
                                </xsl:when>
                              </xsl:choose>
                            </xsl:if>

                            <xsl:if test="$allowOnOff = 1 and $allowDelete = 1 and $state &lt; 500 and docStatus/@isOwner=1">
                              <a href="#" onclick="btn_function('{sqroot/body/bodyContent/browse/info/code}', null, 'inactivate', {sqroot/body/bodyContent/browse/info/pageNo}, 10)">
                                <ix class="far fa-toggle-on fa-lg" data-toggle="tooltip" title="Inactivated All" data-placement="left"/>
                              </a>
                            </xsl:if>
                            <xsl:if test="$state = 999">
                              <a href="#" onclick="btn_function('{sqroot/body/bodyContent/browse/info/code}', null, 'restore', {sqroot/body/bodyContent/browse/info/pageNo}, 10)">
                                <ix class="far fa-toggle-off fa-lg" data-toggle="tooltip" title="Re-Activated All" data-placement="left"/>
                              </a>
                              <xsl:if test="$allowWipe = 1">
                                <a href="#" onclick="btn_function('{sqroot/body/bodyContent/browse/info/code}', null, 'wipe', {sqroot/body/bodyContent/browse/info/pageNo}, 10)">
                                  <ix class="far fa-tras fa-lg" data-toggle="tooltip" title="Wiped All" data-placement="left"/>
                                </a>
                              </xsl:if>
                            </xsl:if>
                          </div>
                        </th>
                      </xsl:if>
                    </tr>
                  </thead>
                  <tbody id="browseContent">
                    <xsl:choose>
                      <xsl:when test="sqroot/body/bodyContent/browse/content/row">
                        <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row" />
                      </xsl:when>
                      <xsl:otherwise>
                        <tr>
                          <td align="center" colspan="{$tcolspan}">
                            <div id="noData" class="alert alert-warning">
                              There is no data available.
                              <xsl:if test="$state=0">
                                <a href="#" onclick="window.location='?code={sqroot/header/info/code/id}&amp;guid=00000000-0000-0000-0000-000000000000'">Create a new one?</a>
                              </xsl:if>
                            </div>
                          </td>
                        </tr>
                      </xsl:otherwise>
                    </xsl:choose>
                  </tbody>
                </table>
                <xsl:if test="sqroot/body/bodyContent/browse/info/nbPages > 1">
                  <div class="box-footer clearfix">
                    <ul class="pagination pagination-sm no-margin pull-right" id="pagenumbers"></ul>
                  </div>
                </xsl:if>
              </div>
            </div>
          </div>
          <!-- browse for pc/laptop -->

          <!-- browse for phone/tablet max width 768 -->
          <div class="row displayblock-phone">
            <div class="col-md-12 full-width-a">
              <div class="box box-solid" style="width:100%;">
                <div class="box-body full-width-a">
                  <div class="box-group" id="accordionBrowse">
                    <!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->
                    <xsl:if test="sqroot/body/bodyContent/browse/info/permission/allowAccess/.=0">
                      <div class="alert alert-warning" align="center">
                        You don't have any access to see this list. Please ask the administrator for more information.
                      </div>
                    </xsl:if>
                  </div>
                </div>
                <div class="box-footer clearfix">
                  <ul class="pagination pagination-sm no-margin pull-right" id="mobilepagenumbers"></ul>
                </div>
                <!-- /.box-body -->
              </div>
              <!-- /.box -->
            </div>
            <!-- /.col -->
          </div>
          <!-- browse for phone/tablet max width 768 -->

        </xsl:when>
        <xsl:otherwise>
          <div class="callout callout-danger">
            <h4>Unauthority Access!</h4>
            <p>You don't have the right access. Please ask the administrator if you feel that you already have the right access into this module.</p>
          </div>
        </xsl:otherwise>
      </xsl:choose>
    </section>

  </xsl:template>

  <xsl:template match="sqroot/header/menus/menu[@code='newdocument']/submenus/submenu">
    <li style="height:170px;text-align:center;">
      <a href="{pageURL/.}">
        <img src="OPHContent/themes/{/sqroot/header/info/themeFolder}/images/module.png" />
        <h4>
          <xsl:value-of select="translate(substring(code/.,1,2), $smallcase, $uppercase)" />
          <br />
          <xsl:value-of select="translate(substring(code/.,3,2), $smallcase, $uppercase)" />
        </h4>
        <p style="width:150px">
          <xsl:value-of select="caption/." />
        </p>
      </a>
    </li>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/info/filters">
    <div class="row">
      <xsl:apply-templates select="comboFilter"/>
    </div>
    <div class="row">
      <div class="col-md-12">
        <button type="button" id="btnFilter" class="btn btn-success btn-flat" data-loading-text="Applying Filter..." onclick="applySQLFilter(this)">
          Apply Filters
        </button>
        <button type="button" id="btnResetFilter" class="btn btn-warning btn-flat" data-loading-text="Reseting Filter..." onclick="resetSQLFilter(this)" >
          <xsl:if test="not(comboFilter/value)">
            <xsl:attribute name="disabled">disabled</xsl:attribute>
          </xsl:if>
          Reset Filters
        </button>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="comboFilter">
    <div class="col-md-6">
      <div class="form-group">
        <label for="{@id}">
          <xsl:value-of select="@caption"/>
        </label>
        <select class="form-control select2" style="width: 100%;" name="{@id}" id="{@id}" tabindex="-1" aria-hidden="true"
           data-type="selectBox" data-old="{value}" data-oldText="{value}" data-value="{value}" >
          <option value="NULL">-- Select All --</option>
        </select>
      </div>
    </div>
    <script>
      $("#<xsl:value-of select="@id"/>").select2({
      ajax: {
      url:"OPHCORE/api/msg_autosuggest.aspx",
      data: function (params) {
      var query = {
      code:"<xsl:value-of select="/sqroot/body/bodyContent/browse/info/code/."/>",
      colkey:"<xsl:value-of select="@id"/>",
      search: params.term, page: params.page
      }
      return query;
      },
      dataType: 'json',
      }
      });
      <xsl:if test="value!=''">
        var defer = [];
        autosuggestSetValue(defer,'<xsl:value-of select="@id"/>','<xsl:value-of select="/sqroot/body/bodyContent/browse/info/code/."/>','<xsl:value-of select="@id"/>', '<xsl:value-of select="value"/>', '', '')
      </xsl:if>
    </script>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/info/states/state/substate">
    <xsl:variable name="titleState">
      <xsl:choose>
        <xsl:when test="@tRecord &gt; 0">
          <xsl:value-of select="@tRecord"/> records in total
        </xsl:when>
        <xsl:when test="@tRecord = 0">
          No record yet
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <button type="button" class="btn btn-info" onclick="javascript:changestateid({@code})" title="{$titleState}">
      <xsl:if test="$state=@code">
        <xsl:attribute name="class">
          btn btn-info active
        </xsl:attribute>
        <xsl:attribute name="style">
          font-weight:bold
        </xsl:attribute>

      </xsl:if>
      <xsl:value-of select="translate(., $smallcase, $uppercase)"/>
      <xsl:if test="@tRecord&gt;0">
        &#160;
        <span class="label label-default">
          <xsl:value-of select="@tRecord"/>
        </span>
      </xsl:if>
    </button>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/header/column[@mandatory=1]">
    <xsl:variable name="title">
      <xsl:choose>
        <xsl:when test=".!=''">
          <xsl:value-of select="translate(., $smallcase, $uppercase)" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="translate(@fieldName, $smallcase, $uppercase)" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="tvalue">
      <xsl:choose>
        <xsl:when test="@order='asc' or @order='ASC'">
          <xsl:value-of select="$title"/> &amp;nbsp; &lt;ix class="far fa-sort-alpha-asc" /&gt;
        </xsl:when>
        <xsl:when test="@order='desc' or @order='DESC'">
          <xsl:value-of select="$title"/> &amp;nbsp; &lt;ix class="far fa-sort-alpha-desc" /&gt;
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$title"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <th title="{$title}" data-order="{@order}">
      <a href="#" onclick="sortBrowse(this, 'header', '{../../info/code}', '{@fieldName}')" data-toggle="tooltip" title="Click to Sort" style="color:black;">
        <xsl:value-of select="$tvalue"/>
      </a>
    </th>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/header/column[@docStatus=1]">
    STATUS
    <xsl:value-of select="translate(titleCaption/., $smallcase, $uppercase)" />
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">
    <tr class="odd-tr" data-guid="{@GUID}">
      <xsl:if test="/sqroot/body/bodyContent/browse/info/isDelegator = 0">
        <td>
          <input type="checkbox" data-guid="{@GUID}" class="pinned far fa-square" onclick="checkedBox(this)" />
        </td>
      </xsl:if>
      <input id="mandatory{@GUID}" type="hidden" value="" />
      <xsl:apply-templates select="fields/field[@mandatory=1]" />
      <script>
        //put before mandatory section
        fillMobileItem('<xsl:value-of select="@code"/>', '<xsl:value-of select="@GUID" />', '<xsl:value-of select="$state" />', '<xsl:value-of select="@edit" />', '<xsl:value-of select="@delete" />', '<xsl:value-of select="@wipe" />', '<xsl:value-of select="@force" />', '<xsl:value-of select="/sqroot/body/bodyContent/browse/info/isDelegator"/>');
      </script>

      <xsl:if test="count(fields/field[@mandatory=0])>0">
        <td class="expand-td" data-toggle="collapse" data-target="#brodeta-{@GUID}" data-parent="#brodeta-{@GUID}" style="cursor:pointer">
          <table class="fixed-table">
            <tr>
              <td id="summary{@GUID}" name="summary">
                <xsl:apply-templates select="fields/field[@mandatory=0]" />&#160;
              </td>
            </tr>
          </table>
        </td>
      </xsl:if>

      <xsl:if test="docDelegate">
        <td class="expand-td" style="text-align:center" data-toggle="collapse" data-target="#{@GUID}" data-parent="#{@GUID}">
          <a href="#" data-toggle="tooltip" title="{docDelegate/.}">
            <span class="label label-{docDelegate/@labelColor}">
              <xsl:value-of select="docDelegate/@title" />
            </span>
          </a>
        </td>
      </xsl:if>

      <xsl:if test="$settingMode='T'">
        <td class="expand-td" style="text-align:center" data-toggle="collapse" data-target="#{@GUID}" data-parent="#{@GUID}">
          <a href="#" data-toggle="tooltip" title="{docStatus/.}">
            <span class="label label-{docStatus/@labelColor}">
              <xsl:value-of select="docStatus/@title" />
            </span>
          </a>
        </td>
      </xsl:if>

      <xsl:variable name="pageNo" select="/sqroot/body/bodyContent/browse/info/pageNo" />

      <xsl:if test="/sqroot/body/bodyContent/browse/info/isDelegator = 0">
        <td class="browse-action-button text-right" style="white-space: nowrap;">

          <!--Action Approval icons-->
          <xsl:if test="$settingMode='T'">
            <xsl:choose>
              <xsl:when test="$state=0 or $state=300 and docStatus/@isOwner=1">
                <a href="javascript:btn_function('{@code}', '{@GUID}', 'execute', '{$pageNo}', 10)" data-toggle="tooltip">
                  <xsl:attribute name="title">
                    <xsl:choose>
                      <xsl:when test="$state=0">Submit This</xsl:when>
                      <xsl:when test="$state=300">Re-submit This</xsl:when>
                    </xsl:choose>
                  </xsl:attribute>
                  <ix class="far fa-check"></ix>
                </a>
              </xsl:when>
              <xsl:when test="$state &gt;= 100 and $state &lt; 300 and docStatus/@isOwner=0">
                <a href="javascript:btn_function('{@code}', '{@GUID}', 'execute', '{$pageNo}', 10)" data-toggle="tooltip" title="Approve This">
                  <ix class="far fa-check"></ix>
                </a>
                <a href="javascript:rejectPopup('{@code}', '{@GUID}', 'force', '{$pageNo}', 10)" data-toggle="tooltip" title="Reject This">
                  <ix class="far fa-times"></ix>
                </a>
              </xsl:when>
              <xsl:when test="$allowForce = 1 and $state &gt;= 400 and $state &lt; 500">
                <a href="javascript:btn_function('{@code}', '{@GUID}', 'force', '{$pageNo}', 10)" data-toggle="tooltip" title="Close This">
                  <ix class="far fa-archive"></ix>
                </a>
              </xsl:when>
              <xsl:when test="$allowForce = 1 and $state = 500">
                <a href="javascript:btn_function('{@code}', '{@GUID}', 'reopen', '{$pageNo}', 10)" data-toggle="tooltip" title="ReOpen This">
                  <ix class="far fa-undo"></ix>
                </a>
              </xsl:when>
            </xsl:choose>
          </xsl:if>

          <!--delete things-->
          <xsl:choose>
            <!--allow delete-->
            <xsl:when test="$settingMode!='T' and $allowDelete = 1 and $state = 0">
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'inactivate', '{$pageNo}', 10)" data-toggle="tooltip" title="Inactivate This">
                <ix class="far fa-toggle-on" title="Inactive"></ix>
              </a>
            </xsl:when>
            <xsl:when test="$settingMode='T' and $allowDelete = 1 and $state = 0 and docStatus/@isOwner=1">
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'delete', '{$pageNo}', 10)" data-toggle="tooltip" title="Delete This">
                <ix class="far fa-trash" title="Delete"></ix>
              </a>
            </xsl:when>
            <xsl:when test="$state = 999">
              <a href="javascript:btn_function('{@code}', '{@GUID}', 'restore', '{$pageNo}', 10)" data-toggle="tooltip" title="Reactivate This">
                <ix class="far fa-toggle-off" title="Reactivate"></ix>
              </a>
              <xsl:if test="$allowWipe = 1">
                <a href="javascript:btn_function('{@code}', '{@GUID}', 'wipe', '{$pageNo}', 10)" data-toggle="tooltip" title="Delete This Permanently">
                  <ix class="far fa-trash" title="Delete"></ix>
                </a>
              </xsl:if>
            </xsl:when>

            <!--not allow delete-->
            <xsl:when test="$allowOnOff = 1 and $allowDelete = 0 and $state &lt; 500">
              <a href="#">
                <ix class="far fa-toggle-on" style="color:LightGray"></ix>
              </a>
            </xsl:when>
            <xsl:when test="$allowOnOff = 0 and $allowDelete = 0 and $state &lt; 500">
              <a href="#">
                <ix class="far fa-trash" style="color:LightGray"></ix>
              </a>
            </xsl:when>
            <xsl:when test="$state = 999">
              <a href="#">
                <ix class="far fa-undo" style="color:lightgray"></ix>
              </a>
              <a href="#">
                <ix class="far fa-trash" style="color:LightGray"></ix>
              </a>
            </xsl:when>
          </xsl:choose>

          <!--edit things-->
          <xsl:choose>
            <xsl:when test="$state &lt; 999">
              <a id="edit_{@GUID}" href="index.aspx?code={@code}&#38;guid={@GUID}" data-toggle="tooltip" title="Edit/View This">
                <ix class="far fa-pencil"></ix>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <a href="#">
                <ix class="far fa-pencil" style="color:LightGray"></ix>
              </a>
            </xsl:otherwise>
          </xsl:choose>
        </td>
      </xsl:if>

    </tr>

    <xsl:choose>
      <xsl:when test="/sqroot/body/bodyContent/browse/info/browseMode=2">
        <script>
          $('#brodeta-<xsl:value-of select="@GUID" />').on('shown.bs.collapse', function() {
          //alert('shown');
          }).on('show.bs.collapse', function() {
          //alert('collapse');
          });
        </script>
        <tr class="tr-detail">
          <td colspan="{$tcolspan}" style="padding:0;">
            <div class="browse-data accordian-body collapse" id="brodeta-{@GUID}" style="cursor:default;">
              <div class="row">
                <div class="col-md-12 full-width-a">
                  loading child...
                </div>
              </div>
            </div>
          </td>
        </tr>
      </xsl:when>
      <xsl:otherwise>
        <tr class="tr-detail">
          <td colspan="{$tcolspan}" style="padding:0;">
            <div class="browse-data accordian-body collapse" id="brodeta-{@GUID}" style="cursor:default;">
              <div class="row">
                <div class="col-md-12 full-width-a">

                  <!--Summary-->
                  <xsl:if test="fields/field[@mandatory=0]">
                    <div class="box box-primary box-solid" style="max-width:600px;float:left;margin: 10px 10px 10px 10px;">
                      <div class="box-header with-border">
                        <h3 class="box-title">Content Summary</h3>
                        <div class="box-tools pull-right">
                          <button class="btn btn-box-tool" data-widget="collapse">
                            <ix class="far fa-minus"></ix>
                          </button>
                        </div>
                      </div>
                      <div class="box-body">
                        <xsl:apply-templates select="fields/field[@mandatory=0]" />
                      </div>
                    </div>
                  </xsl:if>

                  <!--Status Approval-->
                  <xsl:if test="approvals/approval">
                    <div class="box box-warning box-solid" style="max-width:300px;float:left;margin: 10px 10px 10px 10px;">
                      <div class="box-header with-border">
                        <h3 class="box-title">Approval List</h3>
                        <div class="box-tools pull-right">
                          <button class="btn btn-box-tool" data-widget="collapse">
                            <ix class="far fa-minus"></ix>
                          </button>
                        </div>
                      </div>
                      <div class="box-body">
                        <div class="direct-chat-msg">
                          <!--<div class="direct-chat-info clearfix">
                        <span class="direct-chat-name pull-left">
                          Created By
                        </span>
                        <span class="direct-chat-timestamp pull-right">
                          <xsl:value-of select="fields/field[@caption='CreatedUser']"/>
                        </span>
                      </div>-->
                          <!--Approvals-->
                          <!--<br/>
                        <strong>APPROVALS</strong>
                        <hr style="margin:0 0 5px 0;"/>-->
                          <xsl:apply-templates select="approvals"/>
                        </div>
                      </div>
                    </div>
                  </xsl:if>

                  <!--Talks-->
                  <xsl:variable name="talkDisplay">
                    <xsl:if test="not(talks/talk)">
                      collapsed-box
                    </xsl:if>
                  </xsl:variable>
                  <div class="box box-danger box-solid direct-chat direct-chat-danger {$talkDisplay}" style="max-width:300px;float:left;margin: 10px 10px 10px 10px;">
                    <div class="box-header with-border">
                      <h3 class="box-title">Document Talk</h3>
                      <div class="box-tools pull-right">
                        <button class="btn btn-box-tool" data-widget="collapse">
                          <ix class="far fa-plus"></ix>
                        </button>
							  
                      </div>
                    </div>
                    <div class="box-body">
                      <div class="direct-chat-messages" id="chatMessages{@GUID}" >
                        <xsl:apply-templates select="talks/talk"/>
							  
                      </div>
                    </div>
                    <div class="box-footer">
                      <div class="input-group">
                        <input type="text" id="message{@GUID}" name="message" placeholder="Type Message ..." class="form-control" onkeypress="javascript:enterTalk('{@GUID}', event, '10')"/>
                        <span class="input-group-btn">
                          <button type="button" class="btn btn-danger btn-flat" onclick="javascript:submitTalk('{@GUID}', '10')">Send</button>
								 
                        </span>
                      </div>
                    </div>
                  </div>
                  

                </div>
              </div>
            </div>
          </td>
        </tr>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="fields/field[@mandatory=1]">
    <script>
      var m=$('#mandatory<xsl:value-of select="../../@GUID"/>').val();
      if (m!='' &#38;&#38; "<xsl:value-of select="." />" != '') m+='/';
      m+="<xsl:value-of select="." />";
      $('#mandatory<xsl:value-of select="../../@GUID"/>').val(m);
    </script>
    <xsl:variable name="tbContent">
      <xsl:choose>
        <xsl:when test="@digit = 0 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 1 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0.0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 2 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0.00', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 3 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0.000', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 4 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0.0000', 'dot-dec')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="align">
      <xsl:choose>
        <xsl:when test="@align=0">left</xsl:when>
        <xsl:when test="@align=1">center</xsl:when>
        <xsl:when test="@align=2">right</xsl:when>
      </xsl:choose>
    </xsl:variable>
    <td id="mandatory{../../@GUID}" class="expand-td" data-toggle="collapse" data-target="#{../@GUID}" data-parent="#{../@GUID}" data-field="{@caption}">
      <xsl:attribute name="style">
        text-align:<xsl:value-of select="$align"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="@editor='anchor'">
          <a href="{$tbContent}">
            <xsl:value-of select="$tbContent" />
          </a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$tbContent" />
        </xsl:otherwise>
      </xsl:choose>
    </td>
  </xsl:template>

  <xsl:template match="fields/field[@mandatory='0']">
    <xsl:variable name="tbContent">
      <xsl:choose>
        <xsl:when test="@digit = 0 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 1 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0.0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 2 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0.00', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 3 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0.000', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 4 and .!=''">
          <xsl:value-of select="format-number(., '###,###,###,##0.0000', 'dot-dec')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test=". != ''">
      <span style="font-weight:bold;">
        <xsl:value-of select="@title" />
      </span>
      &#160;:&#160;
      <span data-field="{@caption}">
        <xsl:choose>
          <xsl:when test="@editor='anchor'">
            <a href="{$tbContent}">
              <xsl:value-of select="$tbContent" />
            </a>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$tbContent" />
            &#160;·&#160;
          </xsl:otherwise>
        </xsl:choose>
      </span>
    </xsl:if>
  </xsl:template>

  <xsl:template match="approvals">
    <xsl:for-each select="approval">
      <xsl:variable name="aprvStat">
        <xsl:choose>
          <xsl:when test="@status = 400">
            Approved
          </xsl:when>
          <xsl:when test="@status = 300">
            Rejected
          </xsl:when>
          <xsl:otherwise>
            Waiting for Approval
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="aprvColor">
        <xsl:choose>
          <xsl:when test="@status = 400">
            ORANGE
          </xsl:when>
          <xsl:when test="@status = 300">
            RED
          </xsl:when>
          <xsl:otherwise>
            GREY
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="aprvIcon">
        <xsl:choose>
          <xsl:when test="@status = 400">
            fa-user-circle-o
          </xsl:when>
          <xsl:when test="@status = 300">
            fa-user-times
          </xsl:when>
          <xsl:otherwise>
            fa-user
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="aprvName">
        <xsl:choose>
          <xsl:when test="@status = 400">
            &#160;&#160;<xsl:value-of select="name"/>
          </xsl:when>
          <xsl:when test="@status = 300">
            &#160;<xsl:value-of select="name"/>
          </xsl:when>
          <xsl:otherwise>
            &#160;&#160;&#160;&#160;<xsl:value-of select="name"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <div class="direct-chat-info clearfix">
        <span class="direct-chat-name pull-left">
          Level <xsl:value-of select="@level"/>
        </span>
      </div>
      <div class="direct-chat-info clearfix">
        <span class="direct-chat-name pull-left">
          <ix class="far {$aprvIcon} fa-lg" aria-hidden="true" style="color:{$aprvColor};" title="{$aprvStat}"></ix>
        </span>
        <span class="direct-chat-name pull-left">
          <xsl:value-of select="$aprvName"/>
        </span>
        <span class="direct-chat-timestamp pull-right">
          <xsl:value-of select="date"/>
        </span>
      </div>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="talks/talk">
    <xsl:choose>
      <xsl:when test="@itsMe">
        <div class="direct-chat-msg right">
          <div class="direct-chat-info clearfix">
            <span class="direct-chat-name pull-right">
              <xsl:value-of select="@talkUser"/>
            </span>
            <span class="direct-chat-timestamp pull-left">
              <xsl:value-of select="@talkDateCaption"/>
            </span>
          </div>
          <img class="direct-chat-img" src="OPHContent/documents/{/sqroot/header/info/account}/{@talkUserProfile}" alt="{talkUser}"/>
          <div class="direct-chat-text">
            <xsl:value-of select="@comment"/>
          </div>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <div class="direct-chat-msg">
          <div class="direct-chat-info clearfix">
            <span class="direct-chat-name pull-left">
              <xsl:value-of select="@talkUser"/>
            </span>
            <span class="direct-chat-timestamp pull-right">
              <xsl:value-of select="@talkDateCaption"/>
            </span>
          </div>
          <img class="direct-chat-img" src="OPHContent/documents/{/sqroot/header/info/account}/{@talkUserProfile}" alt="{talkUser}"/>
          <div class="direct-chat-text">
            <xsl:value-of select="@comment"/>
          </div>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>