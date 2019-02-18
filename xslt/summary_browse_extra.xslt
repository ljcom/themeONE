<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>
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
    <!--<style>
           
            table {
            position: relative;
            width: 2000px;
            overflow: hidden;
            }
            thead {
            position: relative;
            display: block;
            width: 1200px;
            overflow: visible;
            }
            thead th {
            height: 40px;
            }
            thead td:nth-child(1) {
            position: relative;
            display: block;
            height: 40px;
            padding-top: 20px;
            }
            tbody {
            position: relative;
            display: block;
            width: 1200px;
            height: 90px;
            overflow: scroll;
            
            }
            tbody td {
            background:white;
            }
            tbody tr td:nth-child(1){
            position: relative;
            display: block;
            }
          </style>
          <script>
            $(document).ready(function() {
            $('tbody').scroll(function(e) {
            $('thead').css("left", -$("tbody").scrollLeft());
            $('thead td:nth-child(1)').css("left", $("tbody").scrollLeft()-5);
            $('tbody td:nth-child(1)').css("left", $("tbody").scrollLeft()-5);
            });
            });
          </script>-->
    <div  class="box box-default collapsed-box">
      <div class="box-header with-border">
        <button id="btnAdvancedFilter" type="button" class="btn btn-box-tool" data-widget="collapse">
          <ix aria-hidden="true" class="fa fa-plus"> &#xA0;</ix>

          <span style="font-size:14px;">Summary</span>
        </button>
      </div>
      <div class="box-body table-responsive" style="padding:20px">
        <div style="overflow-x:auto; border:2px #f4f4f4 solid;  padding:10px; width:100%">
          <table class="table table-bordered" id="table1" style="width:2000px; ">
            <thead style="background:#C7E3FC">
              <tr >
                <!--<th class="cell-recordSelectors" style="width:15px;"></th>-->
                <xsl:apply-templates select="sqroot/body/bodyContent/browse/header"/>
                <!--<th></th>-->
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
      </div>
    </div>
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/browse/header">
    <xsl:apply-templates select="column"/>
  </xsl:template>

  <xsl:template match="column">
    <td style="cursor:pointer; width:{@width}px; overflow-x: auto;white-space: nowrap;" onclick="sortBrowse(this, 'child', '{../../info/code}', '{@fieldName}')" data-order="{@order}" >
      <xsl:value-of select="."/>
      <xsl:if test="translate(@order, $uppercase, $smallcase)='asc'">
        <ix class="fas fa-sort-alpha-up" />
      </xsl:if>
      <xsl:if test="translate(@order, $uppercase, $smallcase)='desc'">
        <ix class="fas fa-sort-alpha-down" />
      </xsl:if>
    </td>
  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/browse/content/row">

    <tr  id="tr1_{$lowerCode}{@GUID}" 
        class="accordion-toggle cell"
        onmouseover="this.bgColor='lavender';this.style.cursor='pointer';" onmouseout="this.bgColor='white'">
      <!--<td class="cell-recordSelector"></td>-->
      <xsl:apply-templates select="fields/field"/>
      <!--<td></td>-->
    </tr>
    <tr id="tr2_{$lowerCode}{@GUID}">
      <td colspan="7" style="padding:0;">
        <div class="browse-data accordian-body collapse" id="{$lowerCode}{@GUID}" aria-expanded="false">
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
        <td>
          <xsl:value-of select="$tbContent"/>&#160;
        </td>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
</xsl:stylesheet>