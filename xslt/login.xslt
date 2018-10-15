<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" >

  <xsl:template match="/">

    <script>

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

      var meta = document.createElement('meta');
      meta.name = "google-signin-client_id";
      meta.content = "234818231644-j4feqpc6c3gg0iks95808eg5nutlfquu.apps.googleusercontent.com";
      loadMeta(meta);

      changeSkinColor();
      //$("body").addClass("skin-blue");
      $("body").addClass("hold-transition");
      $("body").addClass("sidebar-mini");
      $("body").addClass("fixed");

      loadScript('OPHContent/cdn/admin-LTE/js/app.min.js');

      if (getCookie('isWhiteAddress') == '0' || getCookie('isWhiteAddress') == undefined || getCookie('isWhiteAddress') == '') {
      loadScript('https://www.google.com/recaptcha/api.js');
      loadScript('https://apis.google.com/js/platform.js');

      }
      
      signoff();
      
      document.title='<xsl:value-of select="/sqroot/header/info/title"/>';


    </script>

    <div class="wrapper" style="background: rgba(38, 44, 44, 0.1);">

      <header class="main-header">
        <!-- Logo -->
        <a href="javascript:goHome();" class="logo visible-phone" style="text-align:left;"></a>
        <!-- Header Navbar: style can be found in header.less -->
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
                <xsl:value-of select="sqroot/header/info/company"/>
              </span>
            </a>
          </div>
        </nav>
      </header>

      <!-- *** NOTIFICATION MODAL -->
      <div id="notiModal" class="modal fade" role="dialog">
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

      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper" style="background:white">
        <section class="content">
          <div class="row">
            <div class="col-md-12">
              <h1 style="font-size:40px; font-weight:bold">
                WELCOME TO <br/>
                <xsl:value-of select="sqroot/header/info/company"/>&#160;<xsl:value-of select="sqroot/header/info/productName"/>
              </h1>

            </div>
          </div>
          <div class="row">
            <div class="col-md-6">
              <h3>Use a local account to sign in</h3>

              <h4 style="color:gray">Please enter your username and password</h4>
              <form id="formlogin" onsubmit ="return signIn('{/sqroot/header/info/account}');">
                <div class="form-group enabled-input">
                  <label>User Name</label>
                  <input type="text" class="form-control" name ="{/sqroot/header/info/account}_userid" id ="{/sqroot/header/info/account}_userid" autofocus="autofocus" onkeypress="return checkenter(event)"/>
                </div>
                <div class="form-group enabled-input">
                  <label>Password</label>
                  <input type="password" class="form-control" name ="{/sqroot/header/info/account}_pwd" id ="{/sqroot/header/info/account}_pwd" autocomplete="off" placeholder="password" onkeypress="return checkenter(event)"/>
                </div>
                <div class="g-recaptcha" data-sitekey="6Ld9Qi8UAAAAAJKicrf2JhrOH3k5LkqxyCodIOWm"></div>
                <br/>
              </form>
              <div style="text-align:center">
                <button id="btn_submitLogin" class="btn btn-orange-a">SUBMIT</button>&#160;
                <button class="btn btn-gray-a" onclick="clearLoginText();">CLEAR</button>
              </div>
              <br/>
              <!--<div>
                <div>
                  <a href="">Register as a new user?</a>
                </div>
                <div>
                  <a href="">Forgot your password?</a>
                </div>
              </div>-->
            </div>
            <div class="col-md-6 visible-phone">
              <img id="login_header" src="" alt="" />
              <script>
                 var acct='<xsl:value-of select="/sqroot/header/info/account"/>';
                $("#login_header").attr("src","OPHContent/documents/"+acct+"/login_header.jpg");
              </script>
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
        <strong>
          Copyright &#169; 2018 <a href="#">OPERAHOUSE</a>.
        </strong> All rights reserved.
      </footer>
    </div>

    <!-- jQuery 2.2.3 -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script>
      if (getCookie('isWhiteAddress') == '1') {
      $('#formlogin .g-recaptcha').remove();
      $('#btn_submitLogin').click(function() {
          signIn('<xsl:value-of select="/sqroot/header/info/account"/>')
          }
      )
      } else {
      $('#btn_submitLogin').click(function() {
          signIn('<xsl:value-of select="/sqroot/header/info/account"/>')
          }
      )
      }

      function checkenter(e) {
      if (e.keyCode == 13) {
      if (getCookie('isWhiteAddress') == '1') {
      signIn('<xsl:value-of select="/sqroot/header/info/account"/>');
      }
      else {
      signIn('<xsl:value-of select="/sqroot/header/info/account"/>');
      }
      }
      }

    </script>

  </xsl:template>
</xsl:stylesheet>
