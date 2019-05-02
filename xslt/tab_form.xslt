<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
    <xsl:variable name="lowerCode"><xsl:value-of select="translate(/sqroot/body/bodyContent/form/info/code, $uppercase, $smallcase)"/></xsl:variable>

  <xsl:variable name="allowAdd" select="/sqroot/body/bodyContent/form/info/permission/allowAdd" />
  <xsl:variable name="allowEdit" select="/sqroot/body/bodyContent/form/info/permission/allowEdit" />
  <xsl:variable name="allowAccess" select="/sqroot/body/bodyContent/form/info/permission/allowAccess" />
  <xsl:variable name="allowForce" select="/sqroot/body/bodyContent/form/info/permission/allowForce" />
  <xsl:variable name="allowDelete" select="/sqroot/body/bodyContent/form/info/permission/allowDelete" />
  <xsl:variable name="allowWipe" select="/sqroot/body/bodyContent/form/info/permission/allowWipe" />
  <xsl:variable name="allowOnOff" select="/sqroot/body/bodyContent/form/info/permission/allowOnOff" />
  <xsl:variable name="settingMode" select="/sqroot/body/bodyContent/form/info/settingMode/." />
  <xsl:variable name="docState" select="/sqroot/body/bodyContent/form/info/state/status/."/>
  <xsl:variable name="isApprover" select="/sqroot/body/bodyContent/form/info/document/isApprover"/>
  <xsl:variable name="cid" select="translate(/sqroot/body/bodyContent/form/info/GUID/., 'ABCDEF', 'abcdef')"/>
  <xsl:variable name="colMax">
    <xsl:for-each select="/sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol">
      <xsl:sort select="@colNo" data-type="number" order="descending"/>
      <xsl:if test="position() = 1">
        <xsl:value-of select="@colNo"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>

  <xsl:template match="/">
    <!-- Content Header (Page header) -->
    <script>
      //loadScript('OPHContent/cdn/daterangepicker/daterangepicker.js');
      //loadScript('OPHContent/cdn/select2/select2.full.min.js');

      var xmldoc = ""
      var xsldoc = "OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder"/>/xslt/" + getPage();
      <xsl:if test="sqroot/body/bodyContent/form/info/GUID!='00000000-0000-0000-0000-000000000000'">
        $('#button_save').hide();
        $('#button_cancel').hide();
        $('#button_save2').hide();
        $('#button_cancel2').hide();

        $('.action-save').hide();
        $('.action-cancel').hide();
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


      });

      $.when.apply($, deferreds).done(function() {
      preview('1', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','', this);
      });

      var c='<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>';
      getHash(c);
      setCookie('<xsl:value-of select="translate(/sqroot/body/bodyContent/form/info/code/., $uppercase, $smallcase)"/>_curstateid', '<xsl:value-of select="/sqroot/body/bodyContent/form/info/state/status/."/>');
      $('body').addClass('sidebar-collapse').trigger('sidebar-animated');

      var origin=window.location.origin;
      if (!(origin.substring(0,5)=='https' || origin.includes('localhost')))
      {
      $('#getImage').css("display", "block");
      $('#opencamera').css("display", "none");
      $('#takesnapshot').css("display", "none");
      $('#takeanother').css("display", "none");
      $('#savephoto').css("display", "none");

      }
      upload_init('<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>');
      
      //loadgps
      <!--xsl:if test="/sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field/getGPSBox or /sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field/setGPSBox"-->
      //loadScript('ophcontent/cdn/ophelements/gps/gps.js');
      
      <!--/xsl:if-->
	function <xsl:value-of select="$lowerCode" />_save(location) {
		saveThemeONE('<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/." />','<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/." />', location, '', 
		(function(d) {<xsl:value-of select="$lowerCode" />_saveafter(d)}), (function(d) {<xsl:value-of select="$lowerCode" />_savebefore(d)}));
	}
	
	function <xsl:value-of select="$lowerCode" />_saveafter(d) {}
	function <xsl:value-of select="$lowerCode" />_savebefore(d) {}
	  
    </script>

    <xsl:variable name="settingmode">
      <xsl:value-of select="/sqroot/body/bodyContent/form/info/settingMode/."/>
    </xsl:variable>
    <xsl:variable name="documentstatus">
      <xsl:value-of select="/sqroot/body/bodyContent/form/info/state/status/."/>
    </xsl:variable>

    <xsl:variable name="headlabel">
      <xsl:choose>
        <xsl:when test="sqroot/body/bodyContent/form/info/GUID='00000000-0000-0000-0000-000000000000'">
          NEW
        </xsl:when>
        <xsl:when test="(($allowEdit>=1 or $allowAdd>=1 or $allowDelete>=1) and (/sqroot/body/bodyContent/form/info/state/status=0 or /sqroot/body/bodyContent/form/info/state/status=300))
							or (($allowEdit>=3 or $allowDelete>=3) and /sqroot/body/bodyContent/form/info/state/status&lt;=300)
							or (($allowEdit>=4 or $allowAdd>=4 or $allowDelete>=4) and /sqroot/body/bodyContent/form/info/state/status&lt;=400)">
          EDIT
        </xsl:when>
        <xsl:otherwise>
          VIEW
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <section class="content-header visible-phone">
      <h1 data-toggle="collapse" data-target="#header" id="header_title">
        <xsl:choose>
          <xsl:when test="sqroot/body/bodyContent/form/info/GUID='00000000-0000-0000-0000-000000000000'">
            <xsl:value-of select="$headlabel" />&#160;<xsl:value-of select="translate(sqroot/body/bodyContent/form/info/Description/., $smallcase, $uppercase)"/>
          </xsl:when>
          <xsl:when test="(sqroot/body/bodyContent/form/info/GUID)!='00000000-0000-0000-0000-000000000000' and /sqroot/body/bodyContent/form/info/settingMode/.='T'">
            <xsl:value-of select="$headlabel" />&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/docNo/."/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$headlabel" />&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/id/."/>
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
          <a href="javascript: loadBrowse('{/sqroot/body/bodyContent/form/info/code/.}');">
            <span>
              <ix class="fa fa-file-o"></ix>
            </span>&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/Description/."/>
          </a>
        </li>
        <li class="active">
          <xsl:choose>
            <xsl:when test="sqroot/body/bodyContent/form/info/GUID='00000000-0000-0000-0000-000000000000'">
              NEW&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/Description/."/>
            </xsl:when>
            <xsl:when test="(sqroot/body/bodyContent/form/info/GUID)!='00000000-0000-0000-0000-000000000000' and /sqroot/body/bodyContent/form/info/settingMode/.='T'">
              EDIT&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/docNo/."/>
            </xsl:when>
            <xsl:otherwise>
              EDIT&#160;<xsl:value-of select="sqroot/body/bodyContent/form/info/id/."/>
            </xsl:otherwise>
          </xsl:choose>
        </li>
        <xsl:if test="sqroot/body/bodyContent/form/info/GUID!='00000000-0000-0000-0000-000000000000'">
          <li>
            <a style="color:blue" href="?code={/sqroot/body/bodyContent/form/info/code/.}&amp;guid=00000000-0000-0000-0000-000000000000">
              <span>
                <ix class="fa fa-plus-square"></ix>
              </span>
              Create New
            </a>
          </li>
        </xsl:if>
      </ol>
    </section>

    <!-- START CUSTOM TABS -->
    <!--<h2 class="page-header">CASH</h2>-->
    <section class="content">
      <form role="form" id="formheader" enctype="multipart/form-data" onsubmit="return false">
        <input type="hidden" id="cid" name="cid" value="{$cid}" />
        <input type="hidden" name ="{info/code/.}requiredname"/>
        <input type="hidden" name ="{info/code/.}requiredtblvalue"/>
      </form>
      <div class="row">
        <!--xsl:variable name="col">
          <xsl:choose>
            <xsl:when test="sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]">9</xsl:when>
            <xsl:otherwise>12</xsl:otherwise>
            </xsl:choose>
        </xsl:variable-->
        
          <div class="col-md-3">
            <xsl:variable name="fieldHead" select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/@fieldName" />
            <xsl:variable name="GTVal">
              <xsl:choose>
                <xsl:when test="(/sqroot/body/bodyContent/form/info/GUID/.) = '00000000-0000-0000-0000-000000000000'">
                  <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/textBox/defaultvalue" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/textBox/value" />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:variable name="tbContent">
              <xsl:choose>
                <xsl:when test="sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/textBox/digit = 0 and $GTVal!=''">
                  <xsl:value-of select="format-number($GTVal, '###,###,###,##0', 'dot-dec')"/>
                </xsl:when>
                <xsl:when test="sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/textBox/digit  = 1 and $GTVal!=''">
                  <xsl:value-of select="format-number($GTVal, '###,###,###,##0.0', 'dot-dec')"/>
                </xsl:when>
                <xsl:when test="sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/textBox/digit  = 2 and $GTVal!=''">
                  <xsl:value-of select="format-number($GTVal, '###,###,###,##0.00', 'dot-dec')"/>
                </xsl:when>
                <xsl:when test="sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/textBox/digit  = 3 and $GTVal!=''">
                  <xsl:value-of select="format-number($GTVal, '###,###,###,##0.000', 'dot-dec')"/>
                </xsl:when>
                <xsl:when test="sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/textBox/digit  = 4 and $GTVal!=''">
                  <xsl:value-of select="format-number($GTVal, '###,###,###,##0.0000', 'dot-dec')"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$GTVal"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <!-- Form Head-->
            <xsl:if test="sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]">
              <div id="profileBox" class="box box-primary">
                <div class="box-body box-profile">
                  <xsl:choose>
                    <xsl:when test="sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/imageBox/. != ''">
                      <xsl:variable name="imgName">
                        <xsl:value-of select="/sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/@fieldName/."/>
                      </xsl:variable>
                      <xsl:variable name="imgVal">
                        <xsl:value-of select="/sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/imageBox/value/."/>
                      </xsl:variable>

                      <!--<xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/imageBox/titlecaption"/>-->
                      <div id="imageBox" style=" padding:5px;">
                        <div id="{$imgName}_camera">
                          <img style="width:100%" id="{$imgName}_camera_img">
                            <xsl:attribute name="src">
                              <xsl:choose>
                                <xsl:when test="$imgVal!=''">
                                  ophcontent/documents/<xsl:value-of select="/sqroot/header/info/account" />/<xsl:value-of select="$imgVal" />
                                </xsl:when>
                                <xsl:otherwise>
                                  ophcontent/themes/themeone/images/blank-person.png
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:attribute>
                          </img>
                          &#xa0;
                        </div>
                        <div id="{$imgName}_hidden_div" style="display:none">
                          <img style="width:100%" id="{$imgName}_hidden_img">
                            <xsl:attribute name="src">
                              <xsl:choose>
                                <xsl:when test="$imgVal!=''">
                                  ophcontent/documents/<xsl:value-of select="/sqroot/header/info/account" />/<xsl:value-of select="$imgVal" />
                                </xsl:when>
                                <xsl:otherwise>
                                  ophcontent/themes/themeone/images/blank-person.png
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:attribute>
                          </img>
                        </div>
                        <form role="form" id="formwebcam" enctype="multipart/form-data" onsubmit="return false">
                          <xsl:if test="/sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/imageBox/. != ''">
                            <input type="hidden" class="oph-webcam" id="{/sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/@fieldName/.}" name ="{/sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/@fieldName/.}"/>
                          </xsl:if>

                          <label class="btn btn-primary btn-block" id="getImage">
                            <span>
                              Get Image <input id ="{$imgName}_hidden" name="{$imgName}_hidden" type="file" style="display: none;" multiple="" data-code="{/sqroot/body/bodyContent/form/info/code/.}" data-webcam="1" data-field="{$imgName}" accept="image/*"/>
                            </span>
                          </label>
                        </form>
                        <a href="javascript:btnWebcam('opencamera', '{$imgName}')" class="btn btn-primary btn-block" style="margin-top:5px;" id="opencamera">
                          <span>
                            <ix class="fa fa-camera"></ix>
                          </span>
                          <span>
                            <b> Open Camera</b>
                          </span>
                        </a>
                        <a href="javascript:btnWebcam('takesnap')" class="btn btn-primary btn-block" style="margin-top:5px; display:none;" id="takesnapshot">
                          <span>
                            <ix class="fa fa-camera"></ix>
                          </span>
                          <span>
                            <b> Take Snapshot</b>
                          </span>
                        </a>
                        <a href="javascript:btnWebcam('takeanother')" class="btn btn-primary btn-block" style="margin-top:5px; display:none;" id="takeanother">
                          <span>
                            <ix class="fa fa-camera"></ix>
                          </span>
                          <span>
                            <b> Take Another</b>
                          </span>
                        </a>
                        <a href="javascript:btnWebcam('savephoto', '{$imgName}')" class="btn btn-primary btn-block" style="margin-top:5px; display:none;" id="savephoto">
                          <span>
                            <ix class="fa fa-camera"></ix>
                          </span>
                          <span>
                            <b> Save Photo</b>
                          </span>
                        </a>
                      </div>
                    </xsl:when>
                    <xsl:otherwise>

                      <h3 class="profile-username text-center" id="{/sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/@fieldName}">
                        <xsl:value-of select="$tbContent"/>&#160;
                      </h3>
                      <p class="text-muted text-center">
                        <xsl:value-of select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection[@sectionNo=1]/formCols/formCol[@colNo=1]/formRows/formRow[@rowNo=1]/fields/field/textBox/titlecaption"/>
                      </p>
                    </xsl:otherwise>
                  </xsl:choose>
                  <xsl:if test="count(sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection/formCols/formCol/formRows/formRow[@rowNo>1]/fields/field)>0">
                    <ul class="list-group list-group-unbordered">
                      <xsl:for-each select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo=10]/formSections/formSection/formCols/formCol/formRows/formRow/fields/field">
                        <xsl:variable name="HeadVal">
                          <xsl:choose>
                            <xsl:when test="(/sqroot/body/bodyContent/form/info/GUID/.) = '00000000-0000-0000-0000-000000000000'">
                              <xsl:value-of select="textBox/defaultvalue" />
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="textBox/value" />
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:variable>
                        <xsl:choose>
                          <xsl:when test="@fieldName=$fieldHead">
                          </xsl:when>
                          <xsl:when test="imageBox">
                          </xsl:when>
                          <xsl:otherwise>
                            <li class="list-group-item">
                              <xsl:value-of select="textBox/titlecaption"/>
                              <a class="pull-right" id="{@fieldName}">
                                <xsl:value-of select="$HeadVal"/>&#160;
                              </a>
                            </li>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:for-each>
                    </ul>
                  </xsl:if>
                  <xsl:if test="sqroot/body/bodyContent/form/query/reports/report">
                    <xsl:for-each select="sqroot/body/bodyContent/form/query/reports/report">
                      <xsl:variable name="qdisable">
                        <xsl:choose>
                          <xsl:when test="isVisible=1">
                          </xsl:when>
                          <xsl:otherwise>
                            disabled
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:variable>

                      <xsl:if test="allowPDF=1">
                        <a href="javascript:genReport('{code}', 'pdf');" class="btn btn-primary btn-block {$qdisable}">
                          <span>
                            <ix class="fa fa-file-pdf"></ix>
                          </span>
                          <span>
                            <b>
                              <xsl:value-of select="description"/>
                            </b>
                          </span>
                        </a>
                      </xsl:if>
                      <xsl:if test="allowXLS=1">
                        <a href="javascript:genReport('{code}', 'xls');" class="btn btn-primary btn-block">
                          <ix class="fa fa-file-spreadsheet"></ix>
                          <b>
                            <xsl:value-of select="description"/>
                          </b>
                        </a>
                      </xsl:if>
                    </xsl:for-each>
                  </xsl:if>
                </div>

              </div>
              <!-- /.box -->
            </xsl:if>

            <!-- About Me Box -->
            <div id="aboutMeBox" class="box box-primary">
              <div class="box-header with-border">
                <h3 class="box-title">Action</h3>
              </div>
              <!-- /.box-header -->
              <div class="box-body">
                    <xsl:choose>
                      <!--location: 0 header; 1 child; 2 browse location: browse:10, header form:20, browse anak:30, browse form:40-->
                      <xsl:when test="(/sqroot/body/bodyContent/form/info/GUID/.) = '00000000-0000-0000-0000-000000000000'">
                      </xsl:when>
                      <xsl:when test="/sqroot/body/bodyContent/form/info/state/status/. = 0 or /sqroot/body/bodyContent/form/info/state/status/. = ''">
                        <xsl:if test="(/sqroot/body/bodyContent/form/info/settingMode/.)='T' and (/sqroot/body/bodyContent/form/info/state/status/.) &lt; 400 ">
                          <button id="button_submit" class="btn btn-orange-a btn-block action-submit" onclick="btn_function('{/sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'execute', 1, 20)">SUBMIT</button>
                        </xsl:if>
                        <xsl:if test="(($allowDelete>=1) and (/sqroot/body/bodyContent/form/info/state/status=0 or /sqroot/body/bodyContent/form/info/state/status=300))">
                          <button id="button_delete" class="btn btn-gray-a btn-block action-delete" onclick="btn_function('{/sqroot/body/bodyContent/form/info/code/.}','{/sqroot/body/bodyContent/form/info/GUID/.}', 'delete', 1, 20);">DELETE</button>
                        </xsl:if>
                      </xsl:when>
                      <xsl:when test="(/sqroot/body/bodyContent/form/info/state/status/.) &gt;= 100 and (/sqroot/body/bodyContent/form/info/state/status/.) &lt; 300">
                        <xsl:if test="$isApprover=1">
                          <button id="button_approve" class="btn btn-orange-a btn-block action-approve" onclick="btn_function('{/sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'execute', 1, 20)">APPROVE</button>
                          <button id="button_reject" class="btn btn-gray-a btn-block action-reject" onclick="rejectPopup('{/sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'force', 1, 20)">REJECT</button>
                        </xsl:if>
                      </xsl:when>
                      <xsl:when test="(/sqroot/body/bodyContent/form/info/state/status/.) = 300">
                        <xsl:if test="$isApprover=1">
                          <button id="button_submit" class="btn btn-orange-a btn-block action-submit" onclick="btn_function('{/sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'execute', 1, 20)">RE-SUBMIT</button>
                        </xsl:if>
                      </xsl:when>
                      <xsl:when test="(/sqroot/body/bodyContent/form/info/state/status/.) &gt;= 400 and (/sqroot/body/bodyContent/form/info/state/status/.) &lt;= 499">
                        <xsl:if test="$allowForce=1">
                          <button id="button_close" class="btn btn-orange-a btn-block action-close" onclick="btn_function('{/sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'force', 1, 20)">CLOSE</button>
                        </xsl:if>
                        <xsl:if test="(($allowDelete>=1) and (/sqroot/body/bodyContent/form/info/state/status=0 or /sqroot/body/bodyContent/form/info/state/status=300))
							                or (($allowDelete>=4) and (/sqroot/body/bodyContent/form/info/state/status&lt;100 or /sqroot/body/bodyContent/form/info/state/status&gt;=300))">

                          <button id="button_delete" class="btn btn-gray-a btn-block action-delete" onclick="btn_function('{/sqroot/body/bodyContent/form/info/code/.}','{/sqroot/body/bodyContent/form/info/GUID/.}', 'delete', 1, 20);">DELETE</button>
                        </xsl:if>
                      </xsl:when>
                      <xsl:when test="(/sqroot/body/bodyContent/form/info/state/status/.) &gt;= 500 and (/sqroot/body/bodyContent/form/info/state/status/.) &lt;= 899">
                        <button id="button_reopen" class="btn btn-orange-a btn-block action-reopen" onclick="btn_function('{/sqroot/body/bodyContent/form/info/code/.}', '{/sqroot/body/bodyContent/form/info/GUID/.}', 'reopen', 1, 20)">REOPEN</button>
                      </xsl:when>
                      <xsl:otherwise>
                        &#160;
                      </xsl:otherwise>
                    </xsl:choose>
                &#160;
              </div>
            </div>
          </div>
        <!--/xsl:if-->
        <div class="col-md-9">
          <!-- Custom Tabs -->
          <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <xsl:for-each select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo&lt;10]">
                <li>
                  <xsl:attribute name="class">
                    <xsl:if test="@pageNo=1">active</xsl:if>
                  </xsl:attribute>
                  <a href="#tab_{@pageNo}" data-toggle="tab"
                     onclick="storeHash('{/sqroot/body/bodyContent/form/info/code/.}', '#tab_{@pageNo}');">
                    <xsl:choose>
                      <xsl:when test="@pageTitle">
                        <xsl:value-of select="@pageTitle"/>
                      </xsl:when>
                      <xsl:otherwise>Header
                      </xsl:otherwise>
                    </xsl:choose>
                  </a>
                </li>
              </xsl:for-each>
              <xsl:choose>
                <xsl:when test="(/sqroot/body/bodyContent/form/info/GUID/.) = '00000000-0000-0000-0000-000000000000'"></xsl:when>
                <xsl:otherwise>
                  <xsl:for-each select="sqroot/body/bodyContent/form/children/child">
                    <li>
                      <a href="#tab_{code}" data-toggle="tab"
                         onclick="storeHash('{/sqroot/body/bodyContent/form/info/code/.}', '#tab_{code}');">
                        <xsl:value-of select="childTitle"/>
                      </a>
                    </li>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
            </ul>
            <div class="tab-content">
              <xsl:apply-templates select="sqroot/body/bodyContent"/>
              <!-- /.tab-pane -->
              <xsl:for-each select="sqroot/body/bodyContent/form/formPages/formPage[@pageNo&gt;1 and @pageNo&lt;10]">
                <div class="tab-pane active" id="tab_{@pageNo}">
                  &#160;
                </div>
              </xsl:for-each>
              <xsl:for-each select="sqroot/body/bodyContent/form/children/child">
                <div class="tab-pane" id="tab_{code}">
                  <xsl:if test="/sqroot/body/bodyContent/form/info/GUID !='00000000-0000-0000-0000-000000000000'">
                    <xsl:apply-templates select="."/>

                  </xsl:if>
                  <!--<xsl:value-of select="code"/>-->
                </div>
              </xsl:for-each>

            </div>

            <!-- /.tab-content -->
          </div>
          <!-- nav-tabs-custom -->
        </div>
        <!-- /.col -->

      </div>
    </section>
    <!-- /.row -->
    <!-- END CUSTOM TABS -->
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent">
    <xsl:apply-templates select="form"/>
  </xsl:template>

  <xsl:template match="form">
    <xsl:apply-templates select="formPages/formPage[@pageNo&lt;9]"/>
  </xsl:template>

  <xsl:template match="formPages/formPage[@pageNo&lt;9]">
    <div id="tab_{@pageNo}">
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="@pageNo=1">
            tab-pane active
          </xsl:when>
          <xsl:otherwise>
            tab-pane
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute> 
      <!-- Main content -->
      <section class="content">
        <!-- title -->
        <!-- view header -->
        <div class="row">
          <script>
            var code = "<xsl:value-of select="info/code/."/>";
            var tblnm =code+"requiredname";
          </script>

          <form role="form" id="formheader_{@pageNo}" enctype="multipart/form-data" onsubmit="return false">
            <xsl:apply-templates select="formSections" />
          </form>

        </div>
        <!-- button view header -->
        <div class="row">
          <div class="col-sm-12 col-md-12 col-lg-12 visible-phone" style="margin-bottom:50px;">
            <div style="text-align:left">
              <xsl:choose>
                <!--location: 0 header; 1 child; 2 browse location: browse:10, header form:20, browse anak:30, browse form:40-->
                <xsl:when test="(/sqroot/body/bodyContent/form/info/GUID/.) = '00000000-0000-0000-0000-000000000000'
						or /sqroot/body/bodyContent/form/info/state/status/. = 0 
						or /sqroot/body/bodyContent/form/info/state/status/. = ''
						or ((/sqroot/body/bodyContent/form/info/state/status/.) &gt;= 100 and (/sqroot/body/bodyContent/form/info/state/status/.) &lt; 300
						or ((/sqroot/body/bodyContent/form/info/state/status/.) = 300))
						or ((/sqroot/body/bodyContent/form/info/state/status/.) &gt;= 400 and (/sqroot/body/bodyContent/form/info/state/status/.) &lt;= 499)">
                  <button id="button_save_{@pageNo}" class="btn btn-orange-a action-save" 
				  onclick="{$lowerCode}_save(20)">SAVE</button>&#160;
                  <button id="button_cancel_{@pageNo}" class="btn btn-gray-a action-cancel" 
				  onclick="saveCancel()">CANCEL</button>&#160;
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
                <xsl:when test="(/sqroot/body/bodyContent/form/info/GUID/.) = '00000000-0000-0000-0000-000000000000' 
				or (/sqroot/body/bodyContent/form/info/state/status/.) = 0 
				or (/sqroot/body/bodyContent/form/info/state/status/.) = ''
				or ((/sqroot/body/bodyContent/form/info/state/status/.) &gt; 99 and (/sqroot/body/bodyContent/form/info/state/status/.) &lt; 199)
				or ((/sqroot/body/bodyContent/form/info/state/status/.) = 300)
				or ((/sqroot/body/bodyContent/form/info/state/status/.) &gt;= 400 and (/sqroot/body/bodyContent/form/info/state/status/.) &lt;= 499)">
                  <button id="button_save2" class="btn btn-orange-a btn-block action-save" 
				  onclick="{$lowerCode}_save(20);">SAVE</button>
                  <button id="button_cancel2" class="btn btn-gray-a btn-block action-cancel" 
				  onclick="saveCancel()">CANCEL</button>
                </xsl:when>
                <xsl:otherwise>
                  &#160;
                  <!--<div style="text-align:left">
                <button id="button_save" class="btn btn-orange-a" onclick="submitfunction('','{/sqroot/body/bodyContent/form/info/GUID/.}','{/sqroot/body/bodyContent/form/info/code/.}');">SAVE</button>&#160;
                <button id="button_cancel" class="btn btn-gray-a" onclick="saveCancel()">CANCEL</button>&#160;
              </div>-->
                </xsl:otherwise>
              </xsl:choose>
            </div>
          </div>
        </div>
      </section>

      <!-- /.content -->
    </div>

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
    
  </xsl:template>

  <xsl:include href="_elements.xslt" />

  <xsl:template match="sqroot/body/bodyContent/form/children">

    <xsl:apply-templates select="child"/>

  </xsl:template>

  <xsl:template match="child">
    <xsl:if test="info/permission/allowBrowse&gt;='1'">
      <input type="hidden" id="PKID" value="child{code/.}"/>
      <input type="hidden" id="filter{code/.}" value="{parentkey/.}='{/sqroot/body/bodyContent/form/info/GUID/.}'"/>
      <input type="hidden" id="parent{code/.}" value="{parentkey/.}"/>
      <input type="hidden" id="PKName" value="{parentkey/.}"/>

      <script>

        //xmldoc = "OPHCORE/api/default.aspx?code=<xsl:value-of select ="code/."/>&amp;mode=browse&amp;sqlFilter=<xsl:value-of select ="parentkey/."/>='<xsl:value-of select ="/sqroot/body/bodyContent/form/info/GUID/."/>'"
        //showXML('child<xsl:value-of select ="code/."/>', xmldoc, xsldoc + "_childBrowse.xslt", true, true, function () {});

        var code='<xsl:value-of select ="code/."/>';
        var parentKey='<xsl:value-of select ="parentkey/."/>';
        var GUID='<xsl:value-of select ="/sqroot/body/bodyContent/form/info/GUID/."/>';
        var browsemode='<xsl:value-of select ="browseMode/."/>';
        loadChild(code, parentKey, GUID, null, browsemode);
      </script>


      <div class="box box-solid box-default" style="box-shadow:0px;border:none" id="child{code/.}{$cid}">
        &#160;
      </div>

    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
