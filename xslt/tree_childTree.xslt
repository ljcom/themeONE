<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
	<xsl:output method="xml" indent="yes"/>
	<xsl:variable name="smallcase" select="abcdefghijklmnopqrstuvwxyz"/>
	<xsl:variable name="uppercase" select="ABCDEFGHIJKLMNOPQRSTUVWXYZ"/>
	<xsl:variable name="lowerCode">
		<xsl:value-of select="translate(/sqroot/body/bodyContent/browse/info/code, $uppercase, $smallcase)"/>
	</xsl:variable>
	<xsl:variable name="normalChar" select="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"/>
	<xsl:decimal-format name="comma-dec" decimal-separator="," grouping-separator="."/>
	<xsl:decimal-format name="dot-dec" decimal-separator="." grouping-separator=","/>
	<xsl:variable name="state" select="/sqroot/body/bodyContent/browse/info/curState/@substateCode"/>
	<xsl:variable name="allowAccess" select="/sqroot/body/bodyContent/browse/info/permission/allowAccess"/>
	<xsl:variable name="allowAdd" select="/sqroot/body/bodyContent/browse/info/permission/allowAdd"/>
	<xsl:variable name="allowEdit" select="/sqroot/body/bodyContent/browse/info/permission/allowEdit"/>
	<xsl:variable name="allowForce" select="/sqroot/body/bodyContent/browse/info/permission/allowForce"/>
	<xsl:variable name="allowDelete" select="/sqroot/body/bodyContent/browse/info/permission/allowDelete"/>
	<xsl:variable name="allowWipe" select="/sqroot/body/bodyContent/browse/info/permission/allowWipe"/>
	<xsl:variable name="allowOnOff" select="/sqroot/body/bodyContent/browse/info/permission/allowOnOff"/>
	<xsl:variable name="allowAll" select="/sqroot/body/bodyContent/browse/info/permission/allowAll"/>
	<xsl:variable name="settingMode" select="/sqroot/header/info/code/settingMode"/>
	<xsl:variable name="suba">
		<xsl:choose>
			<xsl:when test="/sqroot/header/info/suba">
				<xsl:value-of select="/sqroot/header/info/suba"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/sqroot/header/info/account"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:template name="string-replace-all">
		<xsl:param name="text"/>
		<xsl:param name="replace"/>
		<xsl:param name="by"/>
		<xsl:choose>
			<xsl:when test="contains($text, $replace)">
				<xsl:value-of select="substring-before($text,$replace)"/>
				<xsl:value-of select="$by"/>
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="substring-after($text,$replace)"/>
					<xsl:with-param name="replace" select="$replace"/>
					<xsl:with-param name="by" select="$by"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--Table colspan-->
	<xsl:variable name="cMandatory">
		<xsl:value-of select="count(sqroot/body/bodyContent/browse/header/column[@mandatory=1])"/>
	</xsl:variable>
	<xsl:variable name="cProfile">
		<xsl:value-of select="count(sqroot/body/bodyContent/browse/header/column[@editor='profilebox'])"/>
	</xsl:variable>
	<xsl:variable name="cSummary">
		<xsl:choose>
			<xsl:when test="count(sqroot/body/bodyContent/browse/header/column[@mandatory=1])=0 or sqroot/body/bodyContent/browse/info/permission/allowShowSummaryColumn = 0">0</xsl:when>
			<xsl:otherwise>1</xsl:otherwise>
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
	<xsl:variable name="tcolspan" select="$cMandatory + $cProfile + $cSummary + $cDelegated + $cDelegator + $tMode + 1"/>
	<xsl:template match="/">
		<script>
			var children<xsl:value-of select="$lowerCode"/>=[];
		</script>
		<xsl:apply-templates select="sqroot/body/bodyContent/browse/children/child"/>
		<section class="content" style="min-height:20px">
			<!--Access Authority and Permission-->
			<xsl:choose>
				<xsl:when test="$allowAccess = 1">
					<!-- browse for pc/laptop list -->
					<div class="row visible-phone listContent">
						<div class="col-md-12">
							<div id="treeBox" class="box box-primary">
								<div class="box-body box-tree">
									<table id="tblBrowse" class="table table-condensed table-stripped dataTable">
										<thead id="browseHead">
											<tr>
												<xsl:if test="sqroot/body/bodyContent/browse/info/isDelegator = 0">
													<th style="width:10px;background-color:white" name="th_checkbox">
														<input type="checkbox" id="pinnedAll" class="pinned header fal fa-square fa-lg" onclick="checkedBox(this)"/>
													</th>
												</xsl:if>
												<xsl:if test="sqroot/body/bodyContent/browse/header/column[@editor='profilebox']">
													<th title="Image" style="background-color:white">Image</th>
												</xsl:if>
												<xsl:if test="sqroot/body/bodyContent/browse/header/column[@mandatory=1]">
													<xsl:apply-templates select="sqroot/body/bodyContent/browse/header/column[@mandatory=1]"/>
												</xsl:if>
											</tr>
										</thead>
										<tbody id="browseContent">
											<xsl:choose>
												<xsl:when test="sqroot/body/bodyContent/browse/content/row">
													<xsl:apply-templates select="sqroot/body/bodyContent/browse/content/row"/>
												</xsl:when>
											</xsl:choose>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<!-- browse for pc/laptop list -->
					<!-- browse for phone/tablet max width 768 -->
					<div class="row displayblock-phone listContent">
						<div class="col-md-12 col-sm-12 col-xs-12 full-width-a" id="accordionBrowse">
							<!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->
							<xsl:if test="sqroot/body/bodyContent/browse/info/permission/allowAccess/.=0">
								<div class="alert alert-warning" align="center">
									You don't have any access to see this list. Please ask the administrator for more information.
								</div>
							</xsl:if>
							<!-- /.box -->
							&#160;
						</div>
						<!-- /.col -->
					</div>
					<!-- browse for phone/tablet max width 768 -->
					<!--browse grid-->
					<!--div class="controls button-group gridContent">
			<button class="btn" data-filter="*">all</button>
			<button class="btn" data-filter=".cat1">cat1</button>
			<button class="btn" data-filter=".cat2">cat2</button>
			<button class="btn" data-filter=".cat3">cat3</button>
		  </div>
		  <div class="grid gridContent">&#160;
		  </div-->
					<!--browse grid-->
					<xsl:if test="sqroot/body/bodyContent/browse/info/nbPages > 1">
						<div class="row visible-phone">
							<div class="col-md-12 col-sm-12 col-xs-12">
								<ul class="pagination pagination-sm no-margin pull-right" id="pagenumbers"/>
							</div>
						</div>
					</xsl:if>
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
	<xsl:template match="sqroot/body/bodyContent/browse/children/child">
		<script>
			var code='<xsl:value-of select="code/."/>';
			var title='<xsl:value-of select="childTitle/."/>';
			var parentKey='<xsl:value-of select="parentkey/."/>';
			children<xsl:value-of select="$lowerCode"/>.push({code:code, title:title, parentKey:parentKey});
		</script>
	</xsl:template>
	<xsl:template match="sqroot/body/bodyContent/browse/content/row">
		<script>
			var code='<xsl:value-of select="code/."/>';
			var GUID='<xsl:value-of select="@GUID"/>';
			$('#brodeta-'+GUID).on('shown.bs.collapse', function() {
				var GUID='<xsl:value-of select="@GUID"/>';
				//if (!$('#brodeta-'+GUID.toLowerCase()).hasClass('in')) {
					var parentCode='<xsl:value-of select="@code/."/>';
					divname='sideForm';
					xmldoc='ophCore/api/default.aspx?mode=form&amp;code='+parentCode+'&amp;guid='+GUID;
					xsldoc='ophCore/api/loadTheme.aspx?code='+parentCode+'&amp;theme=' + loadThemeFolder() + '&amp;page='+getPage() + '_form';
					showXML(divname, xmldoc, xsldoc, true, true);
					if (children<xsl:value-of select="$lowerCode"/>.length &gt; 0) {
						for (i = 0; i &lt; children<xsl:value-of select="$lowerCode"/>.length; i++) {
							loadChild(children<xsl:value-of select="$lowerCode"/>[i].code, children<xsl:value-of select="$lowerCode"/>[i].parentKey, GUID, 1, '');
						}
					}
				//}
			}).on('show.bs.collapse', function() {
				//alert('collapse');
			});
			for (i = 0; i &lt; children<xsl:value-of select="$lowerCode"/>.length; i++) {
				var childEl=
					'&amp;'+'lt;div class="row" style="max-width:1000px;margin: 10px 10px 10px 10px;"&gt;'+
						'&amp;'+'lt;div class="md-col-12"&gt;'+
							'&amp;'+'lt;h3 class="box-title"&gt;'+
								''+children<xsl:value-of select="$lowerCode"/>[i].title+''+
							'&amp;'+'lt;/h3&gt;'+
						'&amp;'+'lt;/div&gt;'+
						'&amp;'+'lt;div class="md-col-12" id="child'+code+GUID.toLowerCase()+'"&gt;'+
							'&amp;'+'lt;ix class="fa fa-refresh fa-spin"/&gt; loading child...'+
						'&amp;'+'lt;/div&gt;'+
					'&amp;'+'lt;/div&gt;'+
					'';
				$('#children'+code+GUID).html(childEl);
			}
		</script>
		<tr data-guid="{@GUID}">
			<xsl:if test="/sqroot/body/bodyContent/browse/info/isDelegator = 0">
				<td>
					<input type="checkbox" data-code="{@code}" data-guid="{@GUID}" class="pinned fal fa-square" onclick="checkedBox(this)"/>
				</td>
			</xsl:if>
			<!--ganti icon-->
			<xsl:if test="fields/field[@editor='profilebox']">
				<td>
					<xsl:apply-templates select="fields/field[@editor='profilebox']"/>
				</td>
			</xsl:if>
			<xsl:apply-templates select="fields/field[@mandatory=1]"/>
			<!--script>
				//put before mandatory section
				fillMobileItem('<xsl:value-of select="@code"/>', '<xsl:value-of select="@GUID"/>',
				'<xsl:value-of select="$state"/>',
				'<xsl:value-of select="@edit"/>',
				'<xsl:value-of select="@delete"/>',
				'<xsl:value-of select="@wipe"/>',
				'<xsl:value-of select="@force"/>',
				'<xsl:value-of select="/sqroot/body/bodyContent/browse/info/isDelegator"/>', '<xsl:value-of select="$settingMode"/>');
			</script-->
			<xsl:variable name="pageNo" select="/sqroot/body/bodyContent/browse/info/pageNo"/>
		</tr>
		<tr class="tr-detail">
			<td colspan="{$tcolspan}" style="padding:0;">
				<div class="browse-data accordian-body collapse" id="brodeta-{@GUID}" style="cursor:default;">
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12 full-width-a" id="children{code/.}{@GUID}">
							<!--children-->
						</div>
					</div>
				</div>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="fields/field[@editor='profilebox']">
		<img src="OPHContent/documents/{$suba}/{.}" style="height:50px" alt=""/>
	</xsl:template>
	<xsl:template match="fields/field[@mandatory=1]">
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
		<xsl:if test="@editor!= 'profilebox'">
			<td id="mandatory{../../@GUID}" class="expand-td browse-mandatory" data-toggle="collapse" data-target="#brodeta-{../../@GUID}" data-parent="#brodeta-{../../@GUID}" style="cursor:pointer;{@style}" data-field="{@caption}" data-title="{@title}">
				<xsl:choose>
					<xsl:when test="@editor='anchor'">
						<a href="{$tbContent}">
							<xsl:value-of select="$tbContent"/>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$tbContent"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</xsl:if>
		<xsl:if test="@editor= 'profilebox'">
			<img src="OPHContent/documents/{$suba}/{.}" style="height:50px" onerror="this.src = 'ophcontent/themes/themeone/images/no-data.png';" alt=""/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>