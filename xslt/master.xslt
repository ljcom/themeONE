<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:variable name="colMenu">
    <xsl:choose>
      <xsl:when test="count(/sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)=0">12</xsl:when>
      <xsl:when test="count(/sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)=1">12</xsl:when>
      <xsl:when test="count(/sqroot/header/menus/menu[@code='primaryback']/submenus/submenu)=2">6</xsl:when>
      <xsl:otherwise>4</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
 
  <xsl:template match="/">
    <div style="display:none" id="pageName">&#xA0;</div>
    <div style="display:none" id="themeName">&#xA0;</div>

    <script>
      
      
      Sideshow.config.language = "oph";
      if(getMode() == 'export') {
        Sideshow.config.autoSkipIntro = true;
      }
      else {
        Sideshow.config.autoSkipIntro = false;
      }
      Sideshow.init();
      
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

      changeSkinColor();
      $("body").addClass("hold-transition");
      $("body").addClass("sidebar-mini");
      $("body").addClass("fixed");

      loadScript('OPHContent/cdn/admin-LTE/js/app.min.js');
      
      document.getElementById("pageName").innerHTML = getCookie('page');
      document.getElementById("themeName").innerHTML = getCookie('themeFolder');

      document.title='<xsl:value-of select="/sqroot/header/info/title"/>';

      resetBrowseCookies();
      setCookie(getCode().toLowerCase()+'_showdocinfo', '<xsl:value-of select="/sqroot/header/info/code/ShowDocInfo" />',7);
      loadContent(1);

      setCookie('userURL', 'OPHContent/documents/<xsl:value-of select="sqroot/header/info/account" />/<xsl:value-of select="sqroot/header/info/user/userURL"/>', 7);
      setCookie('userName', '<xsl:value-of select="sqroot/header/info/user/userName"/>', 7);
      //setCookie('userId', '<xsl:value-of select="sqroot/header/info/user/userId"/>', 7);
      changeSkinColor;
      
      <!--EXPORT BUTTON-->
      Sideshow.registerWizard({
        name: "ss_exportData",
        title: "How to Use Export Data Button?",
        description: "We would like to help you how to use this export data button.",
        estimatedTime: "5 Minutes",
        affects: [
  		    function(){
            if ($('#btnExport').length == 1 &amp;&amp; getMode() == 'browse')
			        return true;
		      }
        ]
      }).storyLine({
        showStepPosition: true,
        steps: [
          {
	          title: "Let's Go to Export Data Page First!",
	          text: "Please click EXPORT DATA button to continue",
            subject: "#btnExport",
            autoContinue: true,
            completingConditions: [
		    	    function(){
		    		    return $('#uploadBox').data('clicked') > 0
		    	    }
		        ],
            listeners:{
              beforeStep: function() { 
                $('#btnExport').attr('onclick', "window.location='?code="+getCode()+"&amp;mode=export&amp;help=1'")
              }
            }
          }
	      ]
      });
      
      <!--EXPORT PAGE-->
      Sideshow.registerWizard({
        name: "ss_exportPage",
        title: "Help Me to Use Export Page",
        description: "We would like to help you how to use this export page.",
        estimatedTime: "10 Minutes",
        affects: [
  		    function(){
            if (getMode() == 'export')
			        return true;
		      }
        ]
      }).storyLine({
        showStepPosition: true,
        steps: [
    	    {
		        title: "Welcome to Export Data \"<xsl:value-of select="/sqroot/header/info/title"/>\"",
		        text: "Hello \"<xsl:value-of select="sqroot/header/info/user/userName"/>\", are you ready to go? Please click next then."
          },
    	    {
		        title: "Download Template",
		        text: "First of all, before you can use an export mode you have to download a formatted template (Always in Excel) by clicking that button.",
          },
          {
	          title: "Downloading a Template",
	          text: "Now, let's try downloading your template. Click that Download Template button.",
	          subject: "#btn_imp",
            targets: "#btn_imp",
            listeners: {
		    	    beforeStep: function(){        
                if($('#exportNavTab').length == 1)
                  $('#exportNavTab').children('ul').children('li').eq(0).children('a').click();
		    	    }
		        }	
          },
    	    {
		        title: "Input Data into File",
		        text: "After the downloaded template is complete, you need to input data into that file and than save it. Before it file is ready to export.",
            listeners: {
		    	    afterStep: function(){
                if($('#exportNavTab').length == 0) Sideshow.gotoStep("expTemplate")
		    	    }
		        }	            
          },
          {
	          title: "Export Template",
	          text: "In this tab you can export your downloaded template file.",
	          subject: "#exportNavTab",
            lockSubject:true,
            listeners: {
		    	    beforeStep: function(){
                if($('#exportNavTab').length == 1)
                  $('#exportNavTab').children('ul').children('li').eq(1).children('a').click();
		    	    }
		        }	
          },
          {
	          title: "Export Parameters",
	          text: "Before you can export <xsl:value-of select="/sqroot/header/info/title"/> template, you have to set this parameters. Each of parameter is always affected the result of your exported data. So, you better ask your administrator about the use of this parameters.",
	          subject: "#formExport",
            targets: "#formExport input, #formExport select",
            lockSubject:true
          },
          {
            name: "expTemplate",
	          title: "Export Template",
	          text: "Now to exporting your data, you need to click this button then select the downloaded template file that located in your computer.",
	          subject: "#btn_exp",
            lockSubject:true,
            listeners: {
		    	    beforeStep: function(){
                if($('#exportNavTab').length == 1)
                  $('#exportNavTab').children('ul').children('li').eq(1).children('a').click();
		    	    }
		        }	
          },
          {
	          title: "Export Status",
	          text: "You can see your export status here.",
	          subject: "#exportStatus",
            lockSubject:true,
            skipIf: function() {
		    	      return $("#exportStatus").length == 0;
			      },
          },
    	    {
		        title: "Remember!",
		        text: "Each time you want to use export mode, you have to always download a new template.",
	          subject: "#btn_imp",
            targets: "#btn_imp",
            lockSubject:true,
            listeners: {
		    	    beforeStep: function() {        
                if($('#exportNavTab').length == 1)
                  $('#exportNavTab').children('ul').children('li').eq(0).children('a').click();
		    	    }
		        }
          },
          {
	          title: "Finish",
	          text: "That's all <xsl:value-of select="sqroot/header/info/user/userName"/>, it's the end of my help guide. Thank you for let me help you. See you again :) ",
          }
	      ]
      });
      $( document ).ready(function() {
        if(getQueryVariable('help')==1) Sideshow.start();
      });
      
      <!--BROWSE PAGE-->
      Sideshow.registerWizard({
        name: "ss_browse",
        title: "Help Me to Use \"<xsl:value-of select="/sqroot/header/info/title"/>\" Page",
        description: "We would like to help you how to use \"<xsl:value-of select="/sqroot/header/info/title"/>\" page.",
        estimatedTime: "15 Minutes",
        affects: [
  		    function(){
            if (getMode() == 'browse')
			        return true;
		      }
        ]
      }).storyLine({
        showStepPosition: true,
        steps: [
    	    {
		        title: "Welcome to \"<xsl:value-of select="/sqroot/header/info/title"/>\"",
		        text: "Hello \"<xsl:value-of select="sqroot/header/info/user/userName"/>\", welcome to \"<xsl:value-of select="/sqroot/header/info/title"/>\". Please click next then."
          },
          {
	          title: "Table Browse",
	          text: "Here is your table browse. In this table browse you can see your data. Try scroll the page up adn down if you dont see the highlight.",
	          subject: "#tblBrowse",
            lockSubject:true,
            skipIf: function() {
                return $("#noData").length == 0;
			      },
            listeners:{
              afterStep: function() { 
                if($("#noData").length == 1) Sideshow.gotoStep("statusFilter");
              }
            }
          },
          {
            name: "tblBrowse",
	          title: "Table Browse",
	          text: "Here is your table browse. In this table browse you can see your data. Try scroll the page up adn down if you dont see the highlight.",
	          subject: "#tblBrowse",
            lockSubject:true
          },
          {
	          title: "Sorting The Data",
	          text: "To sort your data, you can click it's field title except for Summary and Action fields. Try scroll the page up and down if you dont see the highlight.",
	          subject: "#browseHead",
            targets: "td[onclick*='sort']",
            skipIf: function() {
		    	      return $("td[onclick*='sort']").length == 0;
			      }
          },
          {
	          title: "Summary",
	          text: "If you click the summary, you can view the detail will be expanded. Try Click under the red marked arrow to see the differents.",
	          subject: "#browseContent",
            targets: "td[id^='summary']", 
            autoContinue: true,
            completingConditions: [
		    	    function(){
		    		    return $("div[id^='brodeta']").is(':visible');
		    	    }
		        ],
            skipIf: function() {
		    	      return $("td[id^='summary']").length == 0;
			      },
          },
          {
	          title: "Summary Content",
	          text: "In this summary content box you can see the detail of summary content it self.",
	          subject: "div[id^='brodeta']:visible",
            lockSubjects:true,
            skipIf: function() {
		    	      return $("div[id^='brodeta']:visible").length == 0;
			      }
          },
          {
	          title: "Action Button Inactive",
	          text: "This button function is to make one of your data becomes incative",
	          subject: "td[class^='browse-action-button']:eq(0)",
            lockSubject:true,
            targets: "a[href*='inactivate']:eq(0)",
            skipIf: function() {
		    	      return $("a[href*='inactivate']:eq(0)").length == 0;
			      }
          },
          {
	          title: "Action Button Edit",
	          text: "This button function is to modify one of your data or you can just view what is the more detail that this data has.",
	          subject: "td[class^='browse-action-button']:eq(0)",
            lockSubject:true,
            targets: "a[id^='edit']:eq(0)",
            skipIf: function() {
		    	      return $("a[id^='edit']:eq(0)").length == 0;
			      }
          },
          {
	          title: "Page Numbers",
	          text: "This is the page number. You can switch between the page by clikcing the number you want.",
	          subject: "#pagenumbers",
            lockSubject:true,
            skipIf: function() {
		    	      return $("#pagenumbers").children().length == 0;
			      }
          },
          {
            name: "statusFilter",
	          title: "Filter Status",
	          text: "This is the filter status for this browse. Try click the menu to see its content",
	          subject: "#statusFilter",
	          targets: "#statusFilter",
            autoContinue: true,
            completingConditions: [
		    	    function(){
		    		    return $("#statusFilter").attr("aria-expanded");
		    	    }
		        ]              
          },
          {
	          title: "Filter Status",
	          text: "This is the content for filter status that available for this browse. Each action do different filter that affect the data.",
	          subject: "#statusContent",
	          targets: "#statusContent",
            lockSubject: true,
            listeners:{
              afterStep: function() { 
                $("#statusFilter").parent().removeClass('open');
              }
            }
          },
          {
	          title: "Advanced Filters",
	          subject: "#bfBox",
	          text: "This is the Advanced Filter box, contain many specified data filter. Click the red marked arrow to open the box.",
	          targets: "#statusContent",
            autoContinue: true, completingConditions: [
		    	    function(){
		    		    return $("#bfBox div.box-body").is(":visible")
		    	    }
		        ], 
            listeners:{
              beforeStep: function() { 
                if($('#bfBox').length == 0) Sideshow.gotoStep('newdoc')
              }
            }
          },
          {
	          title: "Form Filters",
	          subject: "#bfBox",
	          text: "This is the available filter. Each of them do the specific filter.",
	          targets: "#formFilter span.select2"
          },
          {
	          title: "Apply Filters",
	          subject: "#btnFilter",
	          text: "After you done with selecting the filters, now its time to applying them. With this button you can apply the filters.",
	          targets: "#btnFilter",
            lockSubject: true
          },
          {
	          title: "Reset Filters",
	          subject: "#btnResetFilter",
	          text: "This button function is to reset the filters. Each time you want to reset the active filters, just click this button instead.",
	          targets: "#btnResetFilter",
            lockSubject: true,
            listeners:{
              afterStep: function() { 
                $("#btnAdvancedFilter").click();
              }
            }
          },
          {
            name: "newdoc",
	          title: "New Document",
	          subject: "#newdoc",
	          text: "This button function is for creating a new document. Each time you want to create a new document, just click this button.",
            lockSubject: true
          },
          {
	          title: "Finish",
	          text: "That's all <xsl:value-of select="sqroot/header/info/user/userName"/>, it's the end of my help guide. Thank you for let me help you. See you again :) ",
          }
	      ]
      });
      
      <!--FORM PAGE-->
      Sideshow.registerWizard({
        name: "ss_newDoc",
        title: "How to Save a New <xsl:value-of select="/sqroot/header/info/title"/> Document?",
        description: "We would like to help you to create or save this document.",
        estimatedTime: "5 Minutes",
        affects: [
  		    function(){
            if (getMode() == 'form' &amp;&amp; getQueryVariable('GUID') == '00000000-0000-0000-0000-000000000000')
			        return true;
		      }
        ]
      }).storyLine({
        showStepPosition: true,
        steps: [
    	    {
		        title: "Welcome to \"<xsl:value-of select="/sqroot/header/info/title"/>\" Form",
		        text: "Hello \"<xsl:value-of select="sqroot/header/info/user/userName"/>\", welcome to \"<xsl:value-of select="/sqroot/header/info/title"/>\" form. If you ready for this tutorial, Please click next then."
          },
    	    {
		        title: "Section",
		        text: "This is called Section that contain form.",
	          subject: "#section_1",
            skipIf: function() {
              return $("#section_1").length == 0;
            }
          },
    	    {
		        title: "Editable Field",
		        text: "This is where you can fill any information that needed. This is optional.",
	          subject: ".form-group.enabled-input:eq(0)",
            targets: ".form-group.enabled-input:eq(0) input:text:enabled:eq(0)",
            skipIf: function() {
              return $(".form-group.enabled-input:eq(0)").length == 0;
            },
            listeners:{
              beforeStep: function() {
                $("span[id^='rfm']:eq(0)").hide();
              },
              afterStep: function() { 
                $("span[id^='rfm']:eq(0)").show();
              }
            }
          },
    	    {
		        title: "Required Field",
		        text: 'This is where YOU HAVE to fill in. This field is required to be filled. Marked by red text("required field")',
	          subject: ".form-group.enabled-input:has([id^='rfm']):eq(0)",
            targets: ".form-group.enabled-input:has([id^='rfm']):eq(0) input:text:enabled:eq(0), [id^='rfm']:eq(0)",
            skipIf: function() {
              return $("span[id^='rfm']:eq(0)").length == 0 ;
            }
          },
    	    {
		        title: "Not Editable Field",
		        text: "This is the field which you can not edit. The box is bordered boldly",
	          subject: ".form-group.disabled-input:eq(0)",
            targets: ".form-group.disabled-input:eq(0) input:text:disabled:eq(0)",
            skipIf: function() {
              return $(".form-group.disabled-input:eq(0)").length == 0 ;
            }
          },
    	    {
		        title: "Save or Cancel",
		        text: "This is the button that functioned for saving your document or just cancel it.",
	          subject: "div:has(#button_save):last",
            targets: "#button_save, #button_cancel",
            lockSubject: true
          },
          {
	          title: "Finish",
	          text: "That's all <xsl:value-of select="sqroot/header/info/user/userName"/>, it's the end of my help guide. Thank you for let me help you. See you again :) ",
          }
	      ]
      });
      
      Sideshow.registerWizard({
        name: "ss_formInfo",
        title: "Tell me about <xsl:value-of select="/sqroot/header/info/title"/> form",
        description: "We would like to tell you how to read information about this form.",
        estimatedTime: "5 Minutes",
        affects: [
  		    function(){
            if (getMode() == 'form' &amp;&amp; isGuid(getQueryVariable('GUID')))
			        return true;
		      }
        ]
      }).storyLine({
        showStepPosition: true,
        steps: [
    	    {
		        title: "Welcome to \"<xsl:value-of select="/sqroot/header/info/title"/>\" Form",
		        text: "Hello \"<xsl:value-of select="sqroot/header/info/user/userName"/>\", welcome to \"<xsl:value-of select="/sqroot/header/info/title"/>\" form. If you ready for this tutorial, Please click next then."
          },
    	    {
		        title: "Document Panel",
		        text: "In this panel you can see your document No and document Ref No",
            subject: ".user-panel",
            targets: ".user-panel",
            lockSubject: true,
            skipIf: function() {
              return $(".user-panel:visible").length == 0;
            }
          },
    	    {
		        title: "Search Panel",
		        text: "In this panel you can search something.",
            subject: "div:has(#searchBox):last()",
            targets: "div:has(#searchBox):last()",
            lockSubject: true,
            skipIf: function() {
              return $("#searchBox").length == 0;
            }
          },
    	    {
		        title: "Go To Panel",
		        text: "In this panel you quick navigating between header and child.",
            subject: "#gotoPanel",
            targets: "#gotoPanel",
            lockSubject: true,
            skipIf: function() {
              return $("#gotoPanel").length == 0;
            }, 
            listeners:{
              beforeStep: function() { 
                if($("#gotoPanel.active").length == 0)
                    $("#gotoPanel a").click();
              }
            }
          },
    	    {
		        title: "Document Information Panel",
		        text: "In this panel you can see any information such as created user, created date etc.",
            subject: "#docInfoPanel",
            targets: "#docInfoPanel",
            lockSubject: true,
            skipIf: function() {
              return $("#docInfoPanel").length == 0;
            }, 
            listeners:{
              beforeStep: function() { 
                if($("#docInfoPanel.active").length == 0)
                    $("#docInfoPanel a").click();
              }
            }
          },
    	    {
		        title: "Document Talk Panel",
		        text: "In this panel you can see any comment for this document or you can post your comment here.",
            subject: "#docTalkPanel",
            targets: "#docTalkPanel",
            lockSubject: true,
            skipIf: function() {
              return $("#docTalkPanel").length == 0;
            }, 
            listeners:{
              beforeStep: function() { 
                if($("#docTalkPanel.active").length == 0)
                    $("#docTalkPanel a").click();
              }
            }
          },
    	    {
		        title: "Approval Panel",
		        text: "In this panel you can see any approval user list for this document only.",
            subject: "#aprvPanel",
            targets: "#aprvPanel",
            lockSubject: true,
            skipIf: function() {
              return $("#aprvPanel").length == 0;
            }, 
            listeners:{
              beforeStep: function() { 
                if($("#aprvPanel.active").length == 0)
                    $("#aprvPanel a").click();
              }
            }
          },
    	    {
		        title: "Report Panel",
		        text: "In this panel you can see any report or document that belong this document only.",
            subject: "#reportPanel",
            targets: "#reportPanel",
            lockSubject: true,
            skipIf: function() {
              return $("#reportPanel").length == 0;
            }, 
            listeners:{
              beforeStep: function() { 
                if($("#reportPanel.active").length == 0)
                    $("#reportPanel a").click();
              }
            }
          },
    	    {
		        title: "Child",
		        text: "This is the child of the header. Sometimes you need to fill all header's child.",
            subject: "div[id^='child']:eq(0)",
            targets: "div[id^='child']:eq(0)",
            lockSubject: true,
            skipIf: function() {
              return $("div[id^='child']:eq(0)").length == 0;
            }            
          },
    	    {
		        title: "Create New",
		        text: "If you want to directly create a new form, you can click this link.",
            subject: ".breadcrumb",
            targets: ".breadcrumb>li:last()",
            lockSubject: true
          },
          {
	          title: "Finish",
	          text: "That's all <xsl:value-of select="sqroot/header/info/user/userName"/>, it's the end of my help guide. Thank you for let me help you. See you again :) ",
          }
	      ]
      });      

    </script>
    <!-- Page script -->
	<xsl:apply-templates select="sqroot" />

    <script>
      $(document).ready(function(){
      $("#button-menu-phone").click(function(){
      $('#right-menu-phone').removeClass("in");

      });
      $("#button-menu-phone2").click(function(){
      $('#mobilemenupanel').removeClass("in");


      });
      $('.expand-td').click(function(){
      var target = $(this).attr('data-target');
      // alert(target);
      var ids = $('.browse-data').map(function() {
      var id = this.id;
      if ('#'+id != target){
      // alert(id);
      $('#'+id).attr('class', 'browse-data accordian-body collapse');
      }
      // this.id.removeClass(in)
      // alert(this.id);
      })

      // alert(ids); // Result: a,b,c,d
      });
      });
    </script>

  </xsl:template>
  
  <xsl:template match="sqroot">
      <header class="main-header">
      <a href="javascript:goHome();" class="logo visible-phone" style="text-align:left;">
        <span class="logo-mini" style="font-size:9px; text-align:center">
          <img width="30" src="OPHContent/themes/{header/info/themeFolder}/images/oph4_logo.png" alt="Logo Image" />
        </span>
        <span class="logo-lg" style="font-size:22px;">
          <div class="pull-left" style="margin-right:10px;">
            <img width="30" style="margin-top:-9px;" src="OPHContent/themes/{header/info/themeFolder}/images/oph4_logo.png" alt="Logo Image" />
          </div>
          <xsl:value-of select="header/info/company" />
        </span>
      </a>
      <nav class="navbar navbar-static-top">
        <a href="#" class="sidebar-toggle visible-phone" data-toggle="offcanvas" role="button" >
          <span class="sr-only">Toggle navigation</span>
        </a>
        <div id ="button-menu-phone" class="unvisible-phone" style="color:white;  margin:0; display:inline-table; margin-top:15px; margin-left:10px" data-toggle="collapse" data-target="#mobilemenupanel">
          <a href="#" style="color:white;">
            <span>
              <img width="30" style="margin-top:-9px;" src="OPHContent/themes/{header/info/themeFolder}/images/oph4_logo.png" alt="Logo Image" />
            </span>&#160;
            <xsl:value-of select="header/info/code/name"/>&#160;(<xsl:value-of select="header/info/code/id"/>)<span class="caret"></span>
          </a>
        </div>
        <div class="accordian-body collapse top-menu-div" id="mobilemenupanel" style="color:white; position:absolute; background:#222D32; z-index:100; width:100%; right:0px; top:50px; ">
          <div class="input-group sidebar-form">
            <input type="text" id="searchBox1" name="searchBox1" class="form-control" placeholder="Search..." onkeypress="return searchText(event,this.value);" value="" />
            <span class="input-group-btn">
              <button type="button" name="search" id="search-btn" class="btn btn-flat" onclick="searchText(event);">
                <ix class="fa fa-search" aria-hidden="true"></ix>
              </button>
            </span>
          </div>
          <div class="panel-group" id="accordion2">
            <xsl:apply-templates select="header/menus/menu[@code='sidebar']/submenus/submenu" />
            &#160;
          </div>
        </div>
        <div class="navbar-custom-menu">
          <ul class="nav navbar-nav">
            <li>
              <a style="cursor:pointer;" onclick="Sideshow.start();" data-toggle="tooltip" data-placement="bottom" title="Help?">
                <ix class="fa fa-question-circle fa-lg"></ix>
              </a>
            </li>
            <li class="dropdown user user-menu">
              <xsl:choose>
                <xsl:when test="not(header/info/user/userId)">
                  <a href="#" data-toggle="modal" data-target="#login-modal">
                    <span><ix class="fa fa-sign-in"></ix>&#160;</span>
                    <span>Sign in</span>
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                    <img src="OPHContent/documents/{header/info/account}/{header/info/user/userURL}" class="user-image" alt="User Image"/>
                    <span class="hidden-xs">
                      <xsl:value-of select="header/info/user/userName"/>
                    </span>
                  </a>
                  <ul class="dropdown-menu">
                    <!-- User image -->
                    <li class="user-header">
                      <img src="OPHContent/documents/{header/info/account}/{header/info/user/userURL}" class="img-circle" alt="User Image"/>
                      <p>
                        <xsl:value-of select="header/info/user/userName"/>
                        <small>Active since <xsl:value-of select="header/info/user/dateCreate"/></small>
                      </p>
                    </li>
                    <!-- Menu Body -->
                    <li class="user-body">
                      <div class="row">
                        <xsl:for-each select="header/menus/menu[@code='primaryback']/submenus/submenu">
                          <div class="col-xs-{$colMenu} text-center">
                            <a class="withBorder" href="{pageURL}">
                              <xsl:value-of select="caption" />&#160;
                            </a>
                          </div>
                        </xsl:for-each>
                      </div>
                    </li>
                    <!-- Menu Footer-->
                    <li class="user-footer">
                      <div class="pull-left">
                        <a href="?code=profile" class="btn btn-default btn-flat">
                          <span><ix class="fa fa-user"></ix></span>
            						  <span>Profile</span>
                        </a>
                      </div>
                      <div class="pull-right">
                        <a href="javascript:signOut()" class="btn btn-default btn-flat">
                          <span><ix class="fa fa-power-off"></ix></span>
                          <span>Sign out</span>
                        </a>
                      </div>
                    </li>
                  </ul>
                </xsl:otherwise>
              </xsl:choose>
            </li>
          </ul>
        </div>
      </nav>
    </header>

    <!-- *** LOGIN MODAL ***-->
    <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="signinLabel" aria-hidden="true">
      <div class="modal-dialog modal-sm" role="document">

        <div class="modal-content">
          <form id="signinForm" method="post">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&#215;</button>
              <h4 class="modal-title" id="signinLabel">Sign in</h4>
            </div>

            <div class="modal-body">
              <div class="form-group">
                <input type="text" class="form-control" id="userid" placeholder="user id" />
              </div>
              <div class="form-group">
                <input type="password" class="form-control" id="pwd" placeholder="password" />
              </div>

              <p class="text-center text-muted">Not registered yet?</p>
              <p class="text-center text-muted">
                <a href="customer-register.html">
                  <strong>Register now</strong>
                </a>! It is easy and done in 1&#160;minute and gives you access to special discounts and much more!
              </p>

            </div>
            <div class="modal-footer">

              <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
              <a href="javascript: signIn();">
                <button type="button" class="btn btn-primary">
                  <span>
                    <ix class="fa fa-sign-in"></ix>&#160;
                  </span>Sign In
                </button>
              </a>

            </div>
          </form>
        </div>
      </div>
    </div>
    <!-- *** LOGIN MODAL END *** -->
    
    <!-- *** NOTIFICATION MODAL -->
    <div id="notiModal" class="modal fade" role="dialog" tabindex="-1">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&#215;</button>
            <h4 class="modal-title" id="notiTitle">Modal Header</h4>
          </div>
          <div class="modal-body" id="notiContent">
            <p>Some text in the modal.</p>
          </div>
          <div class="modal-footer">
            <button id="notiBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>

      </div>
    </div>
    <!-- *** NOTIFICATION MODAL END -->

    <!-- Left side column. contains the logo and sidebar -->
    <aside  class="main-sidebar">
      <!-- sidebar: style can be found in sidebar.less -->
      <section id="sidebarWrapper" class="sidebar">
        <div class="overlay">
          <ix class="fas fa-spinner fa-pulse"></ix>
        </div>
      </section>
    </aside>
    
    <!-- Content Wrapper. Contains page content -->
    <div id="contentWrapper" class="content-wrapper">
      <div style="padding-top: 10px; padding-right: 10px; padding-bottom: 10px; padding-left: 10px">
        <div class="overlay">
          <ix class="fas fa-spinner fa-pulse"></ix>
        </div>
      </div>
    </div>
    <!-- /.content-wrapper -->
    <footer class="main-footer">
      <div class="pull-right hidden-xs">
        <b>Version</b> 4.0
      </div>
      <strong>
        Copyright &#169; 2018 <a href="#">Operahouse</a>.
      </strong> All rights reserved.
    </footer>

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
      <!-- Create the tabs -->
      <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
        <li>
          <a href="#control-sidebar-home-tab" data-toggle="tab">
            <ix class="fa fa-home"></ix>
          </a>
        </li>
        <li>
          <a href="#control-sidebar-settings-tab" data-toggle="tab">
            <ix class="fa fa-gears"></ix>
          </a>
        </li>
      </ul>

    </aside>
    <!-- /.control-sidebar -->
    <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
    <div class="control-sidebar-bg">&#160;</div>

    <!-- ./wrapper -->
  </xsl:template>
  
<xsl:include href="_menu.xslt" />

</xsl:stylesheet>
