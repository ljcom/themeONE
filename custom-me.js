function LoadNewPart(filename, id, code, sqlfilter, searchText, bpageno, showpage, sortOrder) {
    if (filename == 'product') {
        filename = filename + '_' + getCookie('browsetype');
        bpageno = getCookie("bpageno");
        sortOrder = getCookie("sortOrder");
        showpage = getCookie("showpage");
    }

    if (bpageno == '' || bpageno == undefined) { bpageno = 1 }
    if (showpage == '' || showpage == undefined) { showpage = 21 }
    if (sortOrder == '' || sortOrder == undefined) { sortOrder = '' }
    var xsldoc = 'OPHContent/themes/themeTwo/xslt/' + filename + '.xslt';
    var xmldoc = 'OPHCore/api/?mode=browse' + '&code=' + code + '&sqlfilter=' + sqlfilter + '&bSearchText=' + searchText + '&bpageno=' + bpageno + '&showpage=' + showpage + '&sortOrder=' + sortOrder + '&date=' + getUnique();

    showXML(id, xmldoc, xsldoc, true, true, function () {
        if (typeof f == "function") f();
    });
}

function saveThemeONE(code, guid, location, formId) {
    //location: browse:10, header form:20, browse anak:30, browse form:40, save&add form anak: 41

    saveFunction(code, guid, location, formId, function (data) {
        var msg = $(data).children().find("message").text();
        var retguid = $(data).children().find("guid").text();

        if (location == 40 || location == 41) {
            //var pkfield = document.getElementById("PKSAVE" + code).value;
            var pkvalue = document.getElementById("PK" + code).value;
            var parentkey = document.getElementById("PKID").value.split('child').join('');
            var pkey = $('#parent' + code).val();
            var childKey = $('#childKey' + code).val();
        }

        //insert new form
        if (retguid != "" && retguid != guid && location == 20) window.location = 'index.aspx?env=back&code=' + getCode() + '&guid=' + retguid;
        //insert child
        else if (retguid != "" && retguid != guid && location == 40) {
            //preview(1, code, guid, formId + code);
            if (msg != "") {
                showMessage(msg);
            }
            loadChild(code, pkey, pkvalue, 1)
            preview('1', getCode(), getGUID(), '', this);
        }
        else if (retguid != "" && retguid != guid && location == 41) {
            //preview(1, code, guid, formId + code);
            $.when(loadChild(code, pkey, pkvalue, 1)).done(function () {
                $('#' + code + '00000000-0000-0000-0000-000000000000').hide();
                showChildForm(code, '00000000-0000-0000-0000-000000000000');
            });
        }
        else if (msg != "") {
            //compatible with load version

            if (isGuid(msg) && location == 20) {
                window.location = 'index.aspx?env=back&code=' + getCode() + '&guid=' + msg;
            }
            //compatible with load version
            else if (isGuid(msg) && location == 40) {
                preview(1, code, msg, formId + code);
                loadChild(code, pkey, pkvalue, 1);
            }
            else if (isGuid(msg) && location == 41) {
                //preview(1, code, guid, formId + code);
                $.when(loadChild(code, pkey, pkvalue, 1)).done(function () {
                    $('#' + code + '00000000-0000-0000-0000-000000000000').hide();
                    showChildForm(code, '00000000-0000-0000-0000-000000000000');
                });
            }
            else {
                showMessage(msg);
            }
        }
        else {
            if (location == 20) {
                saveConfirm();
            } else {
                if (location == 41) {
                    $.when(loadChild(code, pkey, pkvalue, 1)).done(function () {
                        $('#' + code + '00000000-0000-0000-0000-000000000000').hide();
                        showChildForm(code, '00000000-0000-0000-0000-000000000000');
                    });
                } else {
                    loadChild(code, pkey, pkvalue, 1);
                    preview('1', getCode(), getGUID(), '', this);
                }
            }
        }

    })
}

function fillMobileItem(code, guid, status, allowedit, allowDelete, allowWipe, allowForce, isDelegator) {
    var tx1 = '';
    $('td#mandatory' + guid).each(function (i, td) {
        tx1 += '<strong>' + $(td).data('title') + '</strong> ' + $(td).html() + ' &#183; ';
    })


    //var tx1 = $('td#mandatory' + guid).val();
    var tx2 = '' + tx1 + ' ' + $('#summary' + guid).html();
    var tx3 = '<b>WAIT FOR APPROVAL</b><br /><b>USER 3 </b>';
    var divname = 'collapse' + guid;

    if (isDelegator > 0) {
        var x = '<div class="panel box browse-phone" style="border:0;margin:0">#d1#</div>';
    } else {
        isDelegator = 0;
        var x = '<div class="panel box browse-phone" style="border:0;margin:0">#d1##d2#</div>';
    }

    x = x.replace('#d1#', '<div class="box-header with-border ellipsis">#h4#</div>');
    x = x.replace('#h4#', '<h4 class="box-title">#a#</h4>');
    x = x.replace('#a#', '<a data-toggle="collapse" data-parent="#accordionBrowse" href="#' + divname + '" style="color:black; text-transform: uppercase">#s##tx2#</a>');
    x = x.replace('#s#', '');
    x = x.replace('#tx2#', tx2);

    x = x.replace('#d2#', '<div id="' + divname + '" class="panel-collapse collapse">#d21#</div>');
    x = x.replace('#d21#', '<div class="box-body full-width-a" style="padding:0">#d212#</div>');

    //x = x.replace('#d211#', '<div class="browse-status" style="background:gray; color:white; padding:10px; position:relative;">#tx3##a2#</div>');
    //x = x.replace('#d211#', '<div class="browse-status" style="background:gray; color:white; padding:10px; position:relative;">#tx3#<a href="#a4#" title="edit" style="position:absolute; top:10px; right:10px; font-size:17px; color:white;">#ix#</a></div>');
    //x = x.replace('#tx3#', tx3);
    //x = x.replace('#a2#', '<a href="#" style="color:white; text-decoration:underline">see more</a><br /><br /><b>LAST COMMENT</b><br />WAIT FOR USER3<br /><br /><b>REQUESTED ON</b><br />ESRA MARTLIANTY (3 JAN 2016) <br /><a href="#a4#" title="edit" style="position:absolute; top:10px; right:10px; font-size:17px; color:white;">#ix#</a>');

    //x = x.replace('#d211#', '<a href="#a4#" title="edit" style="position:absolute; top:10px; right:10px; font-size:17px; color:white;">#ix#</a>');

    x = x.replace('#d212#', '<div style="text-align:center; display:block; background:gray; padding:10px 0;">#t#</div>');
    x = x.replace('#t#', '<table style="width:100%">#tr#</table>');
    x = x.replace('#tr#', '<tr><td>&#160;</td>#summary#<td>&#160;</td></tr><tr><td>&#160;</td>#td#<td>&#160;</td></tr>');

    var sum = '';
    $('div#approval-' + guid).each(function (i, div) {
        sum += 'Level ' + $(div).data('level') + '<strong>' + $(div).data('username') + '</strong> ' + $(div).data('approvaldate') + ' ' + ' &#183; ';
    })
    x = x.replace('#summary#', sum);

    bt = '<td width="1" style="padding:0 10px;">#bt#</td>#td#';
    bt = bt.replace('#bt#', '<button type="button" class="btn btn-gray-a" style="background:#ccc; border:none;" onclick="#abt#">#btname#</button>');

    var btname = "VIEW"
    if (((allowedit == 1 && (status == 0 || status == 300))
        || (allowedit == 3 && (status < 400))
        || (allowedit == 4 && (status < 500))) && isDelegator == 0) {
        btname = "EDIT";
        x = x.replace('#td#', bt.replace('#btname#', '<ix class="far fa-pencil"></ix> ' + btname).replace('#abt#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'formView\', 1, 10)'));    
    }
    else x = x.replace('#td#', bt.replace('#btname#', '<ix class="far fa-eye"></ix> ' + btname).replace('#abt#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'formView\', 1, 10)'));

    

    var btname = 'DELETE';
    var btfn = 'delete';
    if (((allowDelete == 1 && (status == 0 || status == 300))
        || (allowDelete == 3 && (status < 400))
        || (allowDelete == 4 && (status < 500))) && isDelegator == 0) {
        x = x.replace('#td#', bt.replace('#btname#', '<ix class="far fa-trash"></ix> ' + btname).replace('#abt#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'' + btfn + '\', 1, 10)'));
    }

    var btname = 'WIPE';
    var btfn = 'wipe';
    if (status == 999 && allowWipe == 1 && isDelegator == 0) {
        x = x.replace('#td#', bt.replace('#btname#', '<ix class="far fa-trash"></ix> ' + btname).replace('#abt#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'' + btfn + '\', 1, 10)'));
    }

    var btname = 'ARCHIEVE';
    var btfn = 'force';
    if (status < 500 && status >= 400 && allowForce == 1 && isDelegator == 0) {
        x = x.replace('#td#', bt.replace('#btname#', '<ix class="far fa-archive"></ix> ' + btname).replace('#abt#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'' + btfn + '\', 1, 10)'));
    }

    var btname = 'SUBMIT';
    var btfn = 'execute';
    if (status == 0 || status == 300) {
        x = x.replace('#td#', bt.replace('#btname#', '<ix class="far fa-check"></ix> ' + btname).replace('#abt#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'' + btfn + '\', 1, 10)'));
    }

    var btname = 'APPROVE';
    var btfn = 'execute';
    if (isDelegator == 0 && status > 0 && status < 200) {
        x = x.replace('#td#', bt.replace('#btname#', '<ix class="far fa-check"></ix> ' + btname).replace('#abt#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'' + btfn + '\', 1, 10)'));
    }

    var btname = 'REJECT';
    var btfn = 'force';
    if (isDelegator == 0 && status > 0 && status < 200) {
        x = x.replace('#td#', bt.replace('#btname#', '<ix class="far fa-check"></ix> ' + btname).replace('#abt#', 'javascript:rejectPopup(\'' + code + '\', \'' + guid + '\', \'' + btfn + '\', 1, 10)'));
    }

    x = x.replace('#td#', '');
    $(x).appendTo("#accordionBrowse");
}

function addpagenumber(pageid, currentpage, totalpages) {
    cp = parseInt(currentpage);
    tp = parseInt(totalpages);
    var result = "";
    if (tp > 1) {
        if (cp != 1) result += "<li><a href='javascript:loadContent(" + (cp - 1) + ")'>&#171;</a></li>";

        var before = "";
        var after = "";

        if (cp - 2 > 0)
            result += "<li><a href='javascript:loadContent(" + (cp - 2) + ")'>" + (cp - 2) + "</a></li>";

        if (cp - 1 > 0)
            result += "<li><a href='javascript:loadContent(" + (cp - 1) + ")'>" + (cp - 1) + "</a></li>";

        result += "<li><a style ='background-color:#3c8dbc;color:white;'href='javascript:loadContent(" + cp + ")'>" + cp + "</a></li>";

        if (cp + 1 <= tp)
            result += "<li><a href='javascript:loadContent(" + (cp + 1) + ")'>" + (cp + 1) + "</a></li>";
        if (cp + 2 <= tp)
            result += "<li><a href='javascript:loadContent(" + (cp + 2) + ")'>" + (cp + 2) + "</a></li>";

        if (cp != tp) result += "<li><a href='javascript:loadContent(" + (cp + 1) + ")'>&#187;</a></li>";

        result += "<li>&nbsp;&nbsp;&nbsp;</li>"


        var combo = "<li><select style ='background:#fafafa;color:#666;border:1px solid #ddd;height:30px;'onchange='loadContent(this.value)'>";
        for (var i = 1; i <= parseInt(tp); i++) {
            combo += "<option value =" + i + " " + (cp == i ? "selected" : "") + ">" + i + "</option>";
        };

        combo += '</select></li>';

        result += combo;


        $('#' + pageid).html(result);
    }
}

function timeIsUp() {
    //lastPar = window.location;
    //setCookie('lastPar', lastPar);
    //setCookie("userId", "", 0, 0, 0);
    window.location = 'index.aspx?env=acct&code=lockscreen';
}
setTimeout(function () { timeIsUp(); }, 1000 * 60 * 60);    //1 hour

function isGuid(stringToTest) {
    if (stringToTest[0] === "{") {
        stringToTest = stringToTest.substring(1, stringToTest.length - 1);
    }
    var regexGuid = /^(\{){0,1}[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}(\}){0,1}$/gi;
    return regexGuid.test(stringToTest);
}

function checkPassProfile(id) {
    var pass = (document.getElementById(id).value == undefined) ? "" : document.getElementById(id).value;

    if (pass != "") {
        var msg = "";
        if (pass.length < 6) {
            msg = "Minimum Password Requirement is 6 Characters!";
            document.getElementById("e" + id).style.display = "block";
            document.getElementById("e" + id).innerHTML = msg;

            document.getElementById("btn_pass").disabled = true;
        } else {
            if (id == "conPass") {
                var conPass = document.getElementById("newPass").value;
                msg = (pass == conPass) ? "" : "Password does not matches!";

                if (msg != "") {
                    document.getElementById("e" + id).style.display = "block";
                    document.getElementById("e" + id).innerHTML = msg;

                    document.getElementById("enewPass").style.display = "block";
                    document.getElementById("enewPass").innerHTML = msg;

                    document.getElementById("btn_pass").disabled = true;
                } else {
                    document.getElementById('e' + id).style.display = 'none';
                    document.getElementById('enewPass').style.display = 'none';
                }
            } else {
                document.getElementById('e' + id).style.display = 'none';
            }
        }
    } else if (id == "conPass" && document.getElementById("newPass").value != "" && pass == "") {
        msg = "You have to fill this!";
        document.getElementById("e" + id).style.display = "block";
        document.getElementById("e" + id).innerHTML = msg;
        document.getElementById("btn_pass").disabled = true;
    }
    else {
        document.getElementById('e' + id).style.display = 'none';
    }

    if (msg == "") {
        var curPass = document.getElementById('curPass').value;
        var newPass = document.getElementById('newPass').value;
        var conPass = document.getElementById('conPass').value;

        if (curPass != "" && newPass != "" && conPass != "") {
            document.getElementById("btn_pass").disabled = false;
        }
    }
}

function profileOnChange(id) {
    oldValue = $('#' + id).data('old');
    newValue = $('#' + id).val();

    if (oldValue != newValue) {
        $('#save_profile').removeAttr('disabled');
    } else {
        $('#save_profile').attr('disabled', 'disabled');
    }
}

function changePassProfile() {
    var curPass = document.getElementById('curPass').value;
    var newPass = document.getElementById('newPass').value;

    var urlPath = "OPHCore/api/default.aspx?code=profile&mode=changePassword&unique=" + getUnique();

    data = new FormData();
    data.append('curpass', curPass);
    data.append('newpass', newPass);

    $.ajax({
        url: urlPath,
        type: 'POST',
        data: data,
        cache: false,
        contentType: false,
        processData: false,
    }).done(function (data) {
        var msg = $(data).find('message').text();
        if (msg === '') {
            //alert("You have successfully change your password.");
            //location.reload();
            showMessage("You have successfully change your password", 2, undefined, function () {
                location.reload();
            });
        } else
            showMessage(msg);
    });
}

function saveProfile(formId, code, guid) {
    $('#save_profile').button('loading');
    var data = new FormData();
    if ($(':file').length > 0) {
        $.each($(':file')[0].files, function (key, value) {
            data.append(key, value);
        });
    }
    var thisForm = 'form';
    if (formId != undefined) thisForm = '#' + formId;

    var other_data = $(thisForm).serializeArray();
    $.each(other_data, function (key, input) {
        data.append(input.name, input.value);
    });

    $.ajax({
        type: "POST",
        url: "OPHCore/api/default.aspx?code=" + code + "&mode=saveProfile&cfunctionlist=" + guid + "&",
        enctype: 'multipart/form-data',
        cache: false,
        contentType: false,
        processData: false,
        data: data,
        success: function () {
        }
    }).done(function (data) {
        var msg = $(data).find('messages').text();
        var mdl = $('#allModal');
        $('#modal-btn-close').show();
        $('#modal-btn-cancel').hide();
        $('#modal-btn-confirm').hide();
        if (msg == '') {
            mdl.find('.modal-title').text("Success!");
            mdl.find('.modal-body').text("Profile was updating successfully !");
            $('#save_profile').text($('#save_profile').data('text'));
            $('#save_profile').removeClass().addClass('btn btn-success');
        } else {
            mdl.find('.modal-title').text("Failure!");
            mdl.find('.modal-body').text(msg);
            $('#save_profile').button('reset');
        }
        mdl.modal('show');
    });
}

function showUploadBox(divID, act) {
    if (act == 1) $('#' + divID).show();
    else $('#' + divID).hide();
}

function uploadBox(id, formId, code, guid) {

    //browse a file
    $('#' + id + "_file").click();

    // We can attach the `fileselect` event to all file inputs on the page
    $(document).on('change', ':file', function () {
        var input = $('#' + id + "_file"),
            numFiles = input.get(0).files ? input.get(0).files.length : 1,
            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        input.trigger('fileselect', [numFiles, label]);

        var file = this.files[0];
        if (file.size > 2000000) {
            alert('Maximum file size is 2 Mb')
        }
    });

    // We can watch for our custom `fileselect` event like this
    $(document).ready(function () {
        $(':file').on('fileselect', function (event, numFiles, label) {

            var input = $('#' + id + "_file").parents('.input-group').find(':text'),
                //log = numFiles > 1 ? numFiles + ' files selected' : label;
                log = label;
            if (input.length) {
                input.val(log);
            } else {
                //if( log ) alert(log);
                if (log) {
                    document.getElementById(id).value = log;
                    saveProfile(formId, code, guid);
                }
            }
        });
    });

}

function showModal(ini, action, formId, childID, guid) {
    var idmodal = $(ini).data('target');
    idmodal = (idmodal.indexOf('#') < 0) ? "#" + idmodal : idmodal;
    var title = $(ini).data('caption');
    var msg = $(ini).data('msg');
    var md = $(idmodal);
    md.find('.modal-title').text(title);
    md.find('.modal-body').text(msg);
    var clickact = ""
    if (action == "delete") {
        clickact = "deleteUserdele('" + childID + "', '" + idmodal + "', '" + guid + "')";
    } else if (action == "save") {
        clickact = "saveUserdele('" + formId + "', '" + childID + "', '" + idmodal + "', '" + guid + "')";
    }
    $('#modal-btn-close').hide();
    $('#modal-btn-cancel').show();
    $('#modal-btn-confirm').attr('onclick', clickact).show();
    md.modal({ backdrop: "static" });
}

function tokenizer(name, tokenID) {
    var url = 'OPHCore/api/msg_autosuggest.aspx?mode=token&code=userdele&colkey=' + name
    $("#" + name + tokenID).tokenInput(url, {
        hintText: "please type...", searchingText: "Searching...", preventDuplicates: true, allowCustomEntry: false, highlightDuplicates: false,
        tokenDelimiter: "*", theme: "facebook", prePopulate: "", onAdd: function (x) { checkToken(name + tokenID); }, onDelete: function (x) { checkToken(name + tokenID); }
    });
}

function addNewDele(ini) {
    var leChild = document.getElementById("deleparent").lastElementChild;
    var leChildID = leChild.id.split("delechild").pop();
    var newID = parseInt(leChildID) + 1;
    var divParent = document.getElementById("deleparent");
    var divChild = document.getElementById("delechild0");
    var addChild = document.importNode(divChild, true)
    addChild.innerHTML = addChild.innerHTML.split("delechild0").join("delechild" + newID);
    addChild.innerHTML = addChild.innerHTML.split("formDelegate0").join("formDelegate" + newID);
    addChild.innerHTML = addChild.innerHTML.split("guid0").join("guid" + newID);
    addChild.innerHTML = addChild.innerHTML.split("GUID0").join("GUID" + newID);
    addChild.innerHTML = addChild.innerHTML.split("TokenDelegate0").join("TokenDelegate" + newID);
    addChild.innerHTML = addChild.innerHTML.split("TokenModule0").join("TokenModule" + newID);
    addChild.innerHTML = addChild.innerHTML.split("btn-del0").join("btn-del" + newID);
    addChild.innerHTML = addChild.innerHTML.split("btn-save0").join("btn-save" + newID);
    addChild.id = "delechild" + newID;
    addChild.removeAttribute("style");
    addChild.setAttribute("data-new", "true");
    divParent.appendChild(addChild);
    $("#addele").attr("disabled", "disabled");
    tokenizer("TokenDelegate", newID);
    tokenizer("TokenModule", newID);
}

function checkToken(idToken) {
    var oldValue = $('#' + idToken).data('old-value');
    var newValue = $('#' + idToken).val();
    var indID = "", otherValue = "";

    //attention!! This "indexOf" is case-sensitive
    if (idToken.indexOf('TokenDelegate') >= 0) {
        indID = idToken.split('TokenDelegate').pop();
        otherValue = $('#TokenModule' + indID).val();
    } else {
        indID = idToken.split('TokenModule').pop();
        otherValue = $('#TokenDelegate' + indID).val();
    }

    if (newValue != "") {
        if (newValue != oldValue && otherValue != "") {
            $('#btn-save' + indID).removeAttr('disabled');
        } else if (newValue != oldValue && otherValue == "") {
            $('#btn-save' + indID).attr('disabled', 'disabled');
        }
    } else {
        $('#btn-save' + indID).attr('disabled', 'disabled');
    }
}

function deleteUserdele(childID, modalID, guid) {

    var isNew = $('#' + childID).data('new');

    if (isNew != undefined) {
        //removing child
        var item = document.getElementById(childID);
        item.parentNode.removeChild(item);

        var leChild = document.getElementById("deleparent").lastElementChild;
        var maxID = leChild.id.split("delechild").pop();
        var isContinue = true;
        for (var i = 1; i < maxID; i++) {
            if ($("#btn-save" + i).attr("disabled") == undefined) {
                isContinue = false;
                break;
            }
        }
        var dataNew = $('#' + leChild.id).data('new');
        if (isContinue == true && dataNew == undefined) $('#addele').removeAttr('disabled');
        $(modalID).modal('hide');
    } else {
        var url = "OPHCore/api/default.aspx?code=userdele&mode=function&cfunction=delete&cfunctionlist=" + guid + '&comment&unique=' + getUnique();
        var deleting = $.post(url);
        $('#modal-btn-confirm').button('loading');
        $('#modal-btn-cancel').hide();
        deleting.done(function (data) {
            var msg = $(data).find('message').text();
            var mdl = $(modalID);

            if (msg == "" || msg == undefined || isGuid(msg) == true) {
                mdl.find('.modal-title').text("Success!");
                mdl.find('.modal-body').text("Entry was deleting successfully !");
                $('#modal-btn-close').show();
                $('#modal-btn-cancel').hide();
                $('#modal-btn-confirm').hide();

                //removing child
                var item = document.getElementById(childID);
                item.parentNode.removeChild(item);

                var leChild = document.getElementById("deleparent").lastElementChild;
                var maxID = leChild.id.split("delechild").pop();
                var isContinue = true;
                for (var i = 1; i < maxID; i++) {
                    if ($("#btn-save" + i).attr("disabled") == undefined) {
                        isContinue = false;
                        break;
                    }
                }
                var dataNew = $('#' + leChild.id).data('new');
                if (isContinue == true && dataNew == undefined) $('#addele').removeAttr('disabled');
                $('#modal-btn-confirm').button('reset');
            } else {
                md.find('.modal-title').text("Error!");
                md.find('.modal-body').text(msg);
                $('#modal-btn-close').show();
                $('#modal-btn-cancel').hide();
                $('#modal-btn-confirm').hide();
                $('#modal-btn-confirm').button('reset');
            }
        });
    }
}

function saveUserdele(formId, childID, modalID, guid) {
    $('#modal-btn-confirm').button('loading');
    $('#modal-btn-cancel').hide();

    var popID = childID.split("delechild").pop();
    var other_data = $('#' + formId).serializeArray();

    var data = new FormData();
    $.each(other_data, function (key, input) {
        data.append(input.name.split(popID).join(""), input.value);
    });

    var savePost = $.post({
        url: "OPHCore/api/default.aspx?code=userdele&mode=save&cfunctionlist=" + guid,
        enctype: 'multipart/form-data',
        cache: false,
        contentType: false,
        processData: false,
        data: data
    });
    savePost.done(function (data) {
        var msg = $(data).find('message').text();
        var mdl = $(modalID);

        if (msg == "" || msg == undefined || isGuid(msg) == true) {
            mdl.find('.modal-title').text("Success!");
            mdl.find('.modal-body').text("Entry was saving successfully !");
            $('#modal-btn-close').show();
            $('#modal-btn-cancel').hide();
            $('#modal-btn-confirm').hide();

            $('#btn-save' + popID).attr("disabled", "disabled");
            $('#' + childID).removeAttr("data-new");
            $('#' + childID).removeData("new");

            var leChild = document.getElementById("deleparent").lastElementChild;
            var maxID = leChild.id.split("delechild").pop();
            var isContinue = true;
            for (var i = 1; i < maxID; i++) {
                if ($("#btn-save" + i).attr("disabled") == undefined) {
                    isContinue = false;
                    break;
                }
            }
            var dataNew = $('#' + leChild.id).data('new');
            if (isContinue == true && dataNew == undefined) $('#addele').removeAttr('disabled');
            $('#modal-btn-confirm').button('reset');
        } else {
            md.find('.modal-title').text("Error!");
            md.find('.modal-body').text(msg);
            $('#modal-btn-close').show();
            $('#modal-btn-cancel').hide();
            $('#modal-btn-confirm').hide();
            $('#modal-btn-confirm').button('reset');
        }
    });
}

function select2editForm(ini) {
    var guid = $(ini).val();
    var id = $(ini).attr('id');
    var edit = '<span style= "cursor:pointer;float:right" data-toggle="modal" data-target="#addNew' + id + '" data-backdrop="static" ></span >'
    if (isGuid(guid)) {
        var divSpan = document.getElementById(id);
        $('#select2-' + id + '-container').append(edit);
        $('#select2-' + id + '-container').children().append('<ix class="far fa-pencil" title= "Edit" ></ix >');
    }
}

function changeSkinColor() {
    var bodyClass
    if (getCookie('skinColor') != '')
        bodyClass = getCookie('skinColor')
    else
        bodyClass = 'skin-blue';
    $('body').addClass(bodyClass);
}

function loadExtraButton(buttons, location) {
    var cval;
    $('td.' + location).each(function (i, td) {
        var a, bstate;
        buttons.forEach(function (v) {
            var url = v.url;
            //check variable
            var arurl = url.match(/%+\w+(?:%)/g);
            if (arurl) {
                arurl.forEach(function (val) {
                    val = val.split('%').join('');

                    if (val == 'guid') {
                        cval = $(td).parent().data(val);
                    }
                    else if (val == 'rid') {
                        cval = $(td).parent().data("guid");
                    }
                    else {
                        cval = $(td).parent().find("[data-field='" + val + "']").html();
                    }

                    if (cval) {
                        url = url.split('%' + val + '%').join(cval);
                    }

                });
            }
            a = "<a href=\"" + url + "\"><ix class='far " + v.icon + "' data-toggle=\"tooltip\" title='" + v.caption + "'/></a>";
            uo = (v.updateOnly == 1) ? 1 : 0;
            bstate = v.state;
            if (bstate) {
                bstate = bstate.split(' ').join('');
                bstate = bstate.split(',');
                for (var i = 0; i < bstate.length; i++) {
                    var gstate = (getState() == "") ? "0" : getState();
                    if (gstate == bstate[i]) {
                        if ($(td).find("a").find("." + v.icon).length > 0)
                            $(td).find("a").find("." + v.icon).parent().attr("href", url);
                        else
                            if (uo == 0) $(td).append(a);
                        return;
                    }
                }
            } else {
                if ($(td).find("a").find("." + v.icon).length > 0)
                    $(td).find("a").find("." + v.icon).parent().attr("href", url);
                else
                    if (uo == 0) $(td).append(a);
            }
        });
    });

}

//checkbox pinned
function checkedBox(ini) {
    var cbID = ini.id;

    if (cbID == 'pinnedAll') {
        $('input:checkbox').not(ini).prop('checked', ini.checked);

        if (ini.checked && $("input:checked").not(ini).length > 0) {
            $("#actionHeader span").hide();
            $("#actionHeader div").show();
        } else {
            $("#actionHeader span").show();
            $("#actionHeader div").hide();
        }
    } else {
        var odd = $(ini).parents(".odd-tr");
        var even = $(odd).next();

        if (ini.checked) {
            $("#actionHeader span").hide();
            $("#actionHeader div").show();

            if ($("input:checkbox").not("#pinnedAll").length == $("input:checked").not("#pinnedAll").length)
                $("#pinnedAll").prop('checked', 'checked');
        }
        else {
            if ($("input:checked").not("#pinnedAll").length != $("input:checkbox").not("#pinnedAll").length)
                $("#pinnedAll").prop('checked', false);
        }

        if ($("input:checked").not("#pinnedAll").length == 0) {
            $("#actionHeader span").show();
            $("#actionHeader div").hide();
        }
    }
}

function btnWebcam(mode, idimg) {
    if (mode === 'opencamera') {
        Webcam.set({
            width: 270,
            height: 200,
            image_format: 'jpeg',
            jpeg_quality: 90
        });
        Webcam.attach('#' + idimg + '_camera');

        $('#' + idimg + '_camera').width('100%');

        $('#' + idimg + '_camera').find('video').width('100%');
        $("#opencamera").hide();
        $("#takesnapshot").show();
    }
    else if (mode == 'takesnap') {
        Webcam.freeze();

        $("#savephoto").show();
        $("#takeanother").show();
        $("#takesnapshot").hide();
    } else if (mode == 'takeanother') {
        Webcam.unfreeze();

        $("#savephoto").hide();
        $("#takeanother").hide();
        $("#takesnapshot").show();
    } else if (mode == 'savephoto') {
        Webcam.snap(function (data_uri) {
            // display results in page
            document.getElementById(idimg + '_hidden').innerHTML =
                '<img id="' + idimg + '_image" src="' + data_uri + '"/>';

        });
        $('#' + idimg + '_camera').html($('#' + idimg + '_hidden').html());
        $("#savephoto").hide();
        $("#takeanother").hide();
        $("#opencamera").show();

        $("#" + idimg).val($('#' + idimg + '_image').attr('src'));
        $("#button_save").click();

    }

}