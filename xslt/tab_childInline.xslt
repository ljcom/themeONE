<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:variable name="lowerCode"><xsl:value-of select="translate(/sqroot/body/bodyContent/browse/info/code, $uppercase, $smallcase)"/></xsl:variable>
  <xsl:variable name="nbCol"><xsl:value-of select="count(/sqroot/body/bodyContent/browse/header/column)" /></xsl:variable>
  <xsl:variable name="parentState" select="/sqroot/body/bodyContent/browse/info/parentState" />
  <xsl:variable name="settingMode" select="/sqroot/header/info/code/settingMode/." />

  <xsl:template match="/">
    <script>
      var code='<xsl:value-of select="$lowerCode"/>';
      cell_init(code);
      studio_init();
      
      upload_init(code, function(data) {
      var err=''; s=0;
      $(data).find("sqroot").find("message").each(function (i) {
      var item=$(data).find("sqroot").find("message").eq(i);
      if ($(item).text()!='') err += $(item).text()+' ';
      })

      $(data).find("sqroot").find("guid").each(function (i) {
      var sn=$(data).find("sqroot").find("guid").eq(i);
      if (sn!='') s++;
      })
      var msg='Upload Status: Success: '+s+(err==''?'':' Error: '+err);
      showMessage(msg);

      var code='<xsl:value-of select="$lowerCode"/>';
	  preview('1', getCode(), getGUID(),'', this);
      loadChild(code);
      });
      
	  
      $(document).ready(function(){
      if($('th[data-order="DESC"]').length == 1) $('th[data-order="DESC"]').append(' &lt;ix class="fa fa-sort-alpha-desc" /&gt;');
        else if($('th[data-order="ASC"]').length == 1) $('th[data-order="ASC"]').append(' &lt;ix class="fa fa-sort-alpha-asc" /&gt;');
      });
	  
      var tblnm =code+"requiredname";
      var columns_<xsl:value-of select="$lowerCode"/>=[];
      //setCookie('<xsl:value-of select="$lowerCode"/>_parent', '<xsl:value-of select="/sqroot/body/bodyContent/browse/info/filter"/>', 1);
      var <xsl:value-of select="$lowerCode"/>_parent='<xsl:value-of select="/sqroot/body/bodyContent/browse/info/filter"/>';

      
      <xsl:if test="/sqroot/body/bodyContent/browse/info/buttons">
        buttons=<xsl:value-of select="sqroot/body/bodyContent/browse/info/buttons"/>;
        loadExtraButton(buttons, 'browse-action-button',10);
      </xsl:if>

      function js_save() {
      cell_save((function(d) {js_saveafter(d)}), (function(d) {js_savebefore(d)}));
      }

      function js_saveafter(d) {}
      function js_savebefore(d) {}
    </script>
    <input type="hidden" name ="{$lowerCode}requiredname"/>
    <input type="hidden" name ="{$lowerCode}requiredtblvalue"/>
    <xsl:apply-templates select="sqroot/body/bodyContent/browse/children" />

    <div class="row">
      <div class="col-md-12">
        <div class="box-header with-border" style="background:white">
          <h3 class="dashboard-title" style="display:inline" contenteditable="true">
            <xsl:value-of select="sqroot/body/bodyContent/browse/info/description"/>
          </h3>
        </div>
        <div>
          <input style="width:200px; position:absolute; right:25px; top:5px; padding-right:25px;" type="text" id="searchBox_{sqroot/body/bodyContent/browse/info/code}" name="searchBox_{sqroot/body/bodyContent/browse/info/code}"
            class="form-control" placeholder="Enter search key..." value="{sqroot/body/bodyContent/browse/info/search}"
              onkeypress="searchTextChild(event, this.value, '{sqroot/body/bodyContent/browse/info/code}');" />
          <button id="clear{sqroot/body/bodyContent/browse/info/code}" type="button" class="btn btn-flat" style="position:absolute; right:25px; top:5px; background:none; border:none; display:none" >
            <span aria-hidden="true">&#215;</span>
          </button>
          <script>
            $('#clear<xsl:value-of select="sqroot/body/bodyContent/browse/info/code"/>').click(function(event) {
            searchTextChild(event, '', '<xsl:value-of select="sqroot/body/bodyContent/browse/info/code"/>', true);
            });

            $(document).ready(function() {
            if ($('#searchBox_<xsl:value-of select="sqroot/body/bodyContent/browse/info/code"/>').val() != '') {
            $('#clear<xsl:value-of select="sqroot/body/bodyContent/browse/info/code"/>').show();
            }
            });
          </script>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div style="border:0px none white;box-shadow:none;" id="content_{$lowerCode}" class="box collapse in">
              <div style="border:0px none white;box-shadow:none;overflow:auto">
                <table class="table table-condensed strip-table-browse cell-table" style="border-collapse:collapse">
                  <thead>
                    <tr style="background:#3C8DBC; color:white">
                      <xsl:if test="count(/sqroot/body/bodyContent/browse/children/child)>0">
                        <th style="width:28px;"></th>
                      </xsl:if>
                      <th style="width:28px;" class="cell-recordSelectors"></th>
                      <xsl:apply-templates select="sqroot/body/bodyContent/browse/header"/>
                      <xsl:if test="/sqroot/body/bodyContent/browse/info/buttons">
                        <th id="actionHeader" class="text-right">
                          <span>ACTION</span>
                        </th>
                      </xsl:if>
                    </tr>
                  </thead>
                  <tbody id="{$lowerCode}">
                    <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
                  </tbody>
                </table>
              </div>
			  <div id="{$lowerCode}reportButton">
			  </div>
              <!-- /.box-body -->
              <div class="box-footer clearfix">
                <xsl:if test="(
                          ((/sqroot/body/bodyContent/browse/info/permission/allowAdd/.)='1' and ($parentState &lt; 100 or not ($parentState)))
                          or ((/sqroot/body/bodyContent/browse/info/permission/allowAdd/.)='3' and ($parentState &lt; 400))
                          or ((/sqroot/body/bodyContent/browse/info/permission/allowAdd/.)='4' and ($parentState &lt; 500))
                        )">
                  <button id="cell_button_add" class="btn btn-orange-a" style="margin-right:5px;margin-bottom:5px;"
                          onclick="cell_add('{$lowerCode}', columns_{$lowerCode}, {count(/sqroot/body/bodyContent/browse/children)}, this);">ADD</button>
                </xsl:if>
                <button id="cell_button_save" class="btn btn-orange-a" style="display:none; margin-right:5px;margin-bottom:5px;" onclick="js_save();">SAVE</button>
                <button id="cell_button_cancel" class="btn btn-gray-a" style="display:none; margin-right:5px;margin-bottom:5px;" onclick="cell_cancelSave()">CANCEL</button>

                <xsl:if test="(
                          ((/sqroot/body/bodyContent/browse/info/permission/allowDelete/.)='1' and ($parentState &lt; 100 or not ($parentState)))
                          or ((/sqroot/body/bodyContent/browse/info/permission/allowDelete/.)='3' and ($parentState &lt; 400))
                          or ((/sqroot/body/bodyContent/browse/info/permission/allowDelete/.)='4' and ($parentState &lt; 500))
                        )">
                  <button id="cell_button_delete" class="btn btn-gray-a" style="margin-right:5px;margin-bottom:5px;" onclick="cell_delete('{$lowerCode}', this)">DELETE</button>
                </xsl:if>
                <xsl:if test="(/sqroot/body/bodyContent/browse/info/permission/allowAdd/.)&gt;=1 and (/sqroot/body/bodyContent/browse/info/permission/allowExport/.)=1" >
                  <button id="cell_button_download" class="btn btn-gray-a" style="margin-right:5px;margin-bottom:5px;"
                          onclick="downloadChild('{$lowerCode}', this)">DOWNLOAD</button>
                  <button id="cell_button_upload" class="btn btn-gray-a" style="margin-right:5px;margin-bottom:5px;" onclick="javascript:$('#import_hidden').click();">UPLOAD...</button>

                  <!--<button type="button" class="buttonCream" id="download" name="download" onclick="javascript:PrintDirect('{$lowerCode}', '', 3, '', '', '');">DOWNLOAD</button>
                  <button type="button" class="buttonCream" id="upload" name="upload" onclick="javascript:showSubBrowseView('{$lowerCode}','',1,'');">UPLOAD</button>-->
                  <input id ="import_hidden" name="import_hidden" type="file" data-code="{$lowerCode}" style="visibility: hidden; width: 0; height: 0;" multiple="" />
                </xsl:if>
                <xsl:if test="/sqroot/body/bodyContent/browse/info/nbPages > 1">
                  <ul class="pagination pagination-sm no-margin pull-right" id="childPageNo"></ul>
                  <script>
                    var code='<xsl:value-of select ="$lowerCode"/>';
                    var pageNo = '<xsl:value-of select ="/sqroot/body/bodyContent/browse/info/pageNo"/>';
                    var nbPages = '<xsl:value-of select ="/sqroot/body/bodyContent/browse/info/nbPages"/>';
					var filter='<xsl:value-of select ="/sqroot/body/bodyContent/browse/info/filter"/>';
					
                    childPageNo('childPageNo', code, pageNo, nbPages, filter);					
                    $('#searchBox_'+code).css('visibility', 'visible');
                  </script>
                </xsl:if>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/children">
    <xsl:apply-templates select="child" />
  </xsl:template>

  <xsl:template match="child">
    <xsl:if test="info/permission/allowBrowse='1'">
      <script>
        function loadChild_<xsl:value-of select ="$lowerCode"/>(GUID) {
        var code='<xsl:value-of select ="code/."/>';
        var pcode='<xsl:value-of select ="$lowerCode"/>';
        var parentKey='<xsl:value-of select ="parentkey/."/>';
        var browsemode='<xsl:value-of select ="browseMode/."/>';
		if (browsemode=='undefined') browsemode='';
        loadChild(code, parentKey, GUID, null, browsemode, pcode);
        }
      </script>
    </xsl:if>

  </xsl:template>
  
  <xsl:template match="sqroot/body/bodyContent/browse/header">
    <xsl:apply-templates select="column"/>
  </xsl:template>

  <xsl:template match="column">
    <th style="cursor:pointer;" onclick="sortBrowse(this, 'child', '{../../info/code}', '{@fieldName}')" data-order="{@order}">
      <xsl:value-of select="."/>
      <script>
        var x=[];
        <xsl:choose>
          <xsl:when test="((@isEditable=1 and ($parentState=0 or $parentState=300 or not ($parentState))) 
              or (@isEditable='2')
							or (@isEditable=3 and ($parentState&lt;400 or not ($parentState)))
							or (@isEditable=4 and ($parentState&lt;500 or not ($parentState))))">
            x.push('editor=<xsl:value-of select="@editor"/>');
            <xsl:if test="@isNullable=0">
			if (document.getElementsByName(tblnm)[0])
              document.getElementsByName(tblnm)[0].value = document.getElementsByName(tblnm)[0].value + ', <xsl:value-of select="@fieldName"/>'
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            x.push('editor=');
          </xsl:otherwise>
        </xsl:choose>
        x.push('fieldname=<xsl:value-of select="@fieldName"/>');
        x.push('preview=<xsl:value-of select="@preview"/>');
        x.push('defaultValue=<xsl:value-of select="@defaultValue"/>');
        x.push('wf1=<xsl:value-of select="@wf1"/>');
        x.push('wf2=<xsl:value-of select="@wf2"/>');
		x.push('radioOptions=<xsl:value-of select="@radioOptions"/>');
        x.push('align=<xsl:value-of select="@align"/>');
        x.push('digit=<xsl:value-of select="@digit"/>');
        x.push('isNullable=<xsl:value-of select="@isNullable"/>');
        x.push('guid=<xsl:value-of select="@guid"/>');													  

        columns_<xsl:value-of select="$lowerCode"/>.push(x);

      </script>
    </th>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">

    <tr id="tr1_{$lowerCode}{translate(@GUID, 'ABCDEF', 'abcdef')}" data-parent="#{$lowerCode}" data-target="#{$lowerCode}{translate(@GUID, 'ABCDEF', 'abcdef')}"
        data-code="{$lowerCode}" data-guid="{translate(@GUID, 'ABCDEF', 'abcdef')}"
        onmouseover="this.bgColor='lavender';this.style.cursor='pointer';" onmouseout="this.bgColor='white'">

      <xsl:if test="count(/sqroot/body/bodyContent/browse/children/child)>0">
        <td class="cell-parentSelector"></td>
      </xsl:if>
      <td class="cell-recordSelector"></td>
      <xsl:apply-templates select="fields/field"/>
      <xsl:if test="/sqroot/body/bodyContent/browse/info/buttons">
        <td class="browse-action-button text-right" style="white-space: nowrap;">

        </td>
      </xsl:if>
    </tr>
    <tr id="tr2_{$lowerCode}{translate(@GUID, 'ABCDEF', 'abcdef')}" style="display:none">
      <td colspan="100">
      </td>
    </tr>

  </xsl:template>

  <xsl:template match="fields/field">
    <xsl:variable name="tbContent">
      <xsl:choose>
        <xsl:when test="@digit = 0 and .!='' and @editor='textbox'">
          <xsl:value-of select="format-number(., '###,###,###,##0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 1 and .!='' and @editor='textbox'">
          <xsl:value-of select="format-number(., '###,###,###,##0.0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 2 and .!='' and @editor='textbox'">
          <xsl:value-of select="format-number(., '###,###,###,##0.00', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 3 and .!='' and @editor='textbox'">
          <xsl:value-of select="format-number(., '###,###,###,##0.000', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 4 and .!='' and @editor='textbox'">
          <xsl:value-of select="format-number(., '###,###,###,##0.0000', 'dot-dec')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="@editor and ((@isEditable=1 and ($parentState=0 or $parentState=300 or not ($parentState))) 
              or (@isEditable='2' and ../../@GUID = '00000000-0000-0000-0000-000000000000')
							or (@isEditable=3 and $parentState&lt;400)
							or (@isEditable=4 and ($parentState&lt;500)))">
        <td class="cell cell-editor-{@editor}" data-id="{@guid}" data-field="{@caption}" data-preview="{@preview}" data-wf1="{@wf1}" data-wf2="{@wf2}" data-radiooptions="{@radioOptions}">
          <xsl:if test="@digit">
            <xsl:attribute name="data-type">number</xsl:attribute>
            <xsl:attribute name="placeholder">Enter Number Here</xsl:attribute>
          </xsl:if>								
          <xsl:attribute name="align">
            <xsl:choose>
              <xsl:when test="@align=0">left</xsl:when>
              <xsl:when test="@align=1">center</xsl:when>
              <xsl:when test="@align=2">right</xsl:when>
            </xsl:choose>
          </xsl:attribute>
          <xsl:value-of select="$tbContent"/>
        </td>
      </xsl:when>
      <xsl:otherwise>
        <td class="cell cell-disabled" data-id="{@id}" data-field="{@caption}">
          <xsl:attribute name="align">
            <xsl:choose>
              <xsl:when test="@align=0">left</xsl:when>
              <xsl:when test="@align=1">center</xsl:when>
              <xsl:when test="@align=2">right</xsl:when>
            </xsl:choose>
          </xsl:attribute>
          <xsl:value-of select="$tbContent"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>