<?xml version="1.0" encoding="utf-8"?>
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
	  $("body").css("height:100%");
	  $("html").css("height:100%");

      loadScript('OPHContent/cdn/admin-LTE/js/app.min.js');
      document.title='<xsl:value-of select="/sqroot/header/info/title"/>';


      if (getCookie('isWhiteAddress') == '0' || getCookie('isWhiteAddress') == undefined || getCookie('isWhiteAddress') == '') {
      loadScript('https://www.google.com/recaptcha/api.js');
      loadScript('https://apis.google.com/js/platform.js');

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

  	  $(".mode-login").removeClass('hide');

		var n=new Date(Date.now());
		$('#cp').html($('#cp').html().split('#year#').join(n.getFullYear()));


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
            <div class="col-md-6 col-sm-12 col-xs-12" style="float:none;margin:auto;">
              <div class="box box-solid box-primary">
                <div class="box-header">
                  <h1>
                    KEBIJAKAN PRIVASI
                  </h1>
                  <!--h3 class="box-title">KEBIJAKAN PRIVASI</h3-->
                </div>
                <div class="box-body">
                  <!--h3>You can use a local account to sign in</h3>
                  <h4 style="color:gray">Please enter your username and password</h4-->
                  
<p>Dengan mengklik tombol "ACCEPT": 
</p><p>(a) Jika Anda menyatakan bahwa anda memahami dan setuju bahwa Anda adalah penguna yang terikat secara hukum dengan perjanjian privasi Aplikasi “NANDA INDONESIA” ("Perjanjian" ini) , dan 
</p><p>(b) Anda atau perusahaan atau badan yang Anda wakili ("Licensee") tanpa syarat menyetujui bahwa Anda adalah penguna yang terikat oleh hukum dan menjadi salah satu pihak dalam perjanjian ini. Jika Anda atau Licensee tidak menyetujui semua ketentuan perjanjian dari ini, Anda atau Licensee harus klik "BATAL" untuk menghentikan download dan proses instalasi, atau untuk menghentikan perangkat lunak (sebagaimana ditetapkan di bawah) dari berjalan jika telah pra-dipasang. 
</p><p>Jika persyaratan ini dianggap sebagai sebuah penawaran, penerimaan secara tegas terbatas pada perjanjian ini. Licensee mengakui dan setuju bahwa penggunaan perangkat lunak dan setiap file-file (sebagaimana ditetapkan di bawah)  juga tunduk pada ketentuan layanan yang berlaku ("SYARAT LAYANAN").

</p><p>1. Pemberian Privasi
</p><p>(a) Sesuai dengan ketentuan Perjanjian ini, CV. EGC ARCAN adalah pemilik Aplikasi NANDA INDONESIA dalam menjalankan Aplikasi NANDA INDONESIA, CV. EGC bekerja sama dengan pengembang Aplikasi NANDA INDONESIA. 
</p><p>(b) CV. EGC sebagai pemilik Aplikasi NANDA INDONESIA sudah mendapatkan lisensi atau izin atau persetujuan dari pihak ketiga pemilik atau pemegang hak cipta buku NANDA INTERNATIONAL untuk membuat Aplikasi NANDA INDONESIA. Lisensi tersebut tidak terbatas hanya untuk membuat Aplikasi NANDA INDONESIA namun untuk mengubah bentuk atau tata letak dari buku NANDA INTERNATIONAL tanpa mengubah isi dan makna dari buku tersebut.
 
</p><p>2. Pembatasan Privasi
</p><p>Kecuali secara tegas dan jelas diizinkan oleh Perjanjian ini, Pemegang Privasi tidak boleh, atau mengizinkan orang lain untuk: (a) meng-copy, memodifikasi, membuat karya turunan berdasarkan, atau mendistribusikan Perangkat Lunak atau File, (b) reverse engineer, menerjemahkan, membongkar, mendekompilasi, atau berupaya menemukan kode sumber atau struktur, urutan dan organisasi Perangkat Lunak, (c) sewa, menyewakan, mengalihkan, menjual kembali atau menggunakan Perangkat Lunak atau File untuk tujuan biro timesharing atau layanan, atau menggunakan Perangkat Lunak atau File untuk tujuan komersial atau atas nama atau untuk kepentingan pihak ketiga, atau (d) mengizinkan orang lain atau badan untuk menggunakan Perangkat Lunak atau File. Pengguna wajib mempertahankan dan tidak menghapus atau mengaburkan suatu pemberitahuan hak kepemilikan pada Perangkat Lunak dan File, dan akan mereproduksi pemberitahuan tepatnya pada semua salinan yang diizinkan dari Perangkat Lunak atau File. Setelah pemberitahuan yang wajar, CV. EGC dan Mitra memiliki hak untuk mengaudit catatan yang relevan dengan kepatuhan pengguna dengan Perjanjian ini. Pengguna memahami bahwa CV. EGC dan Mitra dapat mengubah atau menghentikan menawarkan Software atau File setiap saat. Perangkat Lunak dan File dilindungi oleh hukum Undang-undang Hak Cipta Republik Indonesia dan perjanjian hak cipta internasional. Perjanjian ini tidak memberikan hak privasi kepada pengguna, baik itu secara eksplisit maupun implisit. Pengguna tidak akan mengekspor, mengimpor atau mentransfer Perangkat Lunak atau File bertentangan dengan semua hukum yang berlaku, baik secara langsung maupun tidak langsung, dan tidak akan menyebabkan, menyetujui atau memfasilitasi orang lain seperti agen atau pihak ketiga dalam melakukannya. Semua hak untuk menggunakan Perangkat Lunak dan File diberikan dengan syarat bahwa hak-hak tersebut dibatalkan jika pengguna gagal untuk mematuhi persyaratan Perjanjian ini.

</p><p>3. Kekayaan Intelektual Konten
</p><p>Sebagai syarat untuk menggunakan Privasi Perangkat Lunak ini, pengguna menyatakan, menjamin dan berjanji tidak akan menggunakan Perangkat Lunak untuk: (a) melanggar hak kekayaan intelektual, hak milik, atau hak publisitas atau privasi dari semua pihak, (b) untuk melanggar hukum yang berlaku, undang-undang, atau peraturan yang berlaku, (c) untuk menyebarluaskan informasi atau materi dalam bentuk apapun atau format ("Konten") yang berbahaya, mengancam, kasar, melecehkan, berliku-liku, memfitnah, vulgar, cabul, berkata tidak menyenangkan, atau (d) untuk menyebarkan virus perangkat lunak atau kode komputer lainnya, file atau program yang dapat mengganggu, merusak atau membatasi fungsi dari software atau hardware komputer atau peralatan telekomunikasi. Pengguna mengakui bahwa semua konten yang diakses menggunakan Perangkat Lunak adalah satu-satunya risiko pengguna dan pengguna akan bertanggung jawab atas segala kerusakan kepada pihak yang ditimbulkannya.

</p><p>4. Dukungan dan Upgrade
</p><p>Perjanjian ini tidak memberikan hak kepada pengguna atas setiap upgrade dukungan, patch, perangkat tambahan atau perbaikan untuk aplikasi ini. Setiap dukungan tersebut untuk software yang dapat disediakan oleh CV. EGC dan Mitra pengembang aplikasi ini akan menjadi bagian dari Perangkat Lunak dan tunduk pada Perjanjian ini.
 
</p><p>5. Ganti Rugi
</p><p>Pengguna Aplikasi NANDA INDONESIA setuju untuk segera memberi tahu CV. EGC dari dan mengganti kerugian, membela dan menjauhkan CV. EGC dan Mitra serta pemasoknya dari setiap klaim atau permintaan, dan biaya pengacara terkait, yang dilakukan oleh pihak ketiga karena atau yang timbul dari penggunaan Privasi Perangkat Lunak ini atau File, pelanggaran Perjanjian ini oleh pengguna, setiap pelanggaran oleh pengguna pada setiap kekayaan intelektual atau hak lainnya dari setiap orang atau entitas.
 
</p><p>6. Pernyataan Garansi
</p><p>Sejauh diizinkan oleh hukum yang berlaku, CV. EGC dan Mitra yang menyediakan Aplikasi NANDA INDONESIA "Sebagaimana adanya" dan "Sebagaimana tersedia" dan tanpa jaminan apapun. CV. EGC dan Mitra tidak dapat menjamin kinerja atau hasil yang mungkin Anda peroleh menggunakan aplikasi ini. Penyanggahan atas jaminan ini merupakan bagian dasar dari perjanjian. Dalam kondisi apapun, CV. EGC dan Mitra tidak menjamin bahwa Aplikasi NANDA INDONESIA yang ada bebas dari kesalahan ataupun error saat penggunaan atau pengguna mampu mengoperasikan Aplikasi NANDA INDONESIA ini tanpa masalah atau interupsi.
 
</p><p>7. Masa Berlaku dan Terminasi
</p><p>Perjanjian ini akan berlangsung sampai diakhiri sebagaimana diatur dalam Perjanjian ini. Pengguna dapat mengakhiri Perjanjian ini setiap saat. Perjanjian ini secara otomatis akan berakhir jika Pengguna melanggar ketentuan apapun dalam Perjanjian ini. Setiap pengakhiran Perjanjian ini juga akan mengakhiri privasi penggunaan yang diberikan. Setelah pengakhiran Perjanjian ini karena alasan apapun, pengguna akan menghancurkan dan menghapus dari semua komputer, hard drive, jaringan, dan media penyimpanan lain semua salinan Perangkat Lunak dan File.
 
</p><p>8. Lain-Lain
</p><p>Perjanjian ini bersifat pribadi untuk pengguna dan tidak dapat dilimpahkan atau dialihkan dengan alasan apapun (termasuk, tanpa batasan, demi hukum, reorganisasi merger, atau perubahan kontrol) tanpa persetujuan CV. EGC dan segala upaya untuk melakukan hal itu tidak berlaku. 
 
9. KETIGA PERANGKAT LUNAK PIHAK SYARAT DAN KETENTUAN
Perangkat lunak ini disediakan "Apa adanya", tanpa jaminan apapun, tersurat maupun tersirat, termasuk namun tidak terbatas pada jaminan diperdagangkan, kesesuaian untuk tujuan tertentu dan pelanggaran. Dalam keadaan apa pun penulis atau pemegang hak cipta tidak bertanggung jawab atas klaim, kerusakan atau kewajiban lain, baik dalam tindakan kontrak, kesalahan atau lainnya, yang muncul dari, akibat, atau sehubungan dengan perangkat lunak atau pengguna atau masalah lain di software.
 
</p><p>Kebijakan Privasi
</p><p>CV. EGC dan Mitra tahu bahwa Anda peduli bagaimana informasi tentang Anda digunakan dan dibagikan, dan kami menghargai kepercayaan Anda bahwa kami akan memperlakukannya dengan hati-hati dan bijaksana. Kebijakan Privasi (Kebijakan) menjelaskan bagaimana CV. EGC menggunakan informasi yang kami kumpulkan ketika Anda menggunakan Aplikasi kami dan saat Anda menggunakan produk dan layanan kami (secara kolektif disebut Layanan). Dengan menggunakan Layanan, Anda menerima semua hal yang dijelaskan di sini. 

</p><p>Informasi yang Kami Kumpulkan
</p><p>CV. EGC mengumpulkan informasi dari pengguna, yang mungkin mencakup informasi pribadi ("Informasi Pribadi"), di berbagai titik di aplikasi kami dan melalui Layanan atau software sebagai berikut:
</p><p>Informasi yang Anda berikan melalui aplikasi, kemudian kami terima dan simpan informasi yang Anda masukkan di aplikasi atau beri kepada kami dengan cara lain. 
</p><p>Data registrasi ketika Anda mendaftar untuk layanan: Kami meminta Anda untuk memberikan informasi alamat email. 
</p><p>Urutan data ketika Anda memesan melalui layanan: Kami mengumpulkan pembelian dan cara pembayaran Anda yang atur oleh pihak ketiga penyedia jasa payment gateaway.
</p><p>Informasi sukarela: Kami dapat mengumpulkan informasi tambahan pada waktu lain, termasuk namun tidak terbatas pada, ketika Anda memberikan umpan balik, mengubah konten atau preferensi email, menanggapi survei, atau berkomunikasi dengan layanan pelanggan CV. EGC jika nantinya ada.
</p><p>Informasi yang dikumpulkan secara otomatis: Kami menerima dan menyimpan jenis informasi tertentu setiap kali Anda berinteraksi dengan kami melalui perangkat lunak. 
</p><p>Komputer dan perangkat konfigurasi, identifikasi, dan lokasi: Kami akan secara otomatis menerima dan mencatat  informasi dari gawai Anda, termasuk alamat IP Anda, nama dan ID dari komputer Anda, perangkat mobile dan perangkat lainnya, sistem operasi, jenis browser dan versi, kecepatan CPU, kecepatan koneksi, dan informasi lokasi berdasarkan pada IP address yang berasal dari GPS atau fitur serupa pada perangkat mobile Anda dan perangkat lainnya. 
</p><p>Instalasi perangkat lunak, download file, dan akses publikasi ketika Anda menginstal perangkat lunak: Kami dapat merekam setiap saat transfer file dimulai dan berakhir dan setiap kesalahan yang mengganggu transfer. 
</p><p>Informasi dari sumber lain: Kami dapat menerima informasi tentang Anda dari sumber lain, menambahkannya ke informasi akun kita dan memperlakukannya sesuai dengan kebijakan ini. 
</p><p>Pelanggan dan data pesanan dari mitra kami: Kami dapat menerima informasi tentang Anda dari sumber lain, menambahkannya ke informasi akun kita dan memperlakukannya sesuai dengan kebijakan ini.
</p><p>Pembaharuan dan pengiriman alamat: CV EGC dapat memperoleh informasi kontak yang diperbaharui dari pihak ketiga dalam rangka untuk memperbaiki catatan kami dan memenuhi pesanan Anda atau berkomunikasi dengan Anda. 
</p><p>Demografi dan informasi pembelian: CV. EGC dapat referensi sumber informasi demografis dan pembelian untuk menyediakan Anda dengan komunikasi dan promosi yang lebih bertarget. 
 

</p><p>Bagaimana Kami Menggunakan Informasi yang Kami Kumpulkan
</p><p>Memberikan publikasi dan produk lain yang Anda pesan atau dikirim kepada Anda. 
</p><p>Verifikasi akses ke konten yang aman dan informasi akun Anda. 
</p><p>Menentukan apakah Anda memenuhi persyaratan sistem minimum untuk penggunaan Layanan. 
</p><p>Memberikan Anda konten yang disesuaikan, petunjuk, pilihan pembaharuan dan promosi. 
</p><p>Melayani permintaan dukungan layanan pelanggan Anda. 
</p><p>Meminta Anda untuk berpartisipasi dalam survei tentang produk dan layanan kami. 
</p><p>Menawarkan upgrade Layanan. 
</p><p>Lebih memahami, secara anonim dan agregat, bagaimana Layanan sedang digunakan, termasuk lalu-lintas Web dan pola membaca, sehingga kami terus dapat meningkatkan layanan kami. 
 
</p><p>Perlindungan Situs dan Lain-lain
</p><p>Kami merilis akun dan Informasi Pribadi lainnya ketika kita percaya rilis sesuai untuk mematuhi hukum, untuk menegakkan atau menerapkan Ketentuan Layanan kami, Perjanjian Privasi, atau perjanjian lainnya, atau untuk melindungi hak, properti, atau keamanan Situs, pengguna kami, atau yang lainnya. Lihat di bawah untuk deskripsi praktik mengenai komunikasi e-mail pengguna kami dan cara memperbarui preferensi Anda sehubungan dengan e-mail seperti untuk komunikasi.
 
</p><p>Pihak Ketiga Terpercaya
</p><p>Dengan persetujuan Anda, CV. EGC akan membuat Informasi Pribadi (tidak termasuk informasi kartu kredit Anda) tersedia kepada pihak ketiga yang terpercaya yang menawarkan produk dan jasa yang CV. EGC pikir mungkin menarik bagi Anda sehingga Anda dapat menerima informasi atau peluang yang terkait dengan produk-produk dan jasa yang ada. 
 
</p><p>Dengan Persetujuan Anda:
</p><p>Selain seperti yang ditetapkan di atas, Anda akan menerima pemberitahuan sebelum kami berbagi Informasi Pribadi Anda dengan pihak ketiga, dan Anda akan memiliki kesempatan untuk memilih untuk tidak berbagi informasi pribadi Anda.
kami berhak untuk menggunakan dan mengungkapkan informasi anonim, termasuk informasi agregat berasal dari Informasi Pribadi, untuk menginformasikan mitra, dan pihak berkepentingan lainnya mengenai kebiasaan penggunaan atau karakteristik pengguna , dan untuk melayani bisnis serta tujuan lain.
 
</p><p>Komunikasi Email ke Pengguna Kami
</p><p>Kami tidak mengirim email yang tidak dikehendaki, tetapi kita mengirim komunikasi email kepada pengguna kami sehubungan dengan penyediaan Layanan. Berikut ini menguraikan jenis email yang kami kirimkan kepada pengguna kami dan pilihan yang Anda miliki sebagai penerima pesan.
  
</p><p>Pesan yang diperlukan untuk Layanan Akun Anda
</p><p>kami dapat mengirimkan pesan berikut: (a) bagi pengguna baru terdaftar, email selamat datang, (b) pesan konfirmasi setiap order yang Anda pesan, (c) pesan konfirmasi perubahan akun Anda, (d) pesan mengundang Anda untuk berpartisipasi dalam survei pelanggan, dan (e) pesan menginformasikan produk penting atau update jasa yang berhubungan dengan bisnis kami.
 
</p><p>Pesan Pemasaran tentang Publikasi yang Anda Terima
</p><p>Kami dapat mengirimkan pesan pemasaran yang terkait dengan Publikasi yang Anda terima termasuk, misalnya, pesan yang mendorong Anda untuk membeli salinan tunggal tambahan atau berlangganan Publikasi.
 
</p><p>Optional Pemasaran Pesan dari kami
</p><p>Pengguna terdaftar dapat juga kadang-kadang menerima informasi atau promosi khusus dari kami tentang Publikasi tambahan, produk atau jasa yang ada.
 

</p><p>Mengubah atau Menghapus Informasi Anda
</p><p>Jika suatu saat Anda ingin menutup akun Anda, kirim email kepada kami. Informasi Pribadi Anda akan dihapus dari database pengguna aktif kami dan akan dihapus, asalkan (a) Anda telah melunasi semua kewajiban pembayaran, merasa tak perlu untuk menyimpan informasi tersebut, dan (c) kita tidak berkewajiban untuk mempertahankan informasi tersebut. Perlu diketahui bahwa setiap langganan dapat dibatalkan tanpa pengembalian dana dan Anda harus mendaftar ulang untuk menggunakan Layanan.
 

</p><p>Pemberitahuan Perubahan
</p><p>Kapan saja, CV. EGC dapat merevisi Kebijakan ini. Jika perubahan pada Kebijakan ini secara langsung akan mempengaruhi bagaimana kita berbagi Informasi Pribadi Anda, kami akan memberitahu Anda dengan memasang pemberitahuan di aplikasi atau dengan mengirim email kepada Anda dan memberikan Anda kesempatan untuk memilih keluar dari perubahan tersebut.
 
 
</p><p>PERSYARATAN BERISI PERNYATAAN JAMINAN DAN KETENTUAN LAIN YANG MEMBATASI KEWAJIBAN KAMI. Harap baca syarat secara keseluruhan.
</p><p>1. Deskripsi Layanan
</p><p>Layanan ini dioperasikan oleh CV. EGC bekerja sama dengan Mitra kami, yang termasuk dengan layanan di antaranya mengunduh Aplikasi NANDA INDONESIA di Playstore, yang telah disediakan, mengakses Aplikasi NANDA INDONESIA, menggunakan Aplikasi NANDA INDONESIA untuk kepentingan pribadi, membeli layanan NANDA INDONESIA.

</p><p>2. Akun
</p><p>Bagian-bagian tertentu dari Layanan tersedia hanya untuk orang yang telah terdaftar dan memperoleh akses dari kami. Dengan mendaftar melalui Aplikasi kami, Anda menegaskan bahwa Anda paling tidak berusia 18 tahun. Anda tidak dapat menyediakan atau menggunakan password, alamat email, atau informasi lainnya dari orang lain sehubungan dengan Layanan. Anda setuju untuk memberikan informasi yang benar, akurat, informasi terkini dan lengkap tentang diri Anda dan untuk mempertahankan dan segera memperbarui informasi tersebut agar tetap benar, akurat, mutakhir, dan lengkap. Anda bertanggung jawab untuk menjaga kerahasiaan account dan password dan untuk membatasi akses ke komputer Anda, dan Anda setuju untuk menerima tanggung jawab untuk semua aktivitas yang terjadi dalam account Anda, termasuk pemilihan dan penggunaan semua konten dan layanan.
</p><p>3. Tindakan Pengguna
</p><p>Anda hanya dapat menggunakan Layanan untuk tujuan yang sah dan sesuai dengan ketentuan ini.  Kami berhak untuk menolak layanan, menghentikan account, atau membatalkan pesanan setiap saat atas kebijakan sendiri, termasuk, dan tanpa batasan, berdasarkan kegiatan pelanggan yang melanggar ketentuan atau hukum dan peraturan yang berlaku.

</p><p>4. Pengguna Internasional
</p><p>Layanan ini dikendalikan, dioperasikan, dan dikelola oleh CV EGC dan Mitra dari kantornya dan server yang terletak di Republik Indonesia. Jika Anda mengakses Layanan dari lokasi di luar Indonesia, Anda bertanggung jawab untuk mematuhi semua hukum setempat dan peraturan yang berlaku. Anda setuju bahwa Anda tidak akan menggunakan Layanan yang diakses  dengan cara yang dilarang oleh semua undang-undang atau peraturan yang berlaku di negara manapun.

</p><p>5. Kekayaan Intelektual
</p><p>Semua konten yang termasuk sebagai bagian dari layanan, seperti teks, grafis, logo, tombol ikon, gambar, serta kompilasi darinya adalah milik CV. EGC dan dilindungi oleh hukum Republik Indonesia, dan hukum internasional yang berlaku, termasuk tanpa batasan hak cipta dan undang-undang lain dan perjanjian yang melindungi kekayaan intelektual dan hak kepemilikan. Anda setuju untuk mengamati dan mematuhi semua hukum yang berlaku tersebut, dan tidak mengubah, mengaburkan atau menghapus setiap hak cipta dan pemberitahuan kepemilikan lainnya yang terkandung dalam konten tersebut. CV. EGC adalah pemilik tunggal dan copyright sah atas konten dari Aplikasi NANDA INDONESIA. CV. EGC sudah memiliki izin atas pembuatan Aplikasi NANDA INDONESIA.


</p><p>6. Modifikasi Layanan
</p><p>Kami berhak setiap saat dan dari waktu ke waktu untuk mengubah atau menghentikan, untuk sementara atau seterusnya, Layanan (atau bagiannya) dengan atau tanpa pemberitahuan. Anda setuju bahwa CV. EGC tidak bertanggung jawab kepada Anda atau kepada pihak ketiga manapun atas modifikasi, penangguhan, atau penghentian pemberian Layanan ini.

</p><p>7. Penolakan Atas Jaminan
</p><p>LAYANAN DAN SEMUA PUBLIKASI YANG DISEDIAKAN ADALAH "APA ADANYA" DAN "SEBAGAIMANA TERSEDIA". CV EGC DAN MITRA PENGEMBANG APLIKASI, DENGAN TEGAS MENOLAK SEMUA JAMINAN APAPUN, BAIK TERSURAT MAUPUN TERSIRAT, TERMASUK NAMUN TIDAK TERBATAS PADA JAMINAN TERSIRAT DIPERDAGANGKAN, KESESUAIAN UNTUK TUJUAN TERTENTU DAN NON-PELANGGARAN. TANPA MEMBATASI HAL TERSEBUT.
ANDA SEPENUHNYA BERTANGGUNG JAWAB UNTUK MEMPEROLEH DAN MEMPERTAHANKAN KONEKTIVITAS INTERNET TERPERCAYA. CV. EGC TIDAK BERTANGGUNG JAWAB ATAS KETIDAKMAMPUAN ANDA UNTUK DOWNLOAD ATAU MENGAKSES KONTEN.
MATERI DIUNDUH ATAU DIPEROLEH MELALUI PENGGUNAAN LAYANAN DILAKUKAN ATAS DAN RISIKO ANDA SENDIRI DAN ANDA AKAN BERTANGGUNG JAWAB ATAS SEGALA KERUSAKAN PADA SISTEM KOMPUTER ANDA ATAU HILANGNYA DATA DARI HASIL DOWNLOAD ATAU PENGGUNAAN BAHAN TERSEBUT.

</p><p>8. Penggantian Kerugian
</p><p>Anda setuju untuk membela, melindungi, dan menjamin CV. EGC dan pihak ketiga pengembang aplikasi dan masing-masing direksi, pejabat, karyawan dan agen dari dan terhadap semua klaim, kerugian, biaya, kerusakan dan biaya, termasuk biaya pengacara, yang timbul dari atau yang dihasilkan dari (a) penggunaan Layanan atau Publikasi, (b) pelanggaran dari ketentuan ini, atau (c) setiap kegiatan yang berhubungan dengan akun Anda (termasuk tindakan kelalaian atau kesalahan) oleh Anda atau lainnya orang yang mengakses Layanan atau Publikasi dengan menggunakan akun Anda.

</p><p>9. Pemantauan
</p><p>Kami mempertahankan hak, tetapi tidak berkewajiban, untuk memantau Layanan untuk menentukan sesuai dengan persyaratan dan aturan operasi apapun yang ditetapkan oleh kami, dan untuk memenuhi setiap hukum, peraturan atau permintaan pemerintah yang berwenang. Tanpa membatasi hal tersebut, kami mempertahankan hak untuk menghapus konten yang kami, atas kebijakan kami, temukan berada di melanggar perjanjian Ketentuan atau tidak pantas atau melanggar atau kewajiban privasinya.

</p><p>10. Penghentian
</p><p>CV. EGC atau Anda dapat mengakhiri Ketentuan kapan saja. Tanpa membatasi hal tersebut, kami bisa, atas kebijakan sendiri, menghentikan password Anda, atau penggunaan Layanan atas alasan apapun, termasuk, dan tanpa batasan, jika kami percaya bahwa Anda telah melanggar atau bertindak tidak konsisten dengan huruf atau isi dari Ketentuan ini. Setiap penghentian akses Anda ke Layanan sesuai ketentuan dalam Persyaratan dapat dilakukan tanpa pemberitahuan sebelumnya, dan kami segera menghentikan atau menghapus akun Anda dan semua informasi terkait dan/atau melarang setiap akses lebih lanjut ke Program Berkelanjutan
</p><p>Semua harga dan pajak Layanan program berbayar sesuai dengan apa yang tertera dan mengikuti syarat dan ketentukan yang berlaku di negara Indonesia

</p><p>12. Pemberitahuan Perubahan
</p><p>Dari waktu ke waktu, kami dapat merevisi Syarat untuk menjaganya agar tetap up to date dengan produk dan jasa kami. Akses Anda atau penggunaan Layanan setelah di-update akan menandakan persetujuan Anda untuk terikat oleh perubahan tersebut.
 
</p>
                </div>
                <!--div class="box-footer clearfix">
                  <div style="text-align:center">
                    <button id="btn_submitLogin" 
                      onclick="javascript: signIn('{/sqroot/header/info/account}')"
                      class="btn btn-orange-a">SUBMIT</button>&#160;
                    <button class="btn btn-gray-a" onclick="clearLoginText();">CLEAR</button>
					<div class="btn" id="gsignin" data-onsuccess="signInGConnect" data-theme="dark"></div>

                  </div>
                </div-->
              </div>
            </div>

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
