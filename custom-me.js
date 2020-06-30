setTimeout(function () { timeIsUp(); }, 1000 * 60 * 60);    //1 hour

function timeIsUp() {
    if (window.location.href.indexOf('mode=login') === -1 && loadThemeFolder()=='themeONE')
        window.location = 'index.aspx?env=acct&code=lockscreen';
}

function LoadNewPart(filename, id, code, nbpage) {

    var xsldoc = 'OPHContent/themes/themeOne/xslt/' + filename + '.xslt';
    var xmldoc = 'OPHCore/api/default.aspx?mode=browse&code=' + code + '&GUID=' + getGUID() + '&stateid=' + getState() + '&bPageNo=' + nbpage + '&bSearchText=' + getSearchText() + '&sqlFilter=' + getFilter() + '&sortOrder=' + getOrder() + unique;

    showXML(id, xmldoc, xsldoc, true, true, function () {
        if (typeof f === "function") f();
    });
}

function saveThemeONE(code, guid, location, formId, afterSuccess, beforeStart) {
    //location: browse:10, header form:20, browse anak:30, browse form:40, save&add form anak: 41

    saveFunction(code, guid, location, formId, function (data) {
        var msg = $(data).children().find("message").text();
        var retguid = $(data).children().find("guid").text();

        if (location === 40 || location === 41) {
            //var pkfield = document.getElementById("PKSAVE" + code).value;
            var pkvalue = document.getElementById("PK" + code).value;
            var parentkey = document.getElementById("PKID").value.split('child').join('');
            var pkey = $('#parent' + code).val();
            var childKey = $('#childKey' + code).val();
        }

        //insert new form
        if (retguid != "" && retguid != guid && location === 20) window.location = 'index.aspx?env=back&code=' + getCode() + '&guid=' + retguid;
        //insert child
        else if (retguid != "" && retguid != guid && location === 40) {
            //preview(1, code, guid, formId + code);
            if (msg != "") {
                showMessage(msg, 3);
            }
            loadChild(code, pkey, pkvalue, 1)
            preview('1', getCode(), getGUID(), '', this);
        }
        else if (retguid !== "" && retguid !== guid && location === 41) {
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
                showMessage(msg, 3);
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
            showMessage('Saving is successfully.', 2);
        }


        if (typeof afterSuccess === "function") afterSuccess(data);

    }, beforeStart)
}


function addpagenumber(pageid, currentpage, totalpages) {
    cp = parseInt(currentpage);
    tp = parseInt(totalpages);
    setCookie(getCode().toLowerCase()+'_TotalPages', tp, 1, 0, 0);
    var result = "";
    if (pageid!='') {
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
}

function childPageNo(pageid, code, currentpage, totalpages) {
    var result = "";
    var mode = '&quot;' + getCookie(code.toLowerCase() + '_browseMode') + '&quot;';
    var before = "";
    var after = "";
    var filter;
    try {
        filter = eval(code + '_parent');
    }
    catch (e) { }
    if (filter) {
        var d = filter.split('=');
        parentKey = '&quot;' + d[0] + '&quot;';
        guid = '&quot;' + d[1] + '&quot;';
    }
    else {
        var parentKey = '&quot;' + document.getElementById('PKName').value + '&quot;';
        //var parentKey = '&quot;' + String(code).substring(2, 6) + 'GUID&quot;';
        var guid = '&quot;' + getQueryVariable("GUID") + '&quot;';

    }

    setCookie(code.toLowerCase()+'_TotalPages', totalpages, 1, 0, 0);
    code = '&quot;' + code + '&quot;';
    

    if (currentpage != 1) result += "<li><a href='javascript:loadChild(" + code + "," + parentKey + "," + guid + "," + (parseInt(currentpage) - 1) + "," + mode + ")'>&#171;</a></li>";
    if (parseInt(currentpage) - 2 > 0)
        result += "<li><a href='javascript:loadChild(" + code + "," + parentKey + "," + guid + "," + (parseInt(currentpage) - 2) + "," + mode + ")'>" + (parseInt(currentpage) - 2) + "</a></li>";

    if (parseInt(currentpage) - 1 > 0)
        result += "<li><a href='javascript:loadChild(" + code + "," + parentKey + "," + guid + "," + (parseInt(currentpage) - 1) + "," + mode + ")'>" + (parseInt(currentpage) - 1) + "</a></li>";

    result += "<li><a style ='background-color:#3c8dbc;color:white;'href='javascript:loadChild(" + code + "," + parentKey + "," + guid + "," + currentpage + "," + mode + ")'>" + currentpage + "</a></li>";

    if (parseInt(currentpage) + 1 <= totalpages)
        result += "<li><a href='javascript:loadChild(" + code + "," + parentKey + "," + guid + "," + (parseInt(currentpage) + 1) + "," + mode + ")'>" + (parseInt(currentpage) + 1) + "</a></li>";
    if (parseInt(currentpage) + 2 <= totalpages)
        result += "<li><a href='javascript:loadChild(" + code + "," + parentKey + "," + guid + "," + (parseInt(currentpage) + 2) + "," + mode + ")'>" + (parseInt(currentpage) + 2) + "</a></li>";

    if (parseInt(currentpage) != totalpages) result += "<li><a href='javascript:loadChild(" + code + "," + parentKey + "," + guid + "," + (parseInt(currentpage) + 1) + "," + mode + ")'>&#187;</a></li>";

    result += "<li>&nbsp;&nbsp;&nbsp;</li>";

    var combo = "<li><select style ='background:#fafafa;color:#666;border:1px solid #ddd;height:30px;'onchange='loadChild(" + code + "," + parentKey + "," + guid + ",this.value)'>";
    for (var i = 1; i <= totalpages; i++) {
        combo += "<option value =" + i + " " + (currentpage == i ? "selected" : "") + ">" + i + "</option>";
    };

    combo += '</select></li>';

    result += combo;

    if (pageid!='') $('#' + pageid).html(result);

}

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
        var mdl = $('#notiModal');
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

function loadExtraButton(buttons, divn, location) {
    //location: 10=browse, 11: browse-summary, 20: form (master), 21: form (tab)
    var cval;
    if (buttons) {
        if (location == 10) {
            $('td.' + divn).each(function (i, td) {
                var a, bstate;
                buttons.forEach(function (v) {
                    var url = v.url;
					var cl = v.class;
                    var loc = v.location;
                    if (loc == undefined || loc.includes("10") == false) {
                        return
                    }
                    //check variable
                    //check if loc=location, then run below
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
								//find in content summary
								if (cval==null) cval = $(td).parent().next().find("[data-field='" + val + "']").html();
                            }

                            if (cval) {
                                url = url.split('%' + val + '%').join(cval);
                            }

                        });
                    }
                    //if (location==10 )
					uo = (v.updateOnly == 1) ? 1 : 0;
					uo = $(td).find("a:contains('"+v.caption+"')").length>0 ? 1 : uo;
					if (v.icon) uo = $(td).find('ix.'+v.icon.split(' ').join('.')).length>0 ? 1 : uo;
                    if (v.icon != null) {
                        a = "<a href=\"" + url + "\"><ix class='far " + v.icon + "' data-toggle=\"tooltip\" title='" + v.caption + "'/></a>";
					}
                    else {
                        a = "<a href=\"" + url + "\" title='" + v.caption + "'>" + v.caption + "</a>";
					}
                    //if (location==11 || location==20) a=' //button type="button" class="btn btn-danger btn-flat" onclick="javascript:submitTalk('{@GUID}', '10')">Send</button>'
                    
                    bstate = v.state;
                    if (bstate) {
                        bstate = bstate.split(' ').join('');
                        bstate = bstate.split(',');
                        for (var i = 0; i < bstate.length; i++) {
                            var gstate = (getState() == "" || getState() == undefined) ? "0" : getState();
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
        else if (location == 11) {
            $('div.' + divn).each(function (i, td) {
                var a, bstate;
                buttons.forEach(function (v) {
                    var url = v.url;
                    var loc = v.location;
                    if (loc == undefined || loc.includes("11") == false) {
                        return
                    }
                    //check variable
                    //check if loc=location, then run below
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
                    //if (v.icon != null)
                    a = '<button type="button" class="btn btn-orange-a ' + (location == 21 ? 'btn-block' : '') + ' btn-flat" onclick="' + url + '">' + v.caption + '</button>';
                    //else
                    //a = "<a href=\"" + url + "\">" + v.caption + "</a>";
                    uo = (v.updateOnly == 1) ? 1 : 0;
                    bstate = v.state;
                    if (bstate) {
                        bstate = bstate.split(' ').join('');
                        bstate = bstate.split(',');
                        for (var i = 0; i < bstate.length; i++) {
                            var gstate = (getState() == "" || getState() == undefined) ? "0" : getState();
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
        else if (location == 20) {
            $('div.' + divn).each(function (i, td) {
                var a, bstate;
                buttons.forEach(function (v) {
                    var url = v.url;
					var cl = v.class;
					if (cl==undefined) cl='btn-gray-a';
                    var loc = v.location;
                    var btnid = v.id;
                    if (loc == undefined || loc.includes("20") == false) {
                        return
                    }
                    //check variable
                    //check if loc=location, then run below
                    var arurl = url.match(/%+\w+(?:%)/g);
                    if (arurl != '' && arurl != null) {
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
                    //if (v.icon != null)
                    //a = '<span  id="' + v.id + '" ><button type="button" style="width:100%" class="btn btn-orange-a ' + (location == 21 ? 'btn-block ' : '') + 'btn-flat" onclick="' + url + '">' + v.caption + '</button></span>';
                    a = '<button class="btn '+cl+' btn-block" onclick="' + url + '">' + v.caption + '</button>';
                    a = a.replace('%rid%', getGUID())
                    //else
                    //a = "<a href=\"" + url + "\">" + v.caption + "</a>";

                    uo = (v.updateOnly == 1) ? 1 : 0;
                    bstate = v.state;
                    if (bstate) {
                        bstate = bstate.split(' ').join('');
                        bstate = bstate.split(',');
                        for (var i = 0; i < bstate.length; i++) {
                            var gstate = (getState() == "" || getState() == undefined) ? "0" : getState();
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
    }
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
		//$('#child_button_save').show();
        //$("#button_save").click();
		//$('#child_button_save').hide();
		saveThemeONE(getCode(), getGUID(), 20, ''); 

    }

}

function switchBrowse(mode, code) {
    if (mode == undefined) {
        mode = getCookie(code.toLowerCase()+'_browseMode');
        if (mode == undefined) mode = 0;

        $('.listMode').removeClass('active');
        $('.gridMode').removeClass('active');

        if (mode == 0) {
            $('.listMode').addClass('active');
            $('.gridContent').css('display', 'none');
            $('.listContent').css('display', 'block');
        }
        else {
            $('.gridMode').addClass('active');
            $('.listContent').css('display', 'none');
            $('.gridContent').css('display', 'block');

            var $grid = $('.grid').isotope({
                // options
                itemSelector: '.grid-item',
                layoutMode: 'fitRows'
            });

            // filter functions
            var filterFns = {
                // show if number is greater than 50
                numberGreaterThan50: function () {
                    var number = $(this).find('.number').text();
                    return parseInt(number, 10) > 50;
                },
                // show if name ends with -ium
                ium: function () {
                    var name = $(this).find('.name').text();
                    return name.match(/ium$/);
                }
            };

            // bind filter button click
            $('.controls').on('click', 'button', function () {
                var filterValue = $(this).attr('data-filter');
                // use filterFn if matches value
                filterValue = filterFns[filterValue] || filterValue;
                $grid.isotope({ filter: filterValue });
            });


            // change is-checked class on buttons
            $('.button-group').each(function (i, buttonGroup) {
                var $buttonGroup = $(buttonGroup);
                $buttonGroup.on('click', 'button', function () {
                    $buttonGroup.find('active').removeClass('active');
                    $(this).addClass('active');
                });
            });
        }
    }
    else {
        loadContent(1);
        setCookie(code.toLowerCase()+'_browseMode', mode, 0, 0, 15);
    }
}

function fillMobileItem(code, guid, status, allowedit, allowDelete, allowWipe, allowForce, isDelegator, smode) {
    mode = getCookie(code.toLowerCase()+'_browseMode');
    var accountid = 'maxfour';
    if (mode == 0 || mode == null) {
        var tx1 = '';
        $('td#mandatory' + guid).each(function (i, td) {
            tx1 += '<strong>' + $(td).data('title') + '</strong> ' + $(td).html() + ' &#183; ';
        })


        //var tx1 = $('td#mandatory' + guid).val();
        var tx2 = '' + tx1 + ' ' + ($('#summary' + guid).length==0?'':$('#summary' + guid).html());
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

        var btname = "VIEW";
        var fa = "eye";
        if (((allowedit == 1 && (status == 0 || status == 300))
            || (allowedit == 3 && (status < 400))
            || (allowedit == 4 && (status < 500))) && isDelegator == 0) {
            btname = "EDIT";
            fa = "pencil";
        }

        x = x.replace('#td#', bt.replace('#btname#', '<ix class="far ' + fa + '"></ix> ' + btname).replace('#abt#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'formView\', 1, 10)'));



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

        if (smode == 'T') {
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
        }
        x = x.replace('#td#', '');
        $(x).appendTo("#accordionBrowse");
    }
    else {
        var x = '<div class="grid-item cat2 cart3" style="margin: 5px; border: 1px solid #ccc; float: left; width:360px"><a target="_blank" href="ophcontent/documents/' + accountid + '/#d3#"><img src="ophcontent/documents/' + accountid + '/#d3#" style="width: 100%; height: auto;" width=400 height=400 alt="#d1#"></a><h4 class="name">#d1#</h4><p class="symbol">#d2#</p><p class="number">#d4#</p></div>';

        $('td#mandatory' + guid).each(function (i, td) {
            if (i == 0) x = x.split('#d1#').join($(td).html());
            if (i == 1) x = x.split('#d2#').join($(td).html());
            if (i == 2) x = x.split('#d3#').join($(td).html());
            if (i >= 3) x = x.split('#d4#').join('<strong>' + $(td).data('title') + '</strong>: ' + $(td).html() + '<p class="number">#d4#</p>');
        })
        x = x.split('<p class="number">#d4#</p>').join('');

        //if (isDelegator > 0) {
        //	var x = '<div class="grid-item cat2 cart3" ><a target="_blank" href="#d3#""><img src="#d3#" alt="#d1#" width="600" height="400"></a><h3 class="name">#d1#</h3><p class="symbol">#d2#</p><p class="number">#d3#</p><p class="weight">200.59</p></div>';
        //} else {
        //	isDelegator = 0;
        //	var x = '<div class="grid-item cat2 cart3" style="background:url(\'ophcontent/themes/themeone/images/oph4_logo.png\') no-repeat center #eee;"><h3 class="name">#d1#</h3><p class="symbol">#d2#</p><p class="number">#d3#</p><p class="weight">200.59</p></div>';
        //}		


        //x = x.replace('#d4#', tx4);

		/*
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

		var btname = "VIEW";
		var fa = "eye";
		if (((allowedit == 1 && (status == 0 || status == 300))
			|| (allowedit == 3 && (status < 400))
			|| (allowedit == 4 && (status < 500))) && isDelegator == 0)
		{
			btname = "EDIT";
			fa = "pencil";
		}

		x = x.replace('#td#', bt.replace('#btname#', '<ix class="far '+fa+'"></ix> ' + btname).replace('#abt#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'formView\', 1, 10)'));

		

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

		if (smode=='T') {
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
		}
		x = x.replace('#td#', '');
		*/

        $(x).appendTo(".grid");
    }

}

function showMessage(msg, mode, fokus, afterClosed, afterClick) {
    var msgType;
    if (mode==0 || mode == undefined) mode = 1;
    if (msg) {
        if (mode == 1) msgType = 'info';
        else if (mode == 2) msgType = 'success';
        else if (mode == 3) msgType = 'warning';
        else if (mode == 4) msgType = 'error';
        else if (mode == 10) msgType = 'confirm';

        if (msg === '' && (mode == 4 || mode == 3)) msg = 'Time out.';

        $("#notiTitle").text(msgType);
        $("#notiContent").text(msg);
        if (mode < 10) {
            //$('#modal-btn-close').show();
            //$('#modal-btn-cancel').hide();
            //$('#modal-btn-confirm').hide();
            //toastr[msgType](msgType, msg)
        }
        else {
            //$('#modal-btn-close').hide();
            //$('#modal-btn-cancel').show();
            //$('#modal-btn-confirm').attr('onclick', function () {
            //    afterClick();
            //}).show();

        }

        toastr.options = {
            "closeButton": true,
            "debug": false,
            "newestOnTop": false,
            "progressBar": false,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };
        toastr[msgType](msgType, msg);

        //$("#notiModal").modal();

        if (typeof afterClosed === "function") {
            $("#notiModal").on("hidden.bs.modal", function (e) {
                $("#notiModal").on("hidden.bs.modal", null);
                afterClosed();

            });
        }

        if (fokus || afterClosed) {
            try {
                document.getElementById('notiBtn').onclick = function () {
                    if (fokus) $(fokus).focus();
                    //if (typeof afterClosed === "function") afterClosed();
                };
            }
            catch (e) {
                //
            }
        }
    }
}


function popUpImg(guid) {
    var modal = document.getElementById('myImage_' + guid);

    var img = document.getElementById('img_' + guid);
    var modalImg = document.getElementById('img01_' + guid);
    var captionText = document.getElementById('caption_' + guid);

    modal.style.display = "block";
    modalImg.src = img.src;
    captionText.innerHTML = img.alt;
    preview('1', getCode(), getGUID(), '', this);
}

function rejectPopup(code, GUID, action, page, location, formId, afterSuccess) {
    $("#rejectModal").modal('show');
    $("#rejectModal").appendTo('body');
    
        //$("#nModal").modal('show');
        document.getElementById('rejectComment').onkeyup = function () {
            $('#rejectBtn').css('visibility', $('#rejectComment').val() !== '' ? 'visible' : 'hidden');
        };
    
        document.getElementById('rejectBtn').onclick = function () {
            var comment = $('#rejectComment').val();
            btn_function(code, GUID, action, page, location, formId, comment, afterSuccess);
        };
        
}


//SIDESHOW
function sideShowInit() {

    Sideshow.config.language = "oph";
    if (getMode() == 'export' || getMode() == 'report') {
        Sideshow.config.autoSkipIntro = true;
    }
    else {
        Sideshow.config.autoSkipIntro = false;
    }
    Sideshow.init();

}

function sideShowMaster(title, user) {
    //EXPORT BUTTON

    sideShowExportButton(title, user);
    //EXPORT PAGE
    sideShowExport(title, user);

    //BROWSE PAGE
    sideShowBrowse(title, user);

    //FORM PAGE
    sideShowFormNew(title, user);
    sideShowFormInfoM(title, user);
}
function sideShowTab(title, user, code) {
    //EXPORT BUTTON

    sideShowExportButton(title, user);
    //EXPORT PAGE
    sideShowExport(title, user);

    //BROWSE PAGE
    sideShowBrowse(title, user);

    //FORM PAGE
    sideShowFormNew(title, user);
    sideShowFormInfoT(title, user, code);
}
function sideShowExportButton(title, user) {
    Sideshow.registerWizard({
        name: "ss_exportData",
        title: "How to Use Export Data Button?",
        description: "We would like to help you how to use this export data button.",
        estimatedTime: "5 Minutes",
        affects: [
            function () {
                if ($('#btnExport').length == 1 && getMode() == 'browse')
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
                    function () {
                        return $('#uploadBox').data('clicked') > 0
                    }
                ],
                listeners: {
                    beforeStep: function () {
                        $('#btnExport').attr('onclick', "window.location='?code=" + getCode() + "&mode=export&help=1'")
                    }
                }
            }
        ]
    });
}

function sideShowExport(title, user) {
    Sideshow.registerWizard({
        name: "ss_exportPage",
        title: "Help Me to Use Export Page",
        description: "We would like to help you how to use this export page.",
        estimatedTime: "10 Minutes",
        affects: [
            function () {
                if (getMode() == 'export')
                    return true;
            }
        ]
    }).storyLine({
        showStepPosition: true,
        steps: [
            {
                title: "Welcome to Export Data \"" + title + "\"",
                text: "Hello \"" + user + "\", are you ready to go? Please click next then."
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
                    beforeStep: function () {
                        if ($('#exportNavTab').length == 1)
                            $('#exportNavTab').children('ul').children('li').eq(0).children('a').click();
                    }
                }
            },
            {
                title: "Input Data into File",
                text: "After the downloaded template is complete, you need to input data into that file and than save it. Before it file is ready to export.",
                listeners: {
                    afterStep: function () {
                        if ($('#exportNavTab').length == 0) Sideshow.gotoStep("expTemplate")
                    }
                }
            },
            {
                title: "Export Template",
                text: "In this tab you can export your downloaded template file.",
                subject: "#exportNavTab",
                lockSubject: true,
                listeners: {
                    beforeStep: function () {
                        if ($('#exportNavTab').length == 1)
                            $('#exportNavTab').children('ul').children('li').eq(1).children('a').click();
                    }
                }
            },
            {
                title: "Export Parameters",
                text: "Before you can export " + title + " template, you have to set this parameters. Each of parameter is always affected the result of your exported data. So, you better ask your administrator about the use of this parameters.",
                subject: "#formExport",
                targets: "#formExport input, #formExport select",
                lockSubject: true
            },
            {
                name: "expTemplate",
                title: "Export Template",
                text: "Now to exporting your data, you need to click this button then select the downloaded template file that located in your computer.",
                subject: "#btn_exp",
                lockSubject: true,
                listeners: {
                    beforeStep: function () {
                        if ($('#exportNavTab').length == 1)
                            $('#exportNavTab').children('ul').children('li').eq(1).children('a').click();
                    }
                }
            },
            {
                title: "Export Status",
                text: "You can see your export status here.",
                subject: "#exportStatus",
                lockSubject: true,
                skipIf: function () {
                    return $("#exportStatus").length == 0;
                },
            },
            {
                title: "Remember!",
                text: "Each time you want to use export mode, you have to always download a new template.",
                subject: "#btn_imp",
                targets: "#btn_imp",
                lockSubject: true,
                listeners: {
                    beforeStep: function () {
                        if ($('#exportNavTab').length == 1)
                            $('#exportNavTab').children('ul').children('li').eq(0).children('a').click();
                    }
                }
            },
            {
                title: "Finish",
                text: "That's all " + user + ", it's the end of my help guide. Thank you for let me help you. See you again :) ",
            }
        ]
    });
}
function sideShowBrowse(title, user) {
    Sideshow.registerWizard({
        name: "ss_browse",
        title: "Help Me to Use \"" + title + "\" Page",
        description: "We would like to help you how to use \"" + title + "\" page.",
        estimatedTime: "15 Minutes",
        affects: [
            function () {
                if (getMode() == 'browse')
                    return true;
            }
        ]
    }).storyLine({
        showStepPosition: true,
        steps: [
            {
                title: "Welcome to \"" + title + "\"",
                text: "Hello \"" + user + "\", welcome to \"" + title + "\". Please click next then."
            },
            {
                title: "Table Browse",
                text: "Here is your table browse. In this table browse you can see your data. Try scroll the page up adn down if you dont see the highlight.",
                subject: "#tblBrowse",
                lockSubject: true,
                skipIf: function () {
                    return $("#noData").length == 0;
                },
                listeners: {
                    afterStep: function () {
                        if ($("#noData").length == 1) Sideshow.gotoStep("statusFilter");
                    }
                }
            },
            {
                name: "tblBrowse",
                title: "Table Browse",
                text: "Here is your table browse. In this table browse you can see your data. Try scroll the page up adn down if you dont see the highlight.",
                subject: "#tblBrowse",
                lockSubject: true
            },
            {
                title: "Sorting The Data",
                text: "To sort your data, you can click it's field title except for Summary and Action fields. Try scroll the page up and down if you dont see the highlight.",
                subject: "#browseHead",
                targets: "td[onclick*='sort']",
                skipIf: function () {
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
                    function () {
                        return $("div[id^='brodeta']").is(':visible');
                    }
                ],
                skipIf: function () {
                    return $("td[id^='summary']").length == 0;
                }
            },
            {
                title: "Summary Content",
                text: "In this summary content box you can see the detail of summary content it self.",
                subject: "div[id^='brodeta']:visible",
                lockSubjects: true,
                skipIf: function () {
                    return $("div[id^='brodeta']:visible").length == 0;
                }
            },
            {
                title: "Action Button Inactive",
                text: "This button function is to make one of your data becomes incative",
                subject: "td[class^='browse-action-button']:eq(0)",
                lockSubject: true,
                targets: "a[href*='inactivate']:eq(0)",
                skipIf: function () {
                    return $("a[href*='inactivate']:eq(0)").length == 0;
                }
            },
            {
                title: "Action Button Edit",
                text: "This button function is to modify one of your data or you can just view what is the more detail that this data has.",
                subject: "td[class^='browse-action-button']:eq(0)",
                lockSubject: true,
                targets: "a[id^='edit']:eq(0)",
                skipIf: function () {
                    return $("a[id^='edit']:eq(0)").length == 0;
                }
            },
            {
                title: "Page Numbers",
                text: "This is the page number. You can switch between the page by clikcing the number you want.",
                subject: "#pagenumbers",
                lockSubject: true,
                skipIf: function () {
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
                    function () {
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
                listeners: {
                    afterStep: function () {
                        $("#statusFilter").parent().removeClass('open');
                        //$("#statusFilter").click(); //in tab
                    }
                }
            },
            {
                title: "Advanced Filters",
                subject: "#bfBox",
                text: "This is the Advanced Filter box, contain many specified data filter. Click the red marked arrow to open the box.",
                targets: "#statusContent",
                autoContinue: true, completingConditions: [
                    function () {
                        return $("#bfBox div.box-body").is(":visible")
                    }
                ],
                listeners: {
                    beforeStep: function () {
                        if ($('#bfBox').length == 0) Sideshow.gotoStep('newdoc')
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
                listeners: {
                    afterStep: function () {
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
                text: "That's all " + user + ", it's the end of my help guide. Thank you for let me help you. See you again :) ",
            }
        ]
    });
}
function sideShowFormNew(title, user) {
    Sideshow.registerWizard({
        name: "ss_newDoc",
        title: "How to Save a New " + title + " Document?",
        description: "We would like to help you to create or save this document.",
        estimatedTime: "5 Minutes",
        affects: [
            function () {
                if (getMode() == 'form' && getQueryVariable('GUID') == '00000000-0000-0000-0000-000000000000')
                    return true;
            }
        ]
    }).storyLine({
        showStepPosition: true,
        steps: [
            {
                title: "Welcome to \"" + title + "\" Form",
                text: "Hello \"" + user + "\", welcome to \"" + title + "\" form. If you ready for this tutorial, Please click next then."
            },
            {
                title: "Section",
                text: "This is called Section that contain form.",
                subject: "#section_1",
                skipIf: function () {
                    return $("#section_1").length == 0;
                }
            },
            {
                title: "Editable Field",
                text: "This is where you can fill any information that needed. This is optional.",
                subject: ".form-group.enabled-input:eq(0)",
                targets: ".form-group.enabled-input:eq(0) input:text:enabled:eq(0)",
                skipIf: function () {
                    return $(".form-group.enabled-input:eq(0)").length == 0;
                },
                listeners: {
                    beforeStep: function () {
                        $("span[id^='rfm']:eq(0)").hide();
                    },
                    afterStep: function () {
                        $("span[id^='rfm']:eq(0)").show();
                    }
                }
            },
            {
                title: "Required Field",
                text: 'This is where YOU HAVE to fill in. This field is required to be filled. Marked by red text("required field")',
                subject: ".form-group.enabled-input:has([id^='rfm']):eq(0)",
                targets: ".form-group.enabled-input:has([id^='rfm']):eq(0) input:text:enabled:eq(0), [id^='rfm']:eq(0)",
                skipIf: function () {
                    return $("span[id^='rfm']:eq(0)").length == 0;
                }
            },
            {
                title: "Not Editable Field",
                text: "This is the field which you can not edit. The box is bordered boldly",
                subject: ".form-group.disabled-input:eq(0)",
                targets: ".form-group.disabled-input:eq(0) input:text:disabled:eq(0)",
                skipIf: function () {
                    return $(".form-group.disabled-input:eq(0)").length == 0;
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
                text: "That's all " + user + ", it's the end of my help guide. Thank you for let me help you. See you again :) ",
            }
        ]
    });
}
function sideShowFormInfoM(title, user) {
    Sideshow.registerWizard({
        name: "ss_formInfo",
        title: "Tell me about " + title + " form",
        description: "We would like to tell you how to read information about this form.",
        estimatedTime: "5 Minutes",
        affects: [
            function () {
                if (getMode() == 'form' && isGuid(getQueryVariable('GUID')))
                    return true;
            }
        ]
    }).storyLine({
        showStepPosition: true,
        steps: [
            {
                title: "Welcome to \"" + title + "\" Form",
                text: "Hello \"" + user + "\", welcome to \"" + title + "\" form. If you ready for this tutorial, Please click next then."
            },
            {
                title: "Document Panel",
                text: "In this panel you can see your document No and document Ref No",
                subject: ".user-panel",
                targets: ".user-panel",
                lockSubject: true,
                skipIf: function () {
                    return $(".user-panel:visible").length == 0;
                }
            },
            {
                title: "Search Panel",
                text: "In this panel you can search something.",
                subject: "div:has(#searchBox):last()",
                targets: "div:has(#searchBox):last()",
                lockSubject: true,
                skipIf: function () {
                    return $("#searchBox").length == 0;
                }
            },
            {
                title: "Go To Panel",
                text: "In this panel you quick navigating between header and child.",
                subject: "#gotoPanel",
                targets: "#gotoPanel",
                lockSubject: true,
                skipIf: function () {
                    return $("#gotoPanel").length == 0;
                },
                listeners: {
                    beforeStep: function () {
                        if ($("#gotoPanel.active").length == 0)
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
                skipIf: function () {
                    return $("#docInfoPanel").length == 0;
                },
                listeners: {
                    beforeStep: function () {
                        if ($("#docInfoPanel.active").length == 0)
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
                skipIf: function () {
                    return $("#docTalkPanel").length == 0;
                },
                listeners: {
                    beforeStep: function () {
                        if ($("#docTalkPanel.active").length == 0)
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
                skipIf: function () {
                    return $("#aprvPanel").length == 0;
                },
                listeners: {
                    beforeStep: function () {
                        if ($("#aprvPanel.active").length == 0)
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
                skipIf: function () {
                    return $("#reportPanel").length == 0;
                },
                listeners: {
                    beforeStep: function () {
                        if ($("#reportPanel.active").length == 0)
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
                skipIf: function () {
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
                text: "That's all " + user + ", it's the end of my help guide. Thank you for let me help you. See you again :) ",
            }
        ]
    });
}
function sideShowFormInfoT(title, user, code) {
    Sideshow.registerWizard({
      name: "ss_formInfo",
      title: "Tell me about "+title+" form",
      description: "We would like to tell you how to read information about this form.",
      estimatedTime: "5 Minutes",
      affects: [
      function(){
      if (getMode() == 'form' && isGuid(getQueryVariable('GUID')))
      return true;
      }
      ]
      }).storyLine({
      showStepPosition: true,
      steps: [
      {
      title: "Welcome to \""+title+"\" Form",
      text: "Hello \""+user+"\", welcome to \""+title+"\" form. If you ready for this tutorial, Please click next then."
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
      text: "This is the header's child form tab that may need to be filled.",
      subject: "div.nav-tabs-custom",
      targets: "a[href^='#tab_"+code+"']",
      lockSubject: true,
      skipIf: function() {
      return $("a[href*='#tab_"+code+"']:eq(0)").length == 0;
      },
      listeners:{
      beforeStep: function() {
      if($("li.active:has(a[href*='#tab_"+code+"']:eq(0)):last").length == 0)
      $("a[href*='#tab_"+code+"']:eq(0)").click();
      }
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
      text: "That's all "+user+", it's the end of my help guide. Thank you for let me help you. See you again :) ",
      }
      ]
      });
 
}
function sideShowProfile(title, user) {
    Sideshow.registerWizard({
        name: "ss_profile",
        title: "Help Me to Use This Profile Page",
        description: "We would like to help you how to use this profile.",
        estimatedTime: "5 Minutes",
        affects: [
            function () {
                return true;
            }
        ]
    }).storyLine({
        showStepPosition: true,
        steps: [
            {
                title: "Welcome to Profile Page",
                text: "Hello \"" + user + "\", welcome to our profile page. Here, you can manage your account including photo profile, your biography, change password and delegation."
            },
            {
                title: "Photo Profile",
                text: "You can see your profile picture here. Now, try move your cursor inside the box.",
                target: "#uploadBox",
                subject: "#profileBox",
                format: "markdown",
                autoContinue: true,
                completingConditions: [
                    function () {
                        return $('#uploadBox').is(':visible');
                    }
                ]
            },
            {
                title: "Change Picture",
                text: "Did you see a button shown up? Yes, it is a button to change your profile picture. But, you can try it later ;)",
                subject: "#profileBox",
                lockSubject: true,
                format: "markdown",
                listeners: {
                    beforeStep: function () {
                        showUploadBox('uploadBox', 1);
                    }
                }
            },
            {
                title: 'All About "++',
                text: "This is your information box. I'll tell you how to change it later.",
                subject: "#aboutMeBox",
                format: "markdown"
            },
            {
                title: "Your Journal",
                text: "This is the list of your log activities for using this sites for a day.",
                subject: "#profileTabBox",
                targets: "#journal h3",
                lockSubject: true,
                format: "markdown",
                listeners: {
                    beforeStep: function () {
                        $("#profileTabBox").children('div').children('ul').children('li').eq(0).children('a').click();
                    }
                }
            },
            {
                title: "Your Profile",
                text: "Here you can edit or change your profile as you wish",
                subject: "#profileTabBox",
                lockSubject: true,
                targets: "#formProfile input",
                format: "markdown",
                listeners: {
                    beforeStep: function () {
                        $("#profileTabBox").children('div').children('ul').children('li').eq(1).children('a').click();
                    }
                }
            },
            {
                title: "Delegation",
                text: "Set Delegation is when you want to delegate your work to another user.",
                subject: "#profileTabBox",
                lockSubject: true,
                format: "markdown",
                listeners: {
                    beforeStep: function () {
                        $("#profileTabBox").children('div').children('ul').children('li').eq(2).children('a').click();
                    }
                }
            },
            {
                title: "Change Password",
                text: "You can change your account password here.",
                subject: "#profileTabBox",
                lockSubject: true,
                format: "markdown",
                listeners: {
                    beforeStep: function () {
                        $("#profileTabBox").children('div').children('ul').children('li').eq(3).children('a').click();
                    }
                }
            },
            {
                title: "Finish",
                text: "That's all " + user + ", it's the end of my help guide. Thank you for let me help you. See you again :) ",
            }
        ]
    });
}

function sideShowReport(title, user) {
    Sideshow.registerWizard({
        name: "ss_report",
        title: "Download a Report",
        description: "We would like to help you how to download \"Report "+title+"\".",
        estimatedTime: "5 Minutes",
        affects: [
            function () {
                return true;
            }
        ]
        }).storyLine({
            showStepPosition: false,
            steps: [
            {
                title: "Welcome to Report \""+title+"\"",
                text: "Hello \""+user+"\", are you ready to start download this report?"
            },
            {
                title: "Report Parameters",
                text: "Wait a second, before it you need to know about this \"Report Parameter\". This is the Report Parameters that used by this report, and each parameter will do a filter for the report. Go on try to make a change on parameter or you can go to the next step.",
                subject: "#reportParameter",
                skipIf: function () {
                    return $("#reportParameter").length == 0;
                }
            },
            {
                title: "Download Report",
                text: "This two button is generate different type of report just like its name. Now is the time to download your report.",
                subject: "#reportButton",
                targets: "#btnPDF #btnXLS",
                skipIf: function () {
                    if ($("#btnPDF").length == 0 || $("#btnXLS").length == 0) return true;
                    else return false;
                },
                listeners: {
                    afterStep: function () {
                        if ($("#btnPDF").length == 1 && $("#btnXLS").length == 1) Sideshow.gotoStep('finish');
                    }
                }
            },
            {
                title: "Download Report",
                    text: "Now is the time to download your PDF Report. Click \"Show PDF\" button to start downloading.",
                        subject: "#btnPDF",
                            skipIf: function() {
                                return $("#btnPDF").length == 0;
                            }
            },
            {
                title: "Download Report",
                    text: "Now is the time to download your Excel Report. Click \"Show XLS\" button to start downloading.",
                        subject: "#btnXLS",
                            format: "markdown",
                                skipIf: function() {
                                    return $("#btnXLS").length == 0;
                                }
            },
            {
                name: "finish",
                    title: "Finish",
                        text: "That's all "+user+", it's the end of my help guide. Thank you for let me help you. See you again :) ",
                      }
            ]
        });
}

