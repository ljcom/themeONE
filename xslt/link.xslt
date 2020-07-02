<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
	<xsl:output method="xml" indent="yes"/>
	<xsl:template match="/">
		<script>
			var meta = document.createElement('meta');
			meta.charset = "UTF-8";
			loadMeta(meta);
			var meta = document.createElement('meta');
			meta.httpEquiv = "X-UA-Compatible";
			meta.content = "IE=edge";
			loadMeta(meta);
			<!-- Tell the browser to be responsive to screen width -->
			var meta = document.createElement('meta');
			meta.name = "viewport";
			meta.content = "width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no";
			loadMeta(meta);
			
			loadContent(1, false);
			<!--title>max 65</title>
	<meta name="description" content="description of your website/webpage, make sure you use keywords!(155)">
	<meta property="og:title" content="short title of your website/webpage(35)" />
	<meta property="og:url" content="https://www.example.com/webpage/" />
	<meta property="og:description" content="description of your website/webpage(65)">
	<meta property="og:image" content="//cdn.example.com/uploads/images/webpage_300x200.png">
	<meta property="og:type" content="article" />
	<meta property="og:locale" content="en_GB" /-->
		</script>
		<div id="contentWrapper" class="content-wrapper">
			<div style="padding-top: 10px; padding-right: 10px; padding-bottom: 10px; padding-left: 10px">
				<div class="overlay">
					<ix class="fas fa-spinner fa-pulse"/>
					
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>