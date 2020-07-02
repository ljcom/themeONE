<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
	<xsl:output method="xml" indent="yes"/>
	<xsl:template match="/">
		<script>
			var title='<xsl:value-of select="/sqroot/header/info/suba"/>';
			var meta = document.createElement('meta');
			meta.property = "og:title";
			//35
			meta.content = "<xsl:value-of select="/sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@primaryCol='7']//value/."/>";
			loadMeta(meta);
			
			var meta = document.createElement('meta');
			meta.name = "description";
			//155
			meta.content = "<xsl:value-of select="/sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@primaryCol='6']//value/."/>";
			loadMeta(meta);
			
			var meta = document.createElement('meta');
			meta.property = "og:url";
			meta.content = "https://pap.mx4.link/code=link&amp;id=<xsl:value-of select="/sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@primaryCol='5']//value/."/>";
			loadMeta(meta);
			
			var meta = document.createElement('meta');
			meta.property = "og:description";
			//max 65
			meta.content = "<xsl:value-of select="/sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@primaryCol='9']//value/."/>";
			
			loadMeta(meta);
			var meta = document.createElement('meta');
			meta.property = "og:image";
			meta.content = "ophcontent/documents/{<xsl:value-of select="/sqroot/header/info/suba"/>/<xsl:value-of select="/sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@primaryCol='8']//value/."/>";
			
			loadMeta(meta);
			var meta = document.createElement('meta');
			meta.property = "og:type";
			meta.content = "book";
			
			loadMeta(meta);
			var meta = document.createElement('meta');
			meta.property = "og:locale";
			meta.content = "id_ID";
			loadMeta(meta);
			
			document.title='<xsl:value-of select="/sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@primaryCol='6']//value/."/>';
			
		</script>
		<center>
			<div style="padding: 10px  10px  10px  10px;">
				<img src="ophcontent/documents/{/sqroot/header/info/suba}/{/sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@primaryCol='8']//value/.}" 
					style="height:300px" alt="" />
			</div>
			<div style="padding:10px 10px 10px 10px;">
				<h1><strong><xsl:value-of select="/sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@primaryCol='5']//value/." /></strong></h1>
				<h2><xsl:value-of select="/sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@primaryCol='6']//value/." /></h2>
				<h3><xsl:value-of select="/sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@primaryCol='7']//value/." /></h3>
				<h3><xsl:value-of select="/sqroot/body/bodyContent/form/formPages/formPage/formSections/formSection/formCols/formCol/formRows/formRow/fields/field[@primaryCol='9']//value/." /></h3>
				<p>Read this book using app that you can download here.</p>
				<img src="ophcontent/themes/themeone/images/appstore.jpg" style="height:50px" alt="Download on App Store"/>
				<img src="ophcontent/themes/themeone/images/playstore.jpg" style="height:50px" alt="Download on Play Store"/>
			</div>
		</center>
	</xsl:template>
	<xsl:template match="sqroot/body/bodyContent/form">
		
	</xsl:template>
</xsl:stylesheet>
