﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" >

  <xsl:template match="/">

	<script>
		//loadScript('https://apis.google.com/js/platform.js?onload=init');
		var meta = document.createElement('meta');
		meta.charset = "UTF-8";
		loadMeta(meta);

		var meta = document.createElement('meta');
		meta.httpEquiv = "X-UA-Compatible";
		meta.content = "IE=edge";
		loadMeta(meta);

		var meta = document.createElement('meta');
		meta.name = "viewport";
		meta.content = "width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no";
		loadMeta(meta);


	
		changeSkinColor();
		//$("body").addClass("skin-blue");
		$("body").addClass("hold-transition");
		//$("body").addClass("sidebar-collapse");
		$("body").addClass("layout-top-nav");
		$("body").addClass("fixed");	  
		$("body").css("height:100%");
		$("html").css("height:100%");

		loadScript('OPHContent/cdn/admin-LTE/js/app.min.js');
		document.title='<xsl:value-of select="/sqroot/header/info/title"/>';


		if (getCookie('isWhiteAddress') == '0' || getCookie('isWhiteAddress') == undefined || getCookie('isWhiteAddress') == '') {
			loadScript('https://www.google.com/recaptcha/api.js');
			loadScript('https://apis.google.com/js/platform.js');
		}
	
		if (getCookie('isWhiteAddress') == '1') {
			$('#formlogin .g-recaptcha').remove();
		}


		//signoff();

		if (getCookie("AutoUser")) {
			$('#autologin').css('display','block');
			$('#autoUser').html(getCookie("AutoUser"));
		}
		else {
		}

		$('.sidebar-toggle').click(function() {
			if ($('body').hasClass('sidebar-collapse')) $('body').removeClass('sidebar-collapse');
			else $('body').addClass('sidebar-collapse');
		});
	  
		setCookie('<xsl:value-of select="/sqroot/header/info/account"/>_accountid', '<xsl:value-of select="/sqroot/header/info/suba"/>', 365,0,0);
		var mode=getQueryVariable("mode");
		if (mode=='' || mode==undefined) mode=2;
		var gmode='';
		if (mode=="1" &amp;&amp; getCookie('<xsl:value-of select="/sqroot/header/info/account"/>_multiAccount')!='0') {
			setCookie('<xsl:value-of select="/sqroot/header/info/account"/>_accountid', '', 365,0,0);
			$(".mode-createaccount").removeClass('hide');
			//$(".gsignup").addClass('g-signin2');
			gmode='gsignup';
		}
		else if (mode=="7") {
			$(".mode-createuser").removeClass('hide');
		}
	  
		else if (mode=="4" &amp;&amp; getQueryVariable("email")!='' &amp;&amp; getQueryVariable("email")!=undefined) $(".mode-verifyemail").removeClass('hide');
		else if (mode=="3" || (mode=="4" &amp;&amp; (getQueryVariable("email")=='' || getQueryVariable("email")==undefined))) $(".mode-forgotpassword").removeClass('hide');
		else if (mode=="5" &amp;&amp; (getQueryVariable("expired")=='1' || (getQueryVariable("email")!='' &amp;&amp; getQueryVariable("secret")!='' 
			&amp;&amp; getQueryVariable("email")!=undefined &amp;&amp; getQueryVariable("secret")!=undefined))) $(".mode-resetpassword").removeClass('hide');
		else if ((mode=="6" &amp;&amp; getCookie('<xsl:value-of select="/sqroot/header/info/account"/>_multiAccount')!='0')) {
			
			setCookie('<xsl:value-of select="/sqroot/header/info/account"/>_accountid', '', 365,0,0);
			$(".mode-chooseaccount").removeClass('hide');
		  
		}
		else {
			$(".mode-login").removeClass('hide');
			//$(".gsignin").addClass('g-signin2');
			//renderGButton('gsignin');
			gmode='gsignin';
		}
		if (getCookie('<xsl:value-of select="/sqroot/header/info/account"/>_multiAccount')!='0') $('#chooseLink').removeClass('hide');

		if (getCookie('<xsl:value-of select="/sqroot/header/info/account"/>_accountid')!='') $('.box-title').html('<xsl:value-of select="sqroot/header/info/company"/> '+getCookie('<xsl:value-of select="/sqroot/header/info/account"/>_accountid'));

			var n=new Date(Date.now());
			$('#cp').html($('#cp').html().split('#year#').join(n.getFullYear()));

		//google signin
	
		//window.onLoadCallback = function(){	  
		/*
		gSigninInit('##gsigninclientid##', function() {
			var a2 = gapi.auth2.getAuthInstance();
			if (a2.isSignedIn.get()) {
				a2.signOut().then(function () {
					//a2.disconnect();		
					if (gmode!='')	  renderGButton(gmode);
				});	
			}
			else if (gmode!='')	  renderGButton(gmode);
		
		});
		*/
	  
		//}
		//google signin - end


      function checkEnterSignIn(e) {
      if (e.keyCode == 13) {
      signIn('<xsl:value-of select="/sqroot/header/info/account"/>');
      }}

      function checkEnterSignUp(e) {
      if (e.keyCode == 13) {
      signUp('<xsl:value-of select="/sqroot/header/info/account"/>');
      }}

      function checkEnterForgot(e) {
      if (e.keyCode == 13) {
      checkForgot('<xsl:value-of select="/sqroot/header/info/account"/>', $('#forgotemailaddress').val());
      }}

      function checkEnterVerify(e) {
      if (e.keyCode == 13) {
      checkCode('<xsl:value-of select="/sqroot/header/info/account"/>', $('#entercode').val());
      }}

      function checkEnterReset(e) {
      if (e.keyCode == 13) {
      resetPwd('<xsl:value-of select="/sqroot/header/info/account"/>', $('#resetnewpwd').val(), $('#resetconfirmpwd').val());
      }}

      function checkEnterChoose(e) {
      if (e.keyCode == 13) {
      chooseAccount('<xsl:value-of select="/sqroot/header/info/account"/>', $('#accountid').val());
      }}

      function goToChoose() {
        setCookie('<xsl:value-of select="/sqroot/header/info/account"/>_accountid', '', 1, 1, 0);
        goTo('?code=login&amp;mode=6');
      }
    </script>																				   

    <div class="wrapper" style="background: rgba(38, 44, 44, 0.1);height:100%">

      <!--header class="main-header">
        <a href="javascript:goHome();" class="logo visible-phone" style="text-align:left;"></a>
        <nav class="navbar navbar-static-top">
          <div id ="button-menu-phone"  class="" style="color:white;margin:0; display:inline-table; margin-top:5px; margin-left:10px" data-toggle="collapse" data-target="#demo5">
            <a href="#" style="color:white;">
              <span>
                <img width="30" style="margin-top:-9px;" alt="Logo Image" id="logoimg"/>
                <script>
                  $("#logoimg").attr("src","OPHContent/themes/"+loadThemeFolder()+"/images/oph4_logo.png");
                </script>
              </span>
              <span style="font-size:25px;">
                <xsl:value-of select="sqroot/header/info/productName"/>
              </span>
            </a>
          </div>
        </nav>
      </header-->

      <!-- *** NOTIFICATION MODAL -->
      <!--div id="notiModal" class="modal fade" role="dialog" tabindex="-1">
        <div class="modal-dialog"-->
      <!-- Modal content-->
      <!--div class="modal-content">
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
      </div-->
      <!-- *** NOTIFICATION MODAL END -->

      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper" style="background:white;height:100%">
        <section class="content">
          <!--div class="row">
            <div class="col-md-4">
              <h1>
                WELCOME TO <br/>
                <xsl:value-of select="sqroot/header/info/company"/>
              </h1>

            </div>
          </div-->
          <div class="row equal">
            <div class="col-md-6 col-sm-12 col-xs-12" id="autologin" style="display:none">
              <div class="box box-solid box-default">
                <div class="box-header">
                  <h3 class="box-title">Windows login</h3>
                </div>
                <div class="box-body">
                  <div class="form-group enabled-input">
                    <h3>
                      Welcome <span id="autoUser">Guest</span>.
                    </h3>
                    <h4>You are registered in windows login. You may have a direct access without enter the password. If failed, you can try the local account authentication.</h4>
                    <!--div class="form-group enabled-input">
                    <input type="checkbox" id="skipAutoLoginPage" /><label for="skipAutoLoginPage">Skip this page for next visit.</label>
                  </div-->
                  </div>
                </div>
                <div class="box-footer clearfix">
                  <div style="text-align:center">
                    <button id="btn_autologin" class="btn btn-orange-a" onclick="signIn('{/sqroot/header/info/account}', 1)">ENTER NOW</button>&#160;
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-6 col-sm-12 col-xs-12 mode-login hide" style="float:none;margin:auto;">
              <div class="box box-solid box-primary">
                <div class="box-header">
                  <h1>
                    <xsl:value-of select="sqroot/header/info/company"/>
                  </h1>
                  <h3 class="box-title">Local Login</h3>
                </div>
                <div class="box-body">
                  <h3>You can use a local account to sign in</h3>
                  <h4 style="color:gray">Please enter your username and password</h4>
                  <form id="formlogin" onsubmit ="return signIn('{/sqroot/header/info/account}');">
                    <div class="form-group enabled-input">
                      <label>User Name</label>
                      <input type="text" class="form-control" name ="userid" id ="userid" autofocus="autofocus" onkeypress="return checkEnterSignIn(event)"/>
                      <label>Password</label>
                      <input type="password" class="form-control" name ="pwd" id ="pwd" autocomplete="off" placeholder="password" onkeypress="return checkEnterSignIn(event)"/>
                    </div>
                    <div class="g-recaptcha" data-sitekey="##recaptchakey##"></div>
                    <a href="?code=login&amp;mode=3">Forgot Password</a>
                    <br />
                    <a class="hide" id="chooseLink" href="javascript:goToChoose();">Choose another account</a>
                  </form>
                </div>
                <div class="box-footer clearfix">
                  <div style="text-align:center">
                    <button id="btn_submitLogin" 
                      onclick="javascript: signIn('{/sqroot/header/info/account}')"
                      class="btn btn-orange-a">SUBMIT</button>&#160;
                    <button class="btn btn-gray-a" onclick="clearLoginText();">CLEAR</button>
					<div class="btn" id="gsignin" data-onsuccess="signInGConnect" data-theme="dark"></div>

                  </div>
                </div>
              </div>
            </div>
            <!--div class="col-md-4 visible-phone">
              <img id="login_header" src="" alt="" />
              <script>
                var acct='<xsl:value-of select="/sqroot/header/info/account"/>';
                $("#login_header").attr("src","OPHContent/documents/"+acct+"/login_header.jpg");
              </script>
            </div-->

            <div class="col-md-6 col-sm-12 col-xs-12 mode-createaccount hide" style="float:none;margin:auto;">
              <div class="box box-solid box-primary">
                <div class="box-header">
                  <h1>
                    <xsl:value-of select="sqroot/header/info/company"/>
                  </h1>
                  <h3 class="box-title">Create a new account</h3>
                </div>
                <div class="box-body">
                  <!--h3>You can use a local account to sign in</h3-->
                  <form id="formcreateaccount">
                    <h4 style="color:gray">Please enter Account ID and Organization Name</h4>
                    <div class="form-group enabled-input">
                      <label>Account ID</label>
                      <input type="text" class="form-control" name ="newaccountid" id ="newaccountid" autofocus="autofocus" onkeypress="return checkEnterSignUp(event)"/>
                      <label>Organization Name</label>
                      <input type="text" class="form-control" name ="companyname" id ="companyname" autofocus="autofocus" onkeypress="return checkEnterSignUp(event)"/>
                    </div>
                    <h4 style="color:gray">Please enter your Administrator Name and Email Address</h4>
                    <div class="form-group enabled-input">
                      <label>Your Name</label>
                      <input type="text" class="form-control" name ="adminname" id ="adminname" autofocus="autofocus" onkeypress="return checkEnterSignUp(event)"/>
                      <label>Email Address</label>
                      <input type="text" class="form-control" name ="emailaddress" id ="emailaddress" autofocus="autofocus" onkeypress="return checkEnterSignUp(event)"/>
                      <!--label>New Password</label>
                      <input type="password" class="form-control" name ="newpwd" id ="newpwd" autocomplete="off" placeholder="password" onkeypress="return checkEnterSignUp(event)"/>
                      <label>Confirm Password</label>
                      <input type="password" class="form-control" name ="confirmpwd" id ="confirmpwd" autocomplete="off" placeholder="password" onkeypress="return checkEnterSignUp(event)"/-->
                    </div>
					
                    <div class="g-recaptcha" data-sitekey="##recaptchakey##"></div>
                    <a href="?code=login&amp;mode=6">Choose existing account</a>
                  </form>
                </div>
                <div class="box-footer clearfix">
                  <div style="text-align:center">
                    <button id="btn_submitCreateAccount"
                      onclick="signUp('{/sqroot/header/info/account}');"
                      class="btn btn-orange-a">SUBMIT</button>&#160;
                    <button class="btn btn-gray-a" onclick="clearLoginText();">CLEAR</button>
					<div class="btn" id="gsignup" data-onsuccess="signUpGConnect" data-theme="dark"></div>
                  </div>
				  
                </div>
              </div>
            </div>

            <div class="col-md-6 col-sm-12 col-xs-12 mode-chooseaccount hide" style="float:none;margin:auto;">
              <div class="box box-solid box-primary">
                <div class="box-header">
                  <h1>
                    <xsl:value-of select="sqroot/header/info/company"/>
                  </h1>
                  <h3 class="box-title">Choose your accounts</h3>
                </div>
                <div class="box-body">
                  <!--h3>You can use a local account to sign in</h3-->
                  <!--h4 style="color:gray">Please enter your username and password</h4-->
                  <form id="formchooseaccount" onsubmit ="return signIn('{/sqroot/header/info/account}');">
                    <div class="form-group enabled-input">
                      <label>Account ID</label>
                      <input type="text" class="form-control" name ="accountid" id ="accountid" autofocus="autofocus" onkeypress="return checkEnterChoose(event)"/>
                    </div>
                    <a href="?code=login&amp;mode=1">Create a new account</a>
                  </form>
                </div>
                <div class="box-footer clearfix">
                  <div style="text-align:center">
                    <button onclick="chooseAccount('{/sqroot/header/info/account}', $('#accountid').val());" id="btn_next" class="btn btn-orange-a">NEXT</button>&#160;
                  </div>
                </div>
              </div>
            </div>

            <div class="col-md-6 col-sm-12 col-xs-12 mode-forgotpassword hide" style="float:none;margin:auto;">
              <div class="box box-solid box-primary">
                <div class="box-header">
                  <h1>
                    <xsl:value-of select="sqroot/header/info/company"/>
                  </h1>
                  <h3 class="box-title">Forgot your password?</h3>
                </div>
                <div class="box-body">
                  <!--h3>You can use a local account to sign in</h3-->
                  <!--h4 style="color:gray">Please enter your username and password</h4-->
                  <form id="formforgotpassword" onsubmit ="return signIn('{/sqroot/header/info/account}');">
                    <div class="form-group enabled-input">
                      <label>Email Address</label>
                      <input type="text" class="form-control" name ="forgotemailaddress" id ="forgotemailaddress" autofocus="autofocus" onkeypress="return checkEnterForgot(event)"/>
                    </div>
                    <div class="g-recaptcha" data-sitekey="##recaptchakey##"></div>
                    <a href="?code=login">Try login again</a>
                  </form>
                </div>
                <div class="box-footer clearfix">
                  <div style="text-align:center">
                    <button onclick="checkForgot('{/sqroot/header/info/account}', $('#forgotemailaddress').val());" id="btn_next" class="btn btn-orange-a">NEXT</button>&#160;
                  </div>
                </div>
              </div>
            </div>

            <div class="col-md-6 col-sm-12 col-xs-12 mode-verifyemail hide" style="float:none;margin:auto;">
              <div class="box box-solid box-primary">
                <div class="box-header">
                  <h1>
                    <xsl:value-of select="sqroot/header/info/company"/>
                  </h1>
                  <h3 class="box-title">Verify code from your email</h3>
                </div>
                <div class="box-body">
                  <!--h3>You can use a local account to sign in</h3-->
                  <!--h4 style="color:gray">Please enter your username and password</h4-->
                  <form id="formverifyemail" onsubmit ="return signIn('{/sqroot/header/info/account}');">
                    <div class="form-group enabled-input">
                      <label>Code from your email</label>
                      <input type="text" class="form-control" name ="entercode" id ="entercode" autofocus="autofocus" onkeypress="return checkEnterVerify(event)"/>
                    </div>
                    <a href="?code=login&amp;mode=3">resend again</a>
                  </form>
                </div>
                <div class="box-footer clearfix">
                  <div style="text-align:center">
                    <button onclick="checkCode('{/sqroot/header/info/account}', $('#entercode').val());" id="btn_next" class="btn btn-orange-a">NEXT</button>&#160;
                  </div>
                </div>
              </div>
            </div>

            <div class="col-md-6 col-sm-12 col-xs-12 mode-resetpassword hide" style="float:none;margin:auto;">
              <div class="box box-solid box-primary">
                <div class="box-header">
                  <h1>
                    <xsl:value-of select="sqroot/header/info/company"/>
                  </h1>
                  <h3 class="box-title">Reset Password</h3>
                </div>
                <div class="box-body">
                  <!--h3>You can use a local account to sign in</h3-->
                  <!--h4 style="color:gray">Please enter your username and password</h4-->
                  <form id="formresetpassword" onsubmit ="return signIn('{/sqroot/header/info/account}');">
                    <div class="form-group enabled-input">
                      <label>New Password</label>
                      <input type="password" class="form-control" name ="resetnewpwd" id ="resetnewpwd" autofocus="autofocus" onkeypress="return checkEnterReset(event)"/>
                      <label>Confirm Password</label>
                      <input type="password" class="form-control" name ="resetconfirmpwd" id ="resetconfirmpwd" autofocus="autofocus" onkeypress="return checkEnterReset(event)"/>
                    </div>
                  </form>
                </div>
                <div class="box-footer clearfix">
                  <div style="text-align:center">
                    <button onclick="resetPwd('{/sqroot/header/info/account}', $('#resetnewpwd').val(), $('#resetconfirmpwd').val());" id="btn_next" class="btn btn-orange-a">SUBMIT</button>&#160;
                  </div>
                </div>
              </div>
            </div>

            <!--<div class="col-md-5">
              
              <h3>Use another services to sign in</h3>

              <div>
                <span class="g-signin2" data-onsuccess="signInGConnect"></span>
              </div>

            </div>-->
            <!--<div class="col-md-6">
              <div style="margin-top:100px;"></div>
              <h3>FORGOT PASSWORD</h3>
              <br/>
              <form>
                <div class="form-group enabled-input">
                  <label>E-Mail Address</label>
                  <input type="email" class="form-control" />
                </div>
                <br/>
                <div style="text-align:center">
                  <button class="btn btn-orange-a">SUBMIT</button>
                </div>
                <br/>
                <br/>

              </form>
            </div>-->
          </div>
        </section>
      </div>
      <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Version</b> 4.0
        </div>
		<div id="cp">
        <strong>
          Copyright &#169; #year# <a href="#">operahouse.systems</a>.
        </strong> All rights reserved.
		</div>
      </footer>
    </div>

    

  </xsl:template>
</xsl:stylesheet>
