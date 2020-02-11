<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
	
	<div class="col-md-12">
		<h2>Results</h2>
	</div>
	<div class="col-md-12">
		<table id="tblBrowse" class="table table-condensed table-stripped dataTable">
			<thead id="browseHead">
				<td style="background-color:white">Comment</td>
				<td style="background-color:white">Report Date</td>
			</thead>
			<tbody>
				<xsl:choose>
					<xsl:when test="sqroot/body/bodyContent/query/results/result">
						<xsl:apply-templates select="sqroot/body/bodyContent/query/results/result" />
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<td align="center" colspan="2">
							  <div id="noData" class="alert alert-warning">
								There is no data available.
							  </div>
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
			</tbody>
		</table>
	</div>

  </xsl:template>


  <xsl:template match="sqroot/body/bodyContent/query/results/result">
	<tr class="odd2-tr">
		<td>
			<xsl:value-of select="Comment" />
		</td>
		<td>
			<xsl:value-of select="CreatedDate" />
		</td>
	</tr>
  </xsl:template>
  <xsl:template match="sqroot/body/bodyContent/query/queryPages/queryPage/querySections/querySection">
    <div class="row" id="reportParameter">
      <div class="col-md-12">
        <xsl:if test="@rowTitle">
          <h2>
            <xsl:value-of select="@rowTitle"/>
          </h2>
        </xsl:if>
        <xsl:apply-templates select="queryCols/queryCol"/>
        &#160;
      </div>
    </div>
  </xsl:template>
  
</xsl:stylesheet>
  