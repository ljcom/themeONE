<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>

  <xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
  <xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:variable name="lowerCode">
    <xsl:value-of select="translate(/sqroot/body/bodyContent/browse/info/code, $uppercase, $smallcase)"/>
  </xsl:variable>
  <xsl:variable name="parentState" select="/sqroot/body/bodyContent/browse/info/parentState" />
  <xsl:variable name="settingMode" select="/sqroot/header/info/code/settingMode/." />

  <xsl:template match="/">
    <script>
      var code='<xsl:value-of select="$lowerCode"/>';
      cell_init(code);
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

      var msg= (err != '') ? 'Upload Error : ' + err : 'Upload Data Success'
      showMessage(msg);
      //setTimeout(function() {location.reload()}, 5000);

      var code='<xsl:value-of select="/sqroot/body/bodyContent/browse/info/code"/>';
      preview('1', getCode(), getGUID(),'', this);
      loadChild(code);

      });
    </script>
    <div class="row">
      <div class="col-md-12">
        <div class="box-header with-border" style="background:white" data-toggle="collapse" data-target="#content_{$lowerCode}">
          <h3 class="dashboard-title">
            <xsl:value-of select="sqroot/body/bodyContent/browse/info/description"/>
          </h3>
        </div>
        <div>
          <input style="width:200px; position:absolute; right:25px; top:5px; padding-right:25px;visibility:hidden;" type="text" id="searchBox_{$lowerCode}"
                  name="searchBox_{$lowerCode}" class="form-control" placeholder="Enter search key..."
                  value="{sqroot/body/bodyContent/browse/info/search}"
                  onkeypress="searchTextChild(event, this.value, '{$lowerCode}');" />
          <button id="clear{$lowerCode}" type="button" class="btn btn-flat" style="position:absolute; right:25px; top:5px; background:none; border:none; display:none" >
            <span aria-hidden="true">&#215;</span>
          </button>
          <script>
            $('#clear<xsl:value-of select="$lowerCode"/>').click(function(event) {
            searchTextChild(event, '', '<xsl:value-of select="$lowerCode"/>', true);
            });

            $(document).ready(function() {
            if ($('#searchBox_<xsl:value-of select="$lowerCode"/>').val() != '') {
            $('#clear<xsl:value-of select="$lowerCode"/>').show();
            }
            });
          </script>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div style="border:0px none white;box-shadow:none;" id="content_{$lowerCode}" class="box collapse in">
              <div style="border:0px none white;box-shadow:none;">
                <table class="table table-condensed strip-table-browse" style="border-collapse:collapse;">
                  <thead>
                    <tr style="background:#3C8DBC; color:white">
                      <th class="cell-recordSelectors" style="width:28px;"></th>
                      <xsl:apply-templates select="sqroot/body/bodyContent/browse/header"/>
                    </tr>
                  </thead>
                  <tbody id="{$lowerCode}">
                    <xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
                    <tr>
                      <td colspan="20" style="padding:0;">
                        <div class="browse-data accordian-body collapse"
                             id="{$lowerCode}00000000-0000-0000-0000-000000000000" aria-expanded="false">
                          Please Wait...
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <!-- /.box-body -->
              <!--xsl:if test="$parentState &lt; 400"-->
              <div class="box-footer clearfix">
                <xsl:if test="(
                          ((/sqroot/body/bodyContent/browse/info/permission/allowAdd/.)='1' and ($parentState=0 or $parentState=300 or not ($parentState)))
                          or ((/sqroot/body/bodyContent/browse/info/permission/allowAdd/.)='3' and $parentState &lt; 400)
                          or ((/sqroot/body/bodyContent/browse/info/permission/allowAdd/.)='4' and $parentState &lt; 500)
                        )">
                  <button class="btn btn-orange-a accordion-toggle" data-toggle="collapse"
                          data-target="#{$lowerCode}00000000-0000-0000-0000-000000000000"
                          onclick="showChildForm('{$lowerCode}','00000000-0000-0000-0000-000000000000')">ADD</button>&#160;
                </xsl:if>
                <xsl:if test="(
                          ((/sqroot/body/bodyContent/browse/info/permission/allowDelete/.)='1' and ($parentState=0 or $parentState=300 or not ($parentState)))
                          or ((/sqroot/body/bodyContent/browse/info/permission/allowDelete/.)='3' and $parentState &lt; 400)
                          or ((/sqroot/body/bodyContent/browse/info/permission/allowDelete/.)='4' and $parentState &lt; 500)
                        )">
                  <button class="btn btn-gray-a" onclick="cell_delete('{$lowerCode}', this)">DELETE</button>&#160;
                </xsl:if>
                <xsl:if test="(/sqroot/body/bodyContent/browse/info/permission/allowAdd/.)&gt;=1 and (/sqroot/body/bodyContent/browse/info/permission/allowExport/.)=1" >
                  <button class="btn btn-gray-a"
                          onclick="downloadChild('{$lowerCode}', '')">DOWNLOAD</button>&#160;
                  <button class="btn btn-gray-a" onclick="javascript:$('#import_hidden').click();">UPLOAD...</button>&#160;

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
                    childPageNo('childPageNo', code, pageNo, nbPages);
                    $('#searchBox_'+code).css('visibility', 'visible');
                  </script>
                </xsl:if>
              </div>
              <!--/xsl:if-->
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/header">
    <xsl:apply-templates select="column"/>
  </xsl:template>

  <xsl:template match="column">
    <th style="cursor:pointer;" onclick="sortBrowse(this, 'child', '{../../info/code}', '{@fieldName}')" data-order="{@order}">
      <xsl:value-of select="."/>
      <xsl:if test="translate(@order, $uppercase, $smallcase)='asc'">
        <ix class="fas fa-sort-alpha-up" />
      </xsl:if>
      <xsl:if test="translate(@order, $uppercase, $smallcase)='desc'">
        <ix class="fas fa-sort-alpha-down" />
      </xsl:if>
    </th>
  </xsl:template>

  <xsl:template match="sqroot/body/bodyContent/browse/content/row">

    <tr id="tr1_{$lowerCode}{translate(@GUID,'ABCDEF','abcdef')}" data-parent="#{$lowerCode}" data-target="#{$lowerCode}{translate(@GUID,'ABCDEF','abcdef')}" data-code="{$lowerCode}" data-guid="{translate(@GUID,'ABCDEF','abcdef')}"
        class="accordion-toggle cell"
        onmouseover="this.bgColor='lavender';this.style.cursor='pointer';" onmouseout="this.bgColor='white'">
      <td class="cell-recordSelector"></td>
      <xsl:apply-templates select="fields/field"/>
    </tr>
    <tr id="tr2_{$lowerCode}{translate(@GUID,'ABCDEF','abcdef')}">
      <td colspan="7" style="padding:0;">
        <div class="browse-data accordian-body collapse" id="{$lowerCode}{translate(@GUID,'ABCDEF','abcdef')}" aria-expanded="false">
          Please Wait...
        </div>
      </td>
    </tr>


  </xsl:template>

  <xsl:template match="fields/field">
    <xsl:variable name="tbContent">
      <xsl:choose>
        <xsl:when test="@digit = 0 and .!=''">
          <xsl:value-of select="format-number(., '#,##0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 1 and .!=''">
          <xsl:value-of select="format-number(., '#,##0.0', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 2 and .!=''">
          <xsl:value-of select="format-number(., '#,##0.00', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 3 and .!=''">
          <xsl:value-of select="format-number(., '#,##0.000', 'dot-dec')"/>
        </xsl:when>
        <xsl:when test="@digit  = 4 and .!=''">
          <xsl:value-of select="format-number(., '#,##0.0000', 'dot-dec')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="@editor='mediabox'">
        <td>
          <xsl:if test=".!=''">
            <a class="text-muted" onclick="javascript:popTo('OPHcore/api/msg_download.aspx?fieldAttachment={@caption}&#38;code={../../@code}&#38;GUID={../../@GUID}');">
              <ix class="fa fa-paperclip" title="Download" />
            </a>
          </xsl:if>&#160;
        </td>
      </xsl:when>
      <xsl:otherwise>
        <td onclick="showChildForm('{$lowerCode}','{translate(../../@GUID, 'ABCDEF', 'abcdef')}', '{$lowerCode}');">
          <xsl:value-of select="$tbContent"/>&#160;
        </td>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>
