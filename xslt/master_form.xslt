<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="abcdefghijklmnopqrstuvwxyz" />
  <xsl:variable name="uppercase" select="ABCDEFGHIJKLMNOPQRSTUVWXYZ" />
  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
  <xsl:variable name="lowerCode"><xsl:value-of select="translate(/sqroot/body/bodyContent/browse/info/code, $uppercase, $smallcase)"/></xsl:variable>
  <xsl:variable name="allowAdd" select="/sqroot/body/bodyContent/form/info/permission/allowAdd" />
  <xsl:variable name="allowEdit" select="/sqroot/body/bodyContent/form/info/permission/allowEdit" />
  <xsl:variable name="allowAccess" select="/sqroot/body/bodyContent/form/info/permission/allowAccess" />
  <xsl:variable name="allowForce" select="/sqroot/body/bodyContent/form/info/permission/allowForce" />
  <xsl:variable name="allowDelete" select="/sqroot/body/bodyContent/form/info/permission/allowDelete" />
  <xsl:variable name="allowWipe" select="/sqroot/body/bodyContent/form/info/permission/allowWipe" />
  <xsl:variable name="allowOnOff" select="/sqroot/body/bodyContent/form/info/permission/allowOnOff" />
  <xsl:variable name="settingMode" select="/sqroot/body/bodyContent/form/info/settingMode/." />
  <xsl:variable name="docState" select="/sqroot/body/bodyContent/form/info/state/status/."/>
  <xsl:variable name="isRequester" select="/sqroot/body/bodyContent/form/info/document/isRequester"/>
  <xsl:variable name="isApprover" select="/sqroot/body/bodyContent/form/info/document/isApprover"/>
  <xsl:variable name="cid" select="translate(/sqroot/body/bodyContent/form/info/GUID/., 'ABCDEF', 'abcdef')"/>
 
  <xsl:template match="/">
    <!-- Content Header (Page header) -->
    <script>
      //loadScript('OPHContent/cdn/daterangepicker/daterangepicker.js');
      //loadScript('OPHContent/cdn/select2/select2.full.min.js');

      form_init();

      var xmldoc = ""
      var xsldoc = "OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder"/>/xslt/" + getPage();

      <xsl:if test="sqroot/body/bodyContent/form/info/GUID!='00000000-0000-0000-0000-000000000000'">
        $('#button_save').hide();
        $('#button_cancel').hide();
        $('#button_save2').hide();
        $('#button_cancel2').hide();
      </xsl:if>

      var deferreds = [];
      cell_defer(deferreds);

      $(function () {
      <!--//Date picker-->
      $('.datepicker').datepicker({autoclose: true});

      <!--//Date time picker-->
      $('.datetimepicker').datetimepicker();

      $(".timepicker").timepicker({
      minuteStep: 15,
      template: 'modal',
      appendWidgetTo: 'body',
      showSeconds: false,
      showMeridian: false,
      defaultTime: false
      });

      upload_init('<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>');

      <!--//iCheck for checkbox and radio inputs-->
      $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
      checkboxClass: 'icheckbox_minimal-blue',
      radioClass: 'iradio_minimal-blue'
      });
      <!--//Red color scheme for iCheck-->
      $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
      checkboxClass: 'icheckbox_minimal-red',
      radioClass: 'iradio_minimal-red'
      });
      <!--//Flat red color scheme for iCheck-->
      $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
      checkboxClass: 'icheckbox_flat-green',
      radioClass: 'iradio_flat-green'
      });

      <!--//Colorpicker--><!--
    $(".my-colorpicker1").colorpicker();
    --><!--//color picker with addon--><!--
    $(".my-colorpicker2").colorpicker();

    --><!--//Timepicker--><!--
    $(".timepicker").timepicker({
    showInputs: false
    });-->
      });
      setCookie('<xsl:value-of select="translate(/sqroot/body/bodyContent/form/info/code/., $uppercase, $smallcase)"/>_curstateid', '<xsl:value-of select="$docState"/>');
	  
	function <xsl:value-of select="$lowerCode" />_save(location) {
		saveThemeONE('<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/." />','<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/." />', location, '', 
		(function(d) {<xsl:value-of select="$lowerCode" />_saveafter(d)}), (function(d) {<xsl:value-of select="$lowerCode" />_savebefore(d)}));
	}
	
	function <xsl:value-of select="$lowerCode" />_saveafter(d) {}
	function <xsl:value-of select="$lowerCode" />_savebefore(d) {}
	
    </script>

    <xsl:variable name="head">
      <xsl:choose>
        <xsl:when test="sqroot/body/bodyContent/form/info/GUID='00000000-0000-0000-0000-000000000000'">
          NEW
        </xsl:when>
        <xsl:when test="(($allowEdit>=1 or $allowAdd>=1 or $allowDelete>=1) and ($docState=0 or $docState=300))
							or (($allowEdit>=3 or $allowDelete>=3) and $docState&lt;=300)
							or (($allowEdit>=4 or $allowAdd>=4 or $allowDelete>=4) and $docState&lt;=400)">
          EDIT
        </xsl:when>
        <xsl:otherwise>
          VIEW
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <section class="content-header">
      <h1 data-toggle="collapse" data-target="#header" id="header_title">
        <xsl:choose>
          <xsl:when test="sqroot/body/bodyContent/form/info/GUID='00000000-0000-0000-0000-000000000000'">
            <xsl:value-of select="$head" />&#160;<xsl:value-of select="translate(sqroot/body/bodyContent/form/info/Description/., $smallcase, $uppercase)"/>
          </xsl:when>
          <xsl:when test="(sqroot/body/bodyContent/form/info/GUID)!='00000000-0000-0000-0000-000000000000' and $settingMode='T'">
            <xsl:value-of select="$head" />&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/docNo/."/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$head" />&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/id/."/>
          </xsl:otherwise>
        </xsl:choose>

      </h1>
      <ol class="breadcrumb">
        <li>
          <a href="javascript:goHome();">
            <span>
              <ix class="fa fa-home"></ix>
            </span>&#160;HOME
          </a>
        </li>
        <li>
          <a href="javascript: loadBrowse('{sqroot/body/bodyContent/form/info/code/.}');">
            <span>
              <ix class="fa fa-file-text-o"></ix>
            </span>&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/Description/."/>
          </a>
        </li>
        <li class="active">
          <xsl:choose>
            <xsl:when test="sqroot/body/bodyContent/form/info/GUID='00000000-0000-0000-0000-000000000000'">
              NEW&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/Description/."/>
            </xsl:when>
            <xsl:when test="(sqroot/body/bodyContent/form/info/GUID)!='00000000-0000-0000-0000-000000000000' and $settingMode='T'">
              DOC&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/docNo/."/>
            </xsl:when>
            <xsl:otherwise>
              DOC&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/id/."/>
            </xsl:otherwise>
          </xsl:choose>
        </li>
        <xsl:if test="sqroot/body/bodyContent/form/info/GUID!='00000000-0000-0000-0000-000000000000'">
          <li>
            <a style="color:blue" href="?code={sqroot/body/bodyContent/form/info/code/.}&amp;guid=00000000-0000-0000-0000-000000000000">
              <span>
                <ix class="fa fa-plus-square"></ix>
              </span>
              Create New
            </a>
          </li>
        </xsl:if>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <xsl:apply-templates select="sqroot/body/bodyContent"/>
      <script>
        $.when.apply($, deferreds).done(function() {
        preview('1', getCode(), '<xsl:value-of select="$cid"/>','', this);
        });
      </script>

      <div class="row">
        <div class="col-md-12 col-lg-12" style="margin-bottom:50px;">
          <div style="text-align:left">
            <xsl:choose>
              <!--location: 0 header; 1 child; 2 browse location: browse:10, header form:20, browse anak:30, browse form:40-->
              <xsl:when test="($cid) = '00000000-0000-0000-0000-000000000000'">
                <button id="button_save" class="btn btn-orange-a" onclick="{$lowerCode}_save(20);">SAVE</button>&#160;
                <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
              </xsl:when>
              <xsl:when test="$docState = 0 or $docState = ''">
                <button id="button_save" class="btn btn-orange-a" onclick="{$lowerCode}_save(20);">SAVE</button>&#160;
                <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <xsl:if test="($settingMode)='T' and ($docState) &lt; 400 ">
                  <button id="button_submit" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'execute', 1, 20)">SUBMIT</button>&#160;
                </xsl:if>
                <xsl:if test="(($allowDelete>=1) and ($docState=0 or $docState=300))
							                or (($allowDelete>=4) and ($docState&lt;100 or $docState&gt;=300))">
                  <button id="button_delete" class="btn btn-gray-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}','{sqroot/body/bodyContent/form/info/GUID/.}', 'delete', 1, 20);">DELETE</button>&#160;
                </xsl:if>
              </xsl:when>
              <xsl:when test="($docState) &gt;= 100 and ($docState) &lt; 300">
                <button id="button_save" class="btn btn-orange-a" onclick="{$lowerCode}_save(20);">SAVE</button>&#160;
                <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <xsl:if test="$isApprover=1">
                  <button id="button_approve" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'execute', 1, 20)">APPROVE</button>&#160;
                  <button id="button_reject" class="btn btn-orange-a" onclick="rejectPopup('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'force', 1, 20)">REJECT</button>&#160;
                </xsl:if>
              </xsl:when>
              <xsl:when test="($docState) = 300">
                <button id="button_save" class="btn btn-orange-a" onclick="{$lowerCode}_save(20);">SAVE</button>&#160;
                <xsl:if test="$isRequester=1">
                  <button id="button_submit" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'execute', 1, 20)">RE-SUBMIT</button>&#160;
                </xsl:if>
                <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;&#160;

              </xsl:when>
              <xsl:when test="($docState) &gt;= 400 and ($docState) &lt;= 499">
                <button id="button_save" class="btn btn-orange-a" onclick="{$lowerCode}_save(20);">SAVE</button>&#160;
                <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <xsl:if test="$allowForce=1">
                  <button id="button_close" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'force', 1, 20)">CLOSE</button>&#160;
                </xsl:if>
              </xsl:when>
              <xsl:when test="($docState) &gt;= 500 and ($docState) &lt;= 899">
                <button id="button_reopen" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'reopen', 1, 20)">REOPEN</button>&#160;
              </xsl:when>
              <xsl:otherwise>
                &#160;
              </xsl:otherwise>
            </xsl:choose>
          </div>

        </div>
        <div class="col-md-12 displayblock-phone device-xs visible-xs" style="margin-bottom:20px;">
          <div style="text-align:center">
            <xsl:choose>
              <xsl:when test="($cid) = '00000000-0000-0000-0000-000000000000'">
                <button id="button_save2" class="btn btn-orange-a" onclick="{$lowerCode}_save(20);">SAVE</button>&#160;
                <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
              </xsl:when>
              <xsl:when test="($docState) = 0 or ($docState) = ''">
                <button id="button_save2" class="btn btn-orange-a" onclick="{$lowerCode}_save(20);">SAVE</button>&#160;
                <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <xsl:if test="($settingMode)='T' and ($docState) &lt; 400 ">
                  <button id="button_submit2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'execute', 1, 20)">SUBMIT</button>&#160;
                </xsl:if>
              </xsl:when>
              <xsl:when test="($docState) &gt; 99 and ($docState) &lt; 199">
                <button id="button_save2" class="btn btn-orange-a" onclick="{$lowerCode}_save(20);">SAVE</button>&#160;
                <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <button id="button_approve2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'execute', 1, 20)">APPROVE</button>&#160;
              </xsl:when>
              <xsl:when test="($docState) = 300">
                <button id="button_save2" class="btn btn-orange-a" onclick="{$lowerCode}_save(20);">SAVE</button>&#160;
                <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <button id="button_reject2" class="btn btn-orange-a">REJECT</button>&#160;
              </xsl:when>
              <xsl:when test="($docState) &gt;= 400 and ($docState) &lt;= 499">
                <button id="button_save2" class="btn btn-orange-a" onclick="{$lowerCode}_save(20);">SAVE</button>&#160;
                <button id="button_cancel2" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
                <xsl:if test="$allowForce=1">
                  <button id="button_close2" class="btn btn-orange-a" onclick="btn_function('{sqroot/body/bodyContent/form/info/code/.}', '{$cid}', 'force', 1, 20)">CLOSE</button>&#160;
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>
                &#160;
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </div>
      </div>
      <!-- button view header -->

      <xsl:if test="sqroot/body/bodyContent/form/info/GUID !='00000000-0000-0000-0000-000000000000'">
        <xsl:apply-templates select="sqroot/body/bodyContent/form/children"/>
      </xsl:if>
      <!-- browse for phone/tablet max width 768 -->
    </section>

    <!--reject modal-->
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
    <!-- /.content -->

  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent">
    <div class="row">
      <script>
        var code = "<xsl:value-of select="info/code/."/>";
        var tblnm =code+"requiredname";
      </script>
      <form role="form" id="formheader" enctype="multipart/form-data">
        <input type="hidden" id="cid" name="cid" value="{$cid}" />
        <input type="hidden" name ="{info/code/.}requiredname"/>
        <input type="hidden" name ="{info/code/.}requiredtblvalue"/>

        <xsl:apply-templates select="form"/>
      </form>
    </div>
  </xsl:template>

  <xsl:template match="form">
    <xsl:apply-templates select="formPages/formPage[@pageNo&lt;9]"/>
  </xsl:template>

  <xsl:template match="formPages/formPage[@pageNo&lt;9]">
    <xsl:apply-templates select="formSections"/>
  </xsl:template>
  <xsl:include href="_elements.xslt" />
  
  <xsl:template match="sqroot/body/bodyContent/form/children">
    <xsl:apply-templates select="child"/>
  </xsl:template>

  <xsl:template match="child">
    <xsl:if test="info/permission/allowBrowse='1'">
      <input type="hidden" id="PKID" value="child{code/.}"/>
      <input type="hidden" id="filter{code/.}" value="{parentkey/.}='{$cid}'"/>
      <input type="hidden" id="parent{code/.}" value="{parentkey/.}"/>
      <input type="hidden" id="PKName" value="{parentkey/.}"/>
      <script>

        var code='<xsl:value-of select ="code/."/>';
        var parentKey='<xsl:value-of select ="parentkey/."/>';
        var GUID='<xsl:value-of select ="$cid"/>';
        var browsemode='<xsl:value-of select ="browseMode/."/>';
        loadChild(code, parentKey, GUID, null, browsemode);
      </script>

      <div class="box box-solid box-default" style="box-shadow:0px;border:none" id="child{code/.}{$cid}">
        &#160;
      </div>

    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
