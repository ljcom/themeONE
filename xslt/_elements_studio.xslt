<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="formSections">
    <xsl:apply-templates select="formSection"/>
    <div class="col-md-12">
      <div class="row">
        <div class="col-md-12">
          <div class="btn-group btn-group-sm studio-child" role="group" aria-label="Basic example">
            <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
              New Section:
            </button>
            <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
              <ix class="fa fa-plus fa-sm"></ix>
            </button>
          </div>
          <div class="btn-group btn-group-sm studio-child" role="group" aria-label="Basic example">
            <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
              New Child:
            </button>
            <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
              <ix class="fa fa-plus fa-sm"></ix>
            </button>
          </div>

        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="formSection">
    <xsl:if test="formCols/formCol/formRows">
      <div class="col-md-12 collapse in drag-section" id="section_{@sectionNo}" draggable="true">
        <div class="row">
          <div class="col-md-12">
            <h3 style="display:inline">
              <span contenteditable="true">
                <xsl:choose>
                  <xsl:when test="@sectionTitle/.!=''">
                    <xsl:value-of select="@sectionTitle/."/>&#160;
                  </xsl:when>
                  <xsl:otherwise>
                    Enter Section Title Here...
                  </xsl:otherwise>
                </xsl:choose>
              </span>
            </h3>
            <div class="btn-group btn-group-sm studio-section" role="group" aria-label="Basic example">
              <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
                Section:
              </button>
              <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
                <ix class="fa fa-plus fa-sm"></ix>
              </button>
              <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
                <ix class="fa fa-times fa-sm"></ix>
              </button>
            </div>

          </div>
          <xsl:apply-templates select="formCols"/>
        </div>
      </div>
    </xsl:if>
    <xsl:if test="formChildren/formChild">
      <!--xsl:if test="(/sqroot/body/bodyContent/form/info/GUID/.) != '00000000-0000-0000-0000-000000000000'"-->
      <div class="col-md-12 collapse in drag-child" id="section_{@sectionNo}" draggable="true">
        <div class="row">

          <xsl:apply-templates select="formChildren"/>

        </div>
      </div>
    </xsl:if>
    <!--/xsl:if-->
  </xsl:template>

  <xsl:template match="formCols">
    <xsl:apply-templates select="formCol"/>
    <div class="btn-group btn-group-sm studio-child" role="group" aria-label="Basic example">
      <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
        New Column:
      </button>
      <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
        <ix class="fa fa-plus fa-sm"></ix>
      </button>
    </div>
  </xsl:template>

  <xsl:template match="formCol">
    <xsl:variable name="colMax">
      <xsl:for-each select="../formCol/.">
        <xsl:sort select="@colNo" data-type="number" order="descending"/>
        <xsl:if test="position() = 1">
          <xsl:value-of select="@colNo"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$colMax=0">
        <div class="col-md-12 drag-col" data-cm="{$colMax}" draggable="true" >
          <h4 style="display:inline">
            <span contenteditable="true">
              <xsl:choose>
                <xsl:when test="@colTitle/.!=''">
                  <xsl:value-of select="@colTitle/."/>&#160;
                </xsl:when>
                <xsl:otherwise>
                  Enter Column Title Here...
                </xsl:otherwise>
              </xsl:choose>
            </span>
          </h4>
          <div class="btn-group btn-group-sm studio-column" role="group" aria-label="Basic example">
            <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
              Column:
            </button>
            <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
              <ix class="fa fa-plus fa-sm"></ix>
            </button>
            <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
              <ix class="fa fa-times fa-sm"></ix>
            </button>
          </div>
          <xsl:apply-templates select="formRows"/>
        </div>
      </xsl:when>
      <xsl:when test="$colMax=1 or $colMax=2">
        <div class="col-md-6 drag-col" data-cm="{$colMax}" draggable="true" >
          <h4 style="display:inline">
            <span contenteditable="true">
              <xsl:choose>
                <xsl:when test="@colTitle/.!=''">
                  <xsl:value-of select="@colTitle/."/>&#160;
                </xsl:when>
                <xsl:otherwise>
                  Enter Column Title Here...
                </xsl:otherwise>
              </xsl:choose>
            </span>
          </h4>
          <div class="btn-group btn-group-sm studio-column" role="group" aria-label="Basic example">
            <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
              Column:
            </button>
            <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
              <ix class="fa fa-plus fa-sm"></ix>
            </button>
            <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
              <ix class="fa fa-times fa-sm"></ix>
            </button>
          </div>
          <xsl:if test="@colNo='1'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
          <xsl:if test="@colNo='2'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
        </div>
      </xsl:when>
      <xsl:when test="$colMax=3">
        <div class="col-md-4 drag-col" data-cm="{$colMax}" draggable="true" >
          <h4 style="display:inline">
            <span contenteditable="true">
              <xsl:choose>
                <xsl:when test="@colTitle/.!=''">
                  <xsl:value-of select="@colTitle/."/>&#160;
                </xsl:when>
                <xsl:otherwise>
                  Enter Column Title Here...
                </xsl:otherwise>
              </xsl:choose>
            </span>
          </h4>
          <div class="btn-group btn-group-sm studio-column" role="group" aria-label="Basic example">
            <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
              Column:
            </button>
            <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
              <ix class="fa fa-plus fa-sm"></ix>
            </button>
            <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
              <ix class="fa fa-times fa-sm"></ix>
            </button>
          </div>
          <xsl:if test="@colNo='1'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
          <xsl:if test="@colNo='2'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
          <xsl:if test="@colNo='3'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
        </div>
      </xsl:when>
      <xsl:when test="$colMax=4">
        <div class="col-md-3 drag-col" data-cm="{$colMax}" draggable="true" >
          <h4 style="display:inline">
            <span contenteditable="true">
              <xsl:choose>
                <xsl:when test="@colTitle/.!=''">
                  <xsl:value-of select="@colTitle/."/>&#160;
                </xsl:when>
                <xsl:otherwise>
                  Enter Column Title Here...
                </xsl:otherwise>
              </xsl:choose>
            </span>
          </h4>
          <div class="btn-group btn-group-sm studio-column" role="group" aria-label="Basic example">
            <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
              Column:
            </button>
            <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
              <ix class="fa fa-plus fa-sm"></ix>
            </button>
            <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
              <ix class="fa fa-times fa-sm"></ix>
            </button>
          </div>
          <xsl:if test="@colNo='1'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
          <xsl:if test="@colNo='2'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
          <xsl:if test="@colNo='3'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
          <xsl:if test="@colNo='4'">
            <xsl:apply-templates select="formRows"/>
          </xsl:if>
        </div>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="formRows">
    <div class="box box-solid box-default">
      <div class="box-body">
        <xsl:apply-templates select="formRow"/>
        <button type="button" class="btn btn-secondary"  style="padding:1px 5px">
          <ix class="fa fa-plus fa-sm"></ix>
          <span>Add Field</span>
        </button>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="formRow ">
    <xsl:apply-templates select="fields"/>
  </xsl:template>

  <xsl:template match="fields">
    <xsl:apply-templates select="field"/>
  </xsl:template>

  <xsl:template match="field">
    <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
                    )
            ">
      <script>
        document.getElementsByName(tblnm)[0].value = document.getElementsByName(tblnm)[0].value + ', <xsl:value-of select="@fieldName"/>'
      </script>
    </xsl:if>

    <xsl:variable name="fieldEnabled">
      <xsl:choose>
        <xsl:when test ="((@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500)))">enabled</xsl:when>
        <xsl:otherwise>disabled</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test ="$fieldEnabled='disabled'">
      <script>
        $('#<xsl:value-of select="@fieldName"/>').attr('disabled', 'disabled');
        $('#cb<xsl:value-of select="@fieldName"/>').attr('disabled', 'disabled');
        $('#<xsl:value-of select="@fieldName"/>').prop('disabled', true);
        $('cb#<xsl:value-of select="@fieldName"/>').prop('disabled', true);
      </script>
    </xsl:if>

    <div class="form-group {$fieldEnabled}-input" draggable="true" >
      <xsl:apply-templates select="textBox"/>
      <xsl:apply-templates select="textEditor"/>
      <xsl:apply-templates select="textArea"/>
      <xsl:apply-templates select="dateBox"/>
      <xsl:apply-templates select="dateTimeBox"/>
      <xsl:apply-templates select="timeBox"/>
      <xsl:apply-templates select="monthBox"/>
      <xsl:apply-templates select="yearBox"/>
      <xsl:apply-templates select="passwordBox"/>
      <xsl:apply-templates select="hiddenBox"/>
      <xsl:apply-templates select="label"/>
      <xsl:apply-templates select="button"/>
      <xsl:apply-templates select="checkBox"/>
      <xsl:apply-templates select="mediaBox"/>
      <xsl:apply-templates select="profileBox"/>
      <xsl:apply-templates select="autoSuggestBox"/>
      <xsl:apply-templates select="tokenBox"/>
      <xsl:apply-templates select="radio"/>
      <xsl:apply-templates select="signBox"/>
      <xsl:apply-templates select="getGPSBox"/>
      <xsl:apply-templates select="setGPSBox"/>
    </div>
  </xsl:template>
  <xsl:template match="hiddenBox">
    <input type="hidden" Value="{value}" data-type="hiddenBox" data-old="{value}" name="{../@fieldName}"
           id ="{../@fieldName}"/>

  </xsl:template>
  <xsl:template match="label">
    <p contenteditable="true">
      <xsl:value-of select="titlecaption"/>
    </p>

  </xsl:template>
  <xsl:template match="button">
    <button class="btn {class}" type="button" onclick="javascript:preview('{preview/.}', getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','', this);">
      <xsl:choose>
        <xsl:when test="fa">
          <ix class="{fa}">
            &#160;
            <xsl:value-of select="titlecaption"/>
          </ix>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="titlecaption"/>
        </xsl:otherwise>
      </xsl:choose>
    </button>
  </xsl:template>
  <xsl:template match="signBox">
    <script>
      //loadScript('OPHContent/cdn/ophelements/signjs/sign.js');
      $.getScript('OPHContent/cdn/ophelements/signjs/sign.js', function() {
      try{initSign('sign', '<xsl:value-of select="../@fieldName"/>');}catch(e){}
      });


    </script>
    <div class="sign" data-field="{../@fieldName}" style="border: 1px solid #ccc;">
      <canvas class="pad" width="100%" height="85;background-color:#333">&#160;</canvas>
      <input type="hidden" name="{../@fieldName}" id ="{../@fieldName}"
             class="output" Value="{value}" data-old="{value}" />
    </div>

    <input type="reset" value="clear" onclick="clearSign('sign')" />

  </xsl:template>
  <xsl:template match="getGPSBox">
    <script>
      $.getScript('https://maps.googleapis.com/maps/api/js?key=##gpskey##', function() {
      $.getScript('OPHContent/cdn/ophelements/gps/gps.js', function() {
      try{initMap();}catch(e){}
      })
      })
    </script>
    <input type="hidden" Value="{value}" data-type="hiddenBox" data-old="{value}" name="{../@fieldName}"
           id ="{../@fieldName}"/>
    <div id="map" data-field="{../@fieldName}" style="height:100px">&#160;</div>

  </xsl:template>
  <xsl:template match="setGPSBox">
    <script>
      loadScript('https://maps.googleapis.com/maps/api/js?key=##gpskey##', true, true);
      loadScript('OPHContent/cdn/ophelements/gps/gps.js');
      setTimeout(function() {initMap();}, 1000);
    </script>
    <input type="hidden" Value="{value}" data-type="hiddenBox" data-old="{value}" name="{../@fieldName}"
           id ="{../@fieldName}"/>
    <div id="map" style="height:100px">&#160;</div>
  </xsl:template>

  <xsl:template match="checkBox">
    <!--Supaya bisa di serialize-->
    <input type="hidden" name="{../@fieldName}" id="{../@fieldName}" value="{value}"/>
    <!--Supaya bisa di serialize-->



    <label id="{../@fieldName}caption" contenteditable="true">
      <input type="checkbox" value="{value}" id ="cb{../@fieldName}"  name="cb{../@fieldName}" data-type="checkBox" data-old="{value}"
      onchange="checkCB('{../@fieldName}');preview('{preview/.}', getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','', this);" contenteditable="true">
        <xsl:if test="value=1">
          <xsl:attribute name="checked">checked</xsl:attribute>
        </xsl:if>
      </input>
      <xsl:value-of select="titlecaption"/>
    </label>
    <div class="btn-group btn-group-sm studio-field" role="group" aria-label="Basic example">
      <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
        Field:
      </button>
      <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
        <ix class="fa fa-plus fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
        <ix class="fa fa-times fa-sm"></ix>
      </button>
    </div>

    <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
                    )
            ">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <label id="{../@fieldName}suffixCaption" contenteditable="true">
      <xsl:value-of select="suffixCaption"/>
    </label>

  </xsl:template>

  <xsl:template match="textEditor">
    <label id="{../@fieldName}caption" data-toggle="collapse" data-target="#section_{@sectionNo}" contenteditable="true">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
                    )
            ">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <textarea id ="{../@fieldName}" name ="{../@fieldName}" class="form-control">
      <xsl:choose>
        <xsl:when test="value != ''">
          <xsl:value-of select="value"/>
        </xsl:when>
        <xsl:otherwise>&#160;</xsl:otherwise>
      </xsl:choose>
    </textarea>

    <script type="text/javascript">
      CKEDITOR.replace('<xsl:value-of select="../@fieldName"/>');
      CKEDITOR.instances['<xsl:value-of select="../@fieldName"/>'].on('blur', function() {
      var teOldData = $('#<xsl:value-of select="../@fieldName"/>').html();
      var teData = CKEDITOR.instances['<xsl:value-of select="../@fieldName"/>'].getData();
      teData = teData.trim();
      $('#<xsl:value-of select="../@fieldName"/>').html(teData);
      if (teOldData != teData) {
      $('#button_save').show();
      $('#button_cancel').show();
      $('#button_save2').show();
      $('#button_cancel2').show();
      }
      preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','', this);
      });
    </script>
  </xsl:template>


  <xsl:template match="textArea">
    <label id="{../@fieldName}caption" contenteditable="true">
      <xsl:value-of select="titlecaption"/>
    </label>
    <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and ($docState='' or $docState=0 or $docState=300 or $cid = '00000000-0000-0000-0000-000000000000' or $settingMode='C' or $settingMode='M')) 
                        or (../@isEditable='2' and $cid = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and ($docState&lt;400 or $cid = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and ($docState&lt;500 or $cid = '00000000-0000-0000-0000-000000000000')))">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <!--default value-->
    <xsl:variable name="thisValue">
      <xsl:choose>
        <xsl:when test="$cid = '00000000-0000-0000-0000-000000000000' and defaultvalue != ''">
          <xsl:value-of select="defaultvalue/." />
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="value and value != ''">
              <xsl:value-of select="value"/>
            </xsl:when>
            <xsl:otherwise>&#160;</xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <textarea class="form-control" placeholder="input text..." name="{../@fieldName}" id ="{../@fieldName}" data-type="textArea" style="max-width:100%; min-width:100%; min-height:55px;"
      onblur="preview('{preview/.}',getCode(), '{$cid}','', this);" oninput="javascript:checkChanges(this)" >
      <xsl:value-of select="$thisValue"/>
    </textarea>
    <script>
      $('#<xsl:value-of select="../@fieldName"/>').val($.trim($('#<xsl:value-of select="../@fieldName"/>').val()));
    </script>

  </xsl:template>

  <xsl:template match="textBox">
    <label id="{../@fieldName}caption" contenteditable="true">
      <xsl:value-of select="titlecaption"/>
    </label>
    <div class="btn-group btn-group-sm studio-field" role="group" aria-label="Basic example">
      <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
        Field:
      </button>
      <div class="btn-group" role="group">
        <button id="btnGroupDrop1" type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
          aria-expanded="false" style="padding:1px 5px">
          <ix class="fa fa-plus fa-sm"></ix>
        </button>
        <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
          <a class="dropdown-item" href="#" style="display:block">Textbox</a>
          <a class="dropdown-item" href="#" style="display:block">Texteditor</a>
          <a class="dropdown-item" href="#" style="display:block">Textarea</a>
          <a class="dropdown-item" href="#" style="display:block">Passwordbox</a>
          <a class="dropdown-item" href="#" style="display:block">Hiddenbox</a>
          <a class="dropdown-item" href="#" style="display:block">Label</a>
          <a class="dropdown-item" href="#" style="display:block">Button</a>
          <a class="dropdown-item" href="#" style="display:block">Checkbox</a>
          <a class="dropdown-item" href="#" style="display:block">Autosuggestbox</a>
          <a class="dropdown-item" href="#" style="display:block">Tokenbox</a>
          <a class="dropdown-item" href="#" style="display:block">Radio</a>
          <a class="dropdown-item" href="#" style="display:block">Datebox</a>
          <a class="dropdown-item" href="#" style="display:block">Datetimebox</a>
          <a class="dropdown-item" href="#" style="display:block">Timebox</a>
          <a class="dropdown-item" href="#" style="display:block">Monthbox</a>
          <a class="dropdown-item" href="#" style="display:block">Yearbox</a>
          <a class="dropdown-item" href="#" style="display:block">Mediabox</a>
          <a class="dropdown-item" href="#" style="display:block">Profilebox</a>
          <a class="dropdown-item" href="#" style="display:block">Signaturebox</a>
          <a class="dropdown-item" href="#" style="display:block">GetGPSbox</a>
          <a class="dropdown-item" href="#" style="display:block">SetGPSbox</a>
        </div>
      </div>
      <button type="button" class="btn btn-secondary studio-setting" style="padding:1px 5px">
        <ix class="fa fa-sliders-v fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
        <ix class="fa fa-times fa-sm"></ix>
      </button>
    </div>


    <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
                    )
            ">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>


    <!--digit-->
    <xsl:variable name="tbContent">
      <xsl:choose>
        <xsl:when test="digit = 0 and value!=''">
          <xsl:value-of select="format-number(value, '###,###,###,##0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="digit  = 1 and value!=''">
          <xsl:value-of select="format-number(value, '###,###,###,##0.0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="digit  = 2 and value!=''">
          <xsl:value-of select="format-number(value, '###,###,###,##0.00', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="digit  = 3 and value!=''">
          <xsl:value-of select="format-number(value, '###,###,###,##0.000', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="digit  = 4 and value!=''">
          <xsl:value-of select="format-number(value, '###,###,###,##0.0000', 'dot-dec')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="value"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="align">
      <xsl:choose>
        <xsl:when test="align=0">left</xsl:when>
        <xsl:when test="align=1">center</xsl:when>
        <xsl:when test="align=2">right</xsl:when>
      </xsl:choose>
    </xsl:variable>

    <!--default value-->
    <xsl:variable name="thisvalue">
      <xsl:choose>
        <xsl:when  test="/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000' and defaultvalue != ''">
          <xsl:value-of select="defaultvalue/." />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$tbContent" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <input type="text" class="form-control" Value="{$thisvalue}" data-type="textBox" data-old="{$thisvalue}" name="{../@fieldName}"
           onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','', this);" id ="{../@fieldName}"
           oninput="javascript:checkChanges(this)">
      <xsl:attribute name="style">
        text-align:<xsl:value-of select="$align"/>
      </xsl:attribute>
    </input>
    <p id="{../@fieldName}suffixCaption">
      <xsl:value-of select="suffixCaption"/>
    </p>
  </xsl:template>

  <xsl:template match="textArea">
    <label id="{../@fieldName}caption" contenteditable="true">
      <xsl:value-of select="titlecaption"/>
    </label>
    <div class="btn-group btn-group-sm studio-field" role="group" aria-label="Basic example">
      <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
        Field:
      </button>
      <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
        <ix class="fa fa-plus fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-setting" style="padding:1px 5px">
        <ix class="fa fa-sliders-v fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
        <ix class="fa fa-times fa-sm"></ix>
      </button>
    </div>
    <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
                    )
            ">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <!--default value-->
    <xsl:variable name="thisValue">
      <xsl:choose>
        <xsl:when  test="$cid = '00000000-0000-0000-0000-000000000000' and defaultvalue != ''">
          <xsl:value-of select="defaultvalue/." />
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="value and value != ''">
              <xsl:value-of select="value"/>
            </xsl:when>
            <xsl:otherwise>&#160;</xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <textarea class="form-control" placeholder="input text..." name="{../@fieldName}" id ="{../@fieldName}"
	  data-type="textArea" style="max-width:100%; min-width:100%; min-height:55px;" rows="10"
      onblur="preview('{preview/.}',getCode(), '{$cid}','', this);" oninput="javascript:checkChanges(this)" >
      <xsl:value-of select="$thisValue"/>
    </textarea>
    <script>
      $('#<xsl:value-of select="../@fieldName"/>').val($.trim($('#<xsl:value-of select="../@fieldName"/>').val()));
    </script>

  </xsl:template>

  <xsl:template match="dateBox">
    <script>
      $('.datepicker').datepicker({autoclose: true});
    </script>
    <label id="{../@fieldName}caption" contenteditable="true">
      <xsl:value-of select="titlecaption"/>
    </label>
    <div class="btn-group btn-group-sm studio-field" role="group" aria-label="Basic example">
      <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
        Field:
      </button>
      <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
        <ix class="fa fa-plus fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-setting" style="padding:1px 5px">
        <ix class="fa fa-sliders-v fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
        <ix class="fa fa-times fa-sm"></ix>
      </button>
    </div>
    <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
                    )
            ">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>
    <div class="input-group date">
      <div class="input-group-addon">
        <ix class="fa fa-calendar"></ix>
      </div>
      <input type="text" class="form-control pull-right datepicker" id ="{../@fieldName}" name="{../@fieldName}"
		Value="{value}" data-type="dateBox" data-old="{value}"
        onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','', this);"
        onchange="checkChanges(this)" autocomplete="off">
      </input>
    </div>
  </xsl:template>

  <xsl:template match="dateTimeBox">
    <label id="{../@fieldName}caption" contenteditable="true">
      <xsl:value-of select="titlecaption"/>
    </label>
    <div class="btn-group btn-group-sm studio-field" role="group" aria-label="Basic example">
      <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
        Field:
      </button>
      <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
        <ix class="fa fa-plus fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-setting" style="padding:1px 5px">
        <ix class="fa fa-sliders-v fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
        <ix class="fa fa-times fa-sm"></ix>
      </button>
    </div>
    <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
                    )
            ">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>
    <div class="input-group date">
      <div class="input-group-addon">
        <ix class="fa fa-calendar"></ix>
      </div>
      <input type="text" class="form-control pull-right datetimepicker" id ="{../@fieldName}" name="{../@fieldName}" Value="{value}" data-type="dateTimeBox" data-old="{value}"
        onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','', this);" >
      </input>
    </div>
  </xsl:template>

  <xsl:template match="monthBox">
    <script>
      $('#<xsl:value-of select="../@fieldName" />_month').datepicker(
      {
      autoclose: true,
      format: 'M-yyyy',
      startView:'year',
      minViewMode:'months',
      defaultDate: new Date('<xsl:value-of select="value" />')
      }).on('change', function(){
      $('#<xsl:value-of select="../@fieldName" />').val($('#<xsl:value-of select="../@fieldName" />_month').data('datepicker').getFormattedDate('mmm/dd/yyyy'));
      preview('{preview/.}',getCode(), null,'');
      });

    </script>
    <label id="{../@fieldName}caption" contenteditable="true">
      <xsl:value-of select="titleCaption"/>
    </label>
    <div class="btn-group btn-group-sm studio-field" role="group" aria-label="Basic example">
      <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
        Field:
      </button>
      <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
        <ix class="fa fa-plus fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-setting" style="padding:1px 5px">
        <ix class="fa fa-sliders-v fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
        <ix class="fa fa-times fa-sm"></ix>
      </button>
    </div>
    <div class="input-group date">
      <div class="input-group-addon">
        <ix class="fa fa-calendar"></ix>
      </div>
      <input type="hidden" id ="{../@fieldName}" name="{../@fieldName}" value="{value}" />
      <input type="text" class="form-control pull-right monthpicker" id ="{../@fieldName}_month" name="{../@fieldName}_month" placeholder="{titleCaption}">
        <xsl:if test="../@isEditable=0">
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:if>
      </input>
    </div>
  </xsl:template>
  <xsl:template match="yearBox">
    <script>
      $('#<xsl:value-of select="../@fieldName" />_year').datepicker(
      {
      autoclose: true,
      format: 'M-yyyy',
      startView:'year',
      minViewMode:'years',
      defaultDate: new Date('<xsl:value-of select="value" />')
      }).on('change', function(){
      $('#<xsl:value-of select="../@fieldName" />').val($('#<xsl:value-of select="../@fieldName" />_year').data('datepicker').getFormattedDate('mm/dd/yyyy'));
      preview('{preview/.}',getCode(), null,'');
      });
    </script>
    <label id="{../@fieldName}caption" contenteditable="true">
      <xsl:value-of select="titleCaption"/>
    </label>
    <div class="btn-group btn-group-sm studio-field" role="group" aria-label="Basic example">
      <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
        Field:
      </button>
      <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
        <ix class="fa fa-plus fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-setting" style="padding:1px 5px">
        <ix class="fa fa-sliders-v fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
        <ix class="fa fa-times fa-sm"></ix>
      </button>
    </div>
    <div class="input-group date">
      <div class="input-group-addon">
        <ix class="fa fa-calendar"></ix>
      </div>
      <input type="hidden" id ="{../@fieldName}" name="{../@fieldName}" value="{value}" />
      <input type="text" class="form-control pull-right yearpicker" id ="{../@fieldName}_year" name="{../@fieldName}_year" placeholder="{titleCaption}">
        <xsl:if test="../@isEditable=0">
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:if>
      </input>
    </div>
  </xsl:template>
  <xsl:template match="passwordBox">
    <label id="{../@fieldName}caption" contenteditable="true">
      <xsl:value-of select="titlecaption"/>
    </label>
    <div class="btn-group btn-group-sm studio-field" role="group" aria-label="Basic example">
      <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
        Field:
      </button>
      <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
        <ix class="fa fa-plus fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-setting" style="padding:1px 5px">
        <ix class="fa fa-sliders-v fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
        <ix class="fa fa-times fa-sm"></ix>
      </button>
    </div>
    <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
                    )
            ">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <input type="password" class="form-control" Value="" data-type="textBox" data-old="" name="{../@fieldName}"
           minlength="8" required="required" placeholder="8 characters minimum."
      onblur="preview('{preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','', this);" id ="{../@fieldName}" autocomplete="false">
    </input>

  </xsl:template>

  <xsl:template match="timeBox">
    <script>//timebox</script>
    <label id="{../@fieldName}caption" contenteditable="true">
      <xsl:value-of select="titlecaption"/>
    </label>
    <div class="btn-group btn-group-sm studio-field" role="group" aria-label="Basic example">
      <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
        Field:
      </button>
      <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
        <ix class="fa fa-plus fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-setting" style="padding:1px 5px">
        <ix class="fa fa-sliders-v fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
        <ix class="fa fa-times fa-sm"></ix>
      </button>
    </div>
    <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
                    )
            ">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <div class="input-group date">
      <div class="input-group-addon">
        <ix class="fa fa-clock-o"></ix>
      </div>
      <input type="text" class="form-control pull-right timepicker" id ="{../@fieldName}" name="{../@fieldName}"
             data-type="timeBox" data-old="{value}" Value="{value}"
             onblur="preview('{preview/.}','{/sqroot/body/bodyContent/form/code/id}', '{/sqroot/body/bodyContent/form/info/GUID/.}','', this);" >
      </input>
    </div>
  </xsl:template>


  <xsl:template match="mediaBox">
    <label id="{../@fieldName}caption" name="{../@fieldName}caption" contenteditable="true">
      <xsl:value-of select="titlecaption"/>
    </label>
    <div class="btn-group btn-group-sm studio-field" role="group" aria-label="Basic example">
      <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
        Field:
      </button>
      <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
        <ix class="fa fa-plus fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-setting" style="padding:1px 5px">
        <ix class="fa fa-sliders-v fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
        <ix class="fa fa-times fa-sm"></ix>
      </button>
    </div>
    <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
                    )
            ">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>
    <!--default value-->
    <xsl:variable name="thisvalue">
      <xsl:choose>
        <xsl:when  test="/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000' and defaultvalue != ''">
          <xsl:value-of select="defaultvalue/." />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="value"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <div class="input-group">
      <label class="input-group-btn" contenteditable="true">
        <span class="btn btn-primary">
          Browse <input id ="{../@fieldName}_hidden" name="{../@fieldName}_hidden" type="file" data-code="{/sqroot/body/bodyContent/form/info/code}" data-child="Y" style="display: none;" multiple="" />
        </span>
      </label>
      <input id ="{../@fieldName}" name="{../@fieldName}" Value="{value}" type="text" class="form-control" readonly="" />
      <span class="input-group-btn">
        <button class="btn btn-secondary" type="button" onclick="javascript:popTo('OPHcore/api/msg_download.aspx?fieldAttachment={../@fieldName}&#38;code={/sqroot/body/bodyContent/form/info/code/.}&#38;GUID={/sqroot/body/bodyContent/form/info/GUID/.}');">
          <xsl:if test="/sqroot/body/bodyContent/form/info/GUID='00000000-0000-0000-0000-000000000000'">
            <xsl:attribute name="disabled">disabled</xsl:attribute>
          </xsl:if>
          <ix class="fa fa-paperclip"></ix>&#160;
        </button>
      </span>
    </div>
  </xsl:template>
  <xsl:template match="autoSuggestBox">
    <label id="{../@fieldName}caption" contenteditable="true">
      <xsl:value-of select="titlecaption"/>
    </label>
    <div class="btn-group btn-group-sm studio-field" role="group" aria-label="Basic example">
      <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
        Field:
      </button>
      <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
        <ix class="fa fa-plus fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-setting" style="padding:1px 5px">
        <ix class="fa fa-sliders-v fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
        <ix class="fa fa-times fa-sm"></ix>
      </button>
    </div>
    <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
                    )
            ">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>
    <select class="form-control select2" style="width: 100%;" name="{../@fieldName}" id="{../@fieldName}"
	    data-type="selectBox" data-old="{value/.}" data-oldText="{value/.}" data-value="{value/.}"
        onchange="autosuggest_onchange(this, '{preview/.}', getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}', '');" >
      <!--option id="{value/.}" selected="selected"><xsl:value-of select="combovalue/."/></option-->
      <option></option>
    </select>




    <!--AutoSuggest Add New Form Modal-->
    <xsl:if test="(@allowAdd&gt;=1 or @allowEdit=1) and ../@isEditable=1">
      <div id="addNew{../@fieldName}" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
                <span aria-hidden="true">&#215;</span>
              </button>
              <div style="float:left;margin-top:-15px;">
                <h3>
                  <xsl:value-of select="titlecaption"/>
                </h3>
                <span>(Quick Add New Data Set)</span>
              </div>
              <div style="float:left">
                <a id="link{../@fieldName}" data-toggle="tooltip" data-placement="right" title="Click to see more detail" style="cursor:pointer;" onclick="">
                  <ix class="fa fa-external-link fa-2x"></ix>
                </a>
                <script>
                  $('#link<xsl:value-of select="../@fieldName"/>').click(function(){
                  var guid = (isGuid($('#<xsl:value-of select="../@fieldName"/>').val())) ? $('#<xsl:value-of select="../@fieldName"/>').val() : '00000000-0000-0000-0000-000000000000';
                  var url = '?code=<xsl:value-of select="@comboCode"/>&amp;guid=' + guid;
                  window.open(url);
                  });
                </script>
              </div>
            </div>
            <div class="modal-body">
              <div class="row" id="modalForm{../@fieldName}">
                &#160;
              </div>
            </div>
            <script>
              if ($('body').children('#addNew<xsl:value-of select="../@fieldName"/>').length == 1) {
              $('body').children('#addNew<xsl:value-of select="../@fieldName"/>').remove();
              }
              $('#addNew<xsl:value-of select="../@fieldName"/>').appendTo("body");
              $('#addNew<xsl:value-of select="../@fieldName"/>').on('show.bs.modal', function (event) {
              $('#<xsl:value-of select="../@fieldName"/>').select2('close');
              $('#modalForm<xsl:value-of select="../@fieldName"/>').append('<div class="col-md-12"></div>');
              $('#modalForm<xsl:value-of select="../@fieldName"/>').children('.col-md-12').append('<div style="float:left;"></div>');
              $('#modalForm<xsl:value-of select="../@fieldName"/>').children('.col-md-12').append('<div style="float:left; margin-left:10px;font-size:20px;">Please wait...</div>');
              $('#modalForm<xsl:value-of select="../@fieldName"/>').children('.col-md-12').children('div:first').append('<ix class="fa fa-spinner fa-pulse fa-2x fa-fw"></ix>');
              }).on('shown.bs.modal', function (event) {
              if (isGuid($('#<xsl:value-of select="../@fieldName"/>').val()) &amp;&amp; $(event.relatedTarget).data('action') == 'edit' ) {
              loadModalForm('modalForm<xsl:value-of select="../@fieldName"/>', '<xsl:value-of select="@comboCode"/>', $('#<xsl:value-of select="../@fieldName"/>').val());
              }
              else {
              loadModalForm('modalForm<xsl:value-of select="../@fieldName"/>', '<xsl:value-of select="@comboCode"/>', '00000000-0000-0000-0000-000000000000');
              }
              }).on('hide.bs.modal', function(event){
              $('#modalForm<xsl:value-of select="../@fieldName"/>').children('div').remove();
              $('#modalForm<xsl:value-of select="../@fieldName"/>').children('form').remove();
              $('#modalForm<xsl:value-of select="../@fieldName"/>').children('button').remove();
              $('#addNew<xsl:value-of select="../@fieldName"/> .modal-footer').children('button[id*="btn_save"]').remove();
              $('#modalForm<xsl:value-of select="../@fieldName"/>').text('&#160;');
              });
            </script>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal" >Cancel</button>
            </div>
          </div>
        </div>
      </div>

      <xsl:if test="@allowAdd&gt;=1">
        <span class="select2-search select2-box--dropdown" id="select2-{../@fieldName}-addNew" style="display:none;">
          <ul class="select2-results__options" role="tree" aria-expanded="true" aria-hidden="false">
            <li class="select2-results__option" role="treeitem" aria-selected="false">
              <a data-toggle="modal" data-target="#addNew{../@fieldName}" data-backdrop="false" data-action="new">
                Add New <xsl:value-of select="titlecaption"/>
              </a>
            </li>
          </ul>
        </span>
        <script>
          $("#<xsl:value-of select="../@fieldName"/>").on("select2:open", function(e) {
          var s2id = $("span[class*='select2-dropdown select2-dropdown']").children('.select2-results').children().attr('id');
          s2id = s2id.split('select2-').join('').split('-results').join('');
          if (s2id == '<xsl:value-of select="../@fieldName"/>') {
          $('#select2-<xsl:value-of select="../@fieldName"/>-addNew').appendTo("span[class*='select2-dropdown select2-dropdown']").show();
          }
          });
        </script>
      </xsl:if>
      <xsl:if test="@allowEdit=1">
        <span id="editForm{../@fieldName}" data-toggle="modal" data-target="#addNew{../@fieldName}" data-backdrop="static" data-action="edit"

          style="cursor: pointer;margin: 8px 45px 0px 0px;position: absolute;top: 0px;right: 0px; display:none">
          <ix class="far fa-pencil-alt" title= "Edit" data-toggle="tooltip"></ix>
        </span>

        <script>
          $("#<xsl:value-of select="../@fieldName"/>").on("select2:select", function(e) {
          $selection = $('#select2-<xsl:value-of select="../@fieldName"/>-container').parents('.selection');
          if ($selection.children('#editForm<xsl:value-of select="../@fieldName"/>').length == 0)
          $('#editForm<xsl:value-of select="../@fieldName"/>').appendTo($selection);
          $('#editForm<xsl:value-of select="../@fieldName"/>').show();
          });
        </script>
      </xsl:if>
    </xsl:if>


    <xsl:if test="@allowEdit=1">
      <span id="removeForm{../@fieldName}" style="cursor: pointer;margin: 8px 30px 0px 0px;position: absolute;top: 0px;right: 0px; display:none">
        <ix class="far fa-times" title= "Remove Selection" data-toggle="tooltip" onclick="javascript: $('#{../@fieldName}').val(null).trigger('change');$('#editForm{../@fieldName}').hide();$('#removeForm{../@fieldName}').hide();"></ix>
      </span>
      <script>
        $("#<xsl:value-of select="../@fieldName"/>").on("select2:select", function(e) {
        $selection = $('#select2-<xsl:value-of select="../@fieldName"/>-container').parents('.selection');
        if ($selection.children('#removeForm<xsl:value-of select="../@fieldName"/>').length == 0)
        $('#removeForm<xsl:value-of select="../@fieldName"/>').appendTo($selection);
        $('#removeForm<xsl:value-of select="../@fieldName"/>').show();
        });
      </script>
    </xsl:if>

    <script>
      //try{
      $("#<xsl:value-of select="../@fieldName"/>").select2({
      placeholder: 'Select <xsl:value-of select="titlecaption"/>',
      onAdd: function(x) {
      preview('<xsl:value-of select="preview/."/>', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','', this);
      },
      onDelete: function(x) {
      preview('<xsl:value-of select="preview/."/>', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','', this);
      },

      ajax: {
      url:"OPHCORE/api/msg_autosuggest.aspx",
      delay : 0, //500
      data: function (params) {
      var query = {
      code:"<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>",
      colkey:"<xsl:value-of select="../@fieldName"/>",
      search: params.term==undefined?'':params.term.toString().split('+').join('%2B'),
      wf1value: ('<xsl:value-of select='whereFields/wf1'/>'=='' || $("#<xsl:value-of select='whereFields/wf1'/>").val() == undefined ? "" : $("#<xsl:value-of select='whereFields/wf1'/>").val()),
      wf2value: ('<xsl:value-of select='whereFields/wf2'/>'=='' || $("#<xsl:value-of select='whereFields/wf2'/>").val() == undefined ? "" : $("#<xsl:value-of select='whereFields/wf2'/>").val()),
      parentCode: getCode(),
      page: params.page
      }
      return query;

      },
      dataType: 'json',

      /*
      results: function (data) {
      return {
      results: $.map(data, function(obj) {
      return { id: obj.id, text: obj.text };
      })
      };
      },*/

      processResults: function (data, params) {
      params.page = params.page || 1;
      return {
      results: data.results,
      pagination: {
      more: data.more
      }
      };
      }

      }
      });

      //}
      //catch (e) {}

      <xsl:if test="value!=''">
        //autosuggest_setValue(deferreds, '<xsl:value-of select="../@fieldName"/>','<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>','<xsl:value-of select='../@fieldName'/>', '<xsl:value-of select='value'/>', '<xsl:value-of select='whereFields/wf1'/>', '<xsl:value-of select='whereFields/wf2'/>')
        autosuggest_defaultValue('<xsl:value-of select="../@fieldName"/>','<xsl:value-of select='value'/>','<xsl:value-of select='translate(combovalue, "&#39;", "\&#39;")'/>')
      </xsl:if>
    </script>



  </xsl:template>

  <xsl:template match="tokenBox">
    <!--<script type="text/javascript">
      var sURL<xsl:value-of select="../@fieldName"/><xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>='OPHCore/api/msg_autosuggest.aspx?mode=token&amp;code=<xsl:value-of select="code/."/>&amp;key=<xsl:value-of select="../@fieldName"/>&amp;colkey=<xsl:value-of select="../@fieldName"/>'
      var noPrepopulate<xsl:value-of select="../@fieldName"/><xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>=1;
      <xsl:if test="value">
        noPrepopulate<xsl:value-of select="../@fieldName"/><xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>=0;
      </xsl:if>
      var cURL<xsl:value-of select="../@fieldName"/><xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>='OPHCore/api/msg_autosuggest.aspx?mode=token&amp;code=<xsl:value-of select="code/."/>&amp;key=<xsl:value-of select="../@fieldName"/>&amp;colkey=<xsl:value-of select="../@fieldName"/>&amp;search=<xsl:value-of select="value"/>'

      $(document).ready(function(){
      $.ajax({
      url: cURL<xsl:value-of select="../@fieldName"/><xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>,
      dataType: 'json',
      success: function(data){
      if (noPrepopulate<xsl:value-of select="../@fieldName"/><xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>==1) data='';
      $("#<xsl:value-of select="../@fieldName"/><xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>").tokenInput(
      sURL<xsl:value-of select="../@fieldName"/><xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>,
      {
      hintText: "please type...",
      searchingText: "Searching...",
      preventDuplicates: true,
      allowCustomEntry: true,
      highlightDuplicates: false,
      tokenDelimiter: "*",
      theme:"facebook",
      prePopulate: data,
      onReady: function(x) {
      },
      onAdd: function(x) {
      preview('<xsl:value-of select="preview/."/>', '<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>', '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','form<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>', this);
      },
      onDelete: function(x) {
      preview('<xsl:value-of select="preview/."/>', '<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>', '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','form<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>', this);
      }
      }
      );
      }
      });
      });
    </script>-->
    <script type="text/javascript">
      var sURL<xsl:value-of select="../@fieldName"/>='OPHCore/api/msg_autosuggest.aspx?mode=token&amp;code=<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>&amp;colkey=<xsl:value-of select="../@fieldName"/>'
      var noPrepopulate<xsl:value-of select="../@fieldName"/>=1;
      <xsl:if test="value">
        noPrepopulate<xsl:value-of select="../@fieldName"/>=0;
      </xsl:if>
      var cURL<xsl:value-of select="../@fieldName"/>='OPHCore/api/msg_autosuggest.aspx?mode=token&amp;nbRow=0&amp;code=<xsl:value-of select="/sqroot/body/bodyContent/form/info/code/."/>&amp;colkey=<xsl:value-of select="../@fieldName"/>'
      var dataForm = new FormData();
      dataForm.append('search', '<xsl:value-of select="value"/>');

      $(document).ready(function(){
      $.ajax({
      url: cURL<xsl:value-of select="../@fieldName"/>,
      method: 'POST',
      data: dataForm,
      processData: false,
      contentType: false,
      dataType: 'json',
      success: function(data){
      if (noPrepopulate<xsl:value-of select="../@fieldName"/>==1) data='';
      $("#<xsl:value-of select="../@fieldName"/>").tokenInput(
      sURL<xsl:value-of select="../@fieldName"/>,
      {
      hintText: "please type...",
      searchingText: "Searching...",
      preventDuplicates: true,
      allowCustomEntry: true,
      highlightDuplicates: false,
      tokenDelimiter: "*",
      theme:"facebook",
      prePopulate: data,
      onReady: function(x) {
      },
      onAdd: function(x) {
      preview('<xsl:value-of select="preview/."/>', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','', this);
      },
      onDelete: function(x) {
      preview('<xsl:value-of select="preview/."/>', getCode(), '<xsl:value-of select="/sqroot/body/bodyContent/form/info/GUID/."/>','', this);
      }
      }
      );
      }
      });
      });
    </script>

    <label id="{../@fieldName}caption" contenteditable="true">
      <xsl:value-of select="titlecaption"/>
    </label>
    <div class="btn-group btn-group-sm studio-field" role="group" aria-label="Basic example">
      <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
        Field:
      </button>
      <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
        <ix class="fa fa-plus fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-setting" style="padding:1px 5px">
        <ix class="fa fa-sliders-v fa-sm"></ix>
      </button>
      <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
        <ix class="fa fa-times fa-sm"></ix>
      </button>
    </div>
    <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
                    )
            ">
      <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
    </xsl:if>

    <!--digit-->
    <xsl:variable name="tbContent">
      <xsl:value-of select="value"/>
    </xsl:variable>

    <!--default value-->
    <xsl:variable name="thisvalue">
      <xsl:choose>
        <xsl:when  test="/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000' and defaultvalue != ''">
          <xsl:value-of select="defaultvalue/." />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$tbContent" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <input type="text" class="form-control" Value="{$thisvalue}" data-type="tokenBox" data-old="{$thisvalue}" data-newJSON="" data-code="{code/.}"
      data-key="{key}" data-id="{id}" data-name="{name}"
      name="{../@fieldName}" id ="{../@fieldName}">
      <xsl:choose>
        <xsl:when test="((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and /sqroot/body/bodyContent/form/info/state/status/.&lt;400)
                        or (../@isEditable='4' and /sqroot/body/bodyContent/form/info/state/status/.&lt;500))">
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="disabled">disabled</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>
  </xsl:template>
  <xsl:template match="profileBox">
  </xsl:template>


  <xsl:template match="radio">
    <xsl:variable name="radioVal">
      <xsl:choose>
        <xsl:when test="(/sqroot/body/bodyContent/form/info/GUID/.) = '00000000-0000-0000-0000-000000000000'">
          <xsl:value-of select="defaultvalue" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="value" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <script>
      function <xsl:value-of select="../@fieldName" />_hide(shownId) {
      $('#accordion_<xsl:value-of select="../@fieldName" />').children().each(function(){
      if ($(this).hasClass('in') &#38;&#38; this.id!=shownId) {
      $(this).collapse('toggle');
      }
      });

      }
      <xsl:if test="$radioVal != ''">
        panel_display('<xsl:value-of select="../@fieldName"/>', '<xsl:value-of select="$radioVal"/>', true);
      </xsl:if>

    </script>
    <div>
      <label id="{../@fieldName}caption" contenteditable="true">
        <xsl:value-of select="titlecaption"/>
      </label>
      <div class="btn-group btn-group-sm studio-radio" role="group" aria-label="Basic example">
        <button type="button" class="btn btn-secondary disabled" style="padding:1px 5px">
          Radio:
        </button>
        <button type="button" class="btn btn-secondary studio-add" style="padding:1px 5px">
          <ix class="fa fa-plus fa-sm"></ix>
        </button>
        <button type="button" class="btn btn-secondary studio-setting" style="padding:1px 5px">
          <ix class="fa fa-sliders-v fa-sm"></ix>
        </button>
        <button type="button" class="btn btn-secondary studio-remove" style="padding:1px 5px">
          <ix class="fa fa-times fa-sm"></ix>
        </button>
      </div>
      <xsl:if test="../@isNullable = 0 and 
                    ((../@isEditable='1' and (/sqroot/body/bodyContent/form/info/state/status/.='' or /sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')) 
                        or (../@isEditable='2' and /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000')
                        or (../@isEditable='3' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='4' and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500 or /sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='6' 
                              and (/sqroot/body/bodyContent/form/info/state/status/.=0 or /sqroot/body/bodyContent/form/info/state/status/.=300)
                              and not(/sqroot/body/bodyContent/form/info/GUID/. = '00000000-0000-0000-0000-000000000000'))
                        or (../@isEditable='7' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=300) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;400))
                        or (../@isEditable='8' and (/sqroot/body/bodyContent/form/info/state/status/.&gt;=400) and (/sqroot/body/bodyContent/form/info/state/status/.&lt;500))
                    )
            ">
        <span id="rfm_{../@fieldName}" style="color:red;float:right;">required field</span>
      </xsl:if>
    </div>
    <div class = "btn-group" data-toggle = "radios">
      <xsl:apply-templates select="radioSections/radioSection"/>
    </div>
    <xsl:if test="radioSections/radioSection/radioRows">
      <div class="panel-body" id="accordion_{../@fieldName}" style="box-shadow:none;border:none;display:none;">
        <xsl:for-each select="radioSections/radioSection">
          <!--<xsl:if test="radioSections/radioSection/radioRows/radioRow">-->
          <div id="panel_{../../../@fieldName}_{@radioNo}" class="box collapse" style="box-shadow:none;border:none;padding-bottom:0;padding-top:0;margin-bottom:0">
            <xsl:apply-templates select="radioRows/radioRow/fields" />
          </div>
          <!--</xsl:if>-->
        </xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="radioSections/radioSection">

    <xsl:variable name="pandis" select="count(radioRows)"/>
    <xsl:variable name="radioVal1">
      <xsl:choose>
        <xsl:when test="(/sqroot/body/bodyContent/form/info/GUID/.) = '00000000-0000-0000-0000-000000000000'">
          <xsl:value-of select="../../defaultvalue" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="../../value" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="@fieldName=$radioVal1">
        <xsl:choose>
          <xsl:when test="radioRows">
            <label class="radio-inline" for="{../../../@fieldName}_{@radioNo}" onclick="panel_display('{../../../@fieldName}', '@radioNo');
                   preview('{../../preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','', this);"  contenteditable="true">
              <input type="radio" name="{../../../@fieldName}" id="{../../../@fieldName}_{@radioNo}" value="{@fieldName}" checked="checked" />
              <xsl:value-of select="@radioRowTitle"/>
            </label>
          </xsl:when>
          <xsl:otherwise>
            <label class="radio-inline" for="{../../../@fieldName}_{@radioNo}" onclick="panel_display('{../../../@fieldName}', '@radioNo');
                   preview('{../../preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','', this);"  contenteditable="true">
              <input type="radio" name="{../../../@fieldName}" id="{../../../@fieldName}_{@radioNo}" value="{@fieldName}" checked="checked" />
              <xsl:value-of select="@radioRowTitle"/>
            </label>
          </xsl:otherwise>
        </xsl:choose>
        <script>
          $('#panel_<xsl:value-of select="../../../@fieldName" />_<xsl:value-of select="@radioNo" />').collapse('show');
        </script>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="radioRows">
            <label class="radio-inline" for="{../../../@fieldName}_{@radioNo}" onclick="panel_display('{../../../@fieldName}', '{@radioNo}');
                   preview('{../../preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','', this);"  contenteditable="true">
              <input type="radio" name="{../../../@fieldName}" id="{../../../@fieldName}_{@radioNo}" value="{@fieldName}" />
              <xsl:value-of select="@radioRowTitle"/>
            </label>
          </xsl:when>
          <xsl:otherwise>
            <label class="radio-inline" for="{../../../@fieldName}_{@radioNo}" onclick="panel_display('{../../../@fieldName}', '{@radioNo}');
                   preview('{../../preview/.}',getCode(), '{/sqroot/body/bodyContent/form/info/GUID/.}','', this);"  contenteditable="true">
              <input type="radio" name="{../../../@fieldName}" id="{../../../@fieldName}_{@radioNo}" value="{@fieldName}" />
              <xsl:value-of select="@radioRowTitle"/>
            </label>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>

    <script>
      $('#<xsl:value-of select="../../../@fieldName" />_<xsl:value-of select="@radioNo" />').click(function(){
      <xsl:value-of select="../../../@fieldName" />_hide('panel_<xsl:value-of select="../../../@fieldName" />_<xsl:value-of select="@radioNo" />');
      $('#panel_<xsl:value-of select="../../../@fieldName" />_<xsl:value-of select="@radioNo" />').collapse('show');
      var x=$('input[name=<xsl:value-of select="../../../@fieldName" />]:checked').val();
      $('#<xsl:value-of select="../../../@fieldName" />').val(x);
      });
      <xsl:if test="../../../@isEditable=0">
        $('#<xsl:value-of select="../../../@fieldName" />_<xsl:value-of select="@radioNo" />').attr('disabled', true);
      </xsl:if>
    </script>
  </xsl:template>

  <xsl:template match="radioRow/fields">
    <xsl:apply-templates select="field" />
  </xsl:template>

  <xsl:template match="formChildren">
    <xsl:apply-templates select="formChild"/>
  </xsl:template>

  <xsl:template match="formChild">
    <xsl:if test="info/permission/allowBrowse&gt;=1">
      <input type="hidden" id="PKID" value="child{code/.}"/>
      <input type="hidden" id="filter{code/.}" value="{parentkey/.}='{$cid}'"/>
      <input type="hidden" id="parent{code/.}" value="{parentkey/.}"/>
      <input type="hidden" id="PKName" value="{parentkey/.}"/>
      <script>

        var code='<xsl:value-of select ="code/."/>';
        var parentKey='<xsl:value-of select ="parentkey/."/>';
        var GUID='<xsl:value-of select ="$cid"/>';
        var browsemode='<xsl:value-of select ="browseMode/."/>';
        loadChild(code, parentKey, GUID, 1, browsemode);
      </script>

      <div class="box box-solid box-default child" data-code="{code/.}" data-parentKey="{parentkey/.}" data-guid="{$cid}" data-mode="{browseMode/.}"
		    style="box-shadow:0px;border:none" id="child{translate(code/., $uppercase, $smallcase)}{translate($cid, $uppercase, $smallcase)}">
        &#160;
      </div>

    </xsl:if>
  </xsl:template>


</xsl:stylesheet>