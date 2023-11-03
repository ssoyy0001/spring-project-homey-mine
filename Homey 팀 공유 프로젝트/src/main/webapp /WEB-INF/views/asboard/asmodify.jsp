<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ include file="../includes/header.jsp" %>

<!--======= main ======= --> <main id="main"> <!-- ======= Breadcrumbs ======= --> <div class="breadcrumbs d-flex align-items-center" style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');"> <div class="container position-relative d-flex flex-column align-items-center" data-aos="fade"> <h2>AS 문의 수정</h2> </div> </div> <!-- End Breadcrumbs -->
<div class="row justify-content-center">
    <div class="col-lg-12 text-center">
        <h1 class="page-header"></h1>
    </div>
</div>
<div class="row justify-content-center">
    <div class="col-lg-6">
        <div class="panel panel-default">
            <div class="panel-heading"></div>
            <div class="panel-body">
             <form action="/asboard/asmodify" method="post" role="form" enctype="multipart/form-data">
<div class="form-group" style="border: 1px solid #000; background-color: #f2f2f2; padding: 10px;">
    <label for="title">제목:</label>
    <input type="text" id="title" name="title" value="${asBoardVO.title}" required/>
    <table style="width: 100%;">
        <tr>
            <td style="width: 10%;">
                <strong>작성자:</strong>
                <input type="text" name="mid" value="${asBoardVO.mid}" readonly/>
            </td>
        <td style="width: 10%;">
<strong>작성일:</strong>
<input type="text" name="regDate" value="<fmt:formatDate value="${asBoardVO.regDate}" pattern="yyyy-MM-dd"/>"disabled>

</td>
 <c:if test="${asBoardVO.regDate != asBoardVO.updateDate}">
    <td style="width: 10%;"><strong>수정일:</strong> <fmt:formatDate value="${asBoardVO.updateDate}" pattern="yyyy-MM-dd (E)"/></td>
</c:if>
    <strong>처리상황:</strong>
    <sec:authorize access="hasRole('ROLE_ADMIN')">
        <!-- 관리자인 경우 -->
        <select name="status">
            <option value="답변 대기중" ${asBoardVO.status == '답변 대기중' ? 'selected' : ''}>답변 대기중</option>
            <option value="답변 완료" ${asBoardVO.status == '답변 완료' ? 'selected' : ''}>답변 완료</option>
        </select>
    </sec:authorize>
    <sec:authorize access="!hasRole('ROLE_ADMIN')">
        <!-- 관리자가 아닌 경우 -->
        <p>${asBoardVO.status}</p>
    </sec:authorize>
</td>


        </tr>
    </table>
</div>
                    <div class="form-group" style="border: 1px solid #000; background-color: #f2f2f2; padding: 20px; margin-bottom: 20px;">
    <div class="row">
        <div class="col-lg-6">
            <!-- 첨부 파일 -->
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading"></div>
                        <div class="panel-body">
                            <!-- 첨부파일 등록 부분 시작 -->
                            <div class="form-group uploadDiv">
                                <input type="file" name="uploadFile" multiple>
                                <!-- 미리보기 이미지 추가 -->
                            </div>
                            <div class="uploadResult">
                                <ul></ul>
                            </div>
                            <!-- 첨부파일 등록 부분 끝 -->
                            <div class="originImgDiv">
                                <div class="originImg"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <label for="newContent">내용:</label>
            <textarea id="newContent" name="content" class="form-control" rows="8">${asBoardVO.content}</textarea>
        </div>
    </div>
</div>

                       
                    
                 <% if (request.isUserInRole("ROLE_ADMIN")) { %>
    <fieldset style="display: ;">
        <legend>답변 정보</legend>
        <table style="width: 100%;">
            <tr>
                <input type="text" name="replyRegDate" value="<fmt:formatDate value="${asBoardVO.replyRegDate}" pattern="yyyy-MM-dd"/>" disabled>
            </tr>
        </table>
        <div class="form-group">
    <div style="border: 1px solid #ccc; padding: 10px; margin-bottom: 200px;">
        <textarea name="replyContent" style="width: 100%; height: 300px;">${asBoardVO.replyContent}</textarea>
    </div>
</div>

    </fieldset>
<% } %>

                    <!-- 로그인한 사용자가 작성한 글 - 수정/삭제 버튼표시 -->
                    <div class="form-group">
                        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                        <input type="hidden" name="bno" value="${asBoardVO.bno}">
                        <div class="text-center" id="btn-group">
                            <button type="submit" class="btn btn-warning">수정하기</button>
							<a href="/asboard/redirect" class="btn btn-primary">목록으로</a>
                        </div>
                    </div>
                </form>
          
</main>
<script>
    var frm = $('form[role="form"]');
    var bnoVal = '${asBoardVO.bno}';

    (function() {
        $.getJSON('/asboard/attachList', { bno: bnoVal }, function(result) {
            console.log(result);
            showUploadedFile(result);
        });
    })();

    $('button[type="submit"]').on('click', function(e){
        e.preventDefault();

        var title = $('input[name="title"]').val();
        var content = $('textarea[name="content"]').val();

        // 제목이나 내용이 비어 있는지 확인
        if (!title || !content) {
            alert('제목과 내용을 입력해주세요.');
            return;
        }
        var hiddenTag = '';
        $('.uploadResult ul li').each(function(i, obj){
            hiddenTag += '<input type="hidden" name="attachList[' + i + '].uuid" value="' + $(obj).data('uuid') + '">';
            hiddenTag += '<input type="hidden" name="attachList[' + i + '].upFolder" value="' + $(obj).data('folder') + '">';
            hiddenTag += '<input type="hidden" name="attachList[' + i + '].fileName" value="' + $(obj).data('filenm') + '">';
            hiddenTag += '<input type="hidden" name="attachList[' + i + '].image" value="' + $(obj).data('image') + '">';
        });
        frm.append(hiddenTag);
        frm.submit();
    });

    var regEx = new RegExp("(.*?)\.(exe|sh|zip)$");
    var maxSize = 5242880;
    function checkExtension(fileName, fileSize) {
        if (fileSize > maxSize) {
            alert("파일 크기(5MB)가 초과하여 업로드 할 수 없습니다.");
            return false;
        }
        if (regEx.test(fileName)) {
            alert("해당 형식의 파일은 업로드 할 수 없습니다.");
            return false;
        }
        return true;
    }

    var csrfHeaderName = '${_csrf.headerName}';
    var csrfTokenValue = '${_csrf.token}';

    $('input[type="file"]').on('change', function() {
        var formData = new FormData();
        var files = $('input[name="uploadFile"]')[0].files;

        for (var i = 0; i < files.length; i++) {
            if (!checkExtension(files[i].name, files[i].size)) {
                return false;
            } else {
                formData.append('uploadFile', files[i]);
            }
        }

        $.ajax({
            type : 'post',
            url : '/asupload/ajaxAction',
            data : formData,
            dataType : 'json',
            contentType : false,
            processData : false,
            beforeSend : function(xhr){
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            success : function(result, status, xhr) {
                console.log(result);
                $('input[type="file"]').val("");
                showUploadedFile(result);
            },
            error : function(xhr, status, er) {
                console.log("upload error");
            }
        });
    });

    var resultUL = $('.uploadResult ul');
    function showUploadedFile(result){
        var liTag = '';
        $(result).each(function(i, obj){
            liTag += '<li data-uuid="' + obj.uuid + '" data-folder="' + obj.upFolder + '" data-filenm="' + obj.fileName + '" data-image="' + obj.image + '">';
            if(obj.image){
                var thumbImg = encodeURIComponent( obj.upFolder + "/s_" + obj.uuid + "_" + obj.fileName);
                var originImg = obj.upFolder + "\\" + obj.uuid + "_" + obj.fileName;
                originImg = originImg.replace(new RegExp(/\\/g), "/");
                liTag += '<img src="/display?fileName='+ thumbImg +'"></a><br>' + obj.fileName + '<button type="button" class="btn btn-warning btn-circle" data-file="' + thumbImg + '" data-type="image"><i class="fa fa-times"></i></button></li>';
            } else {
                var filePath = encodeURIComponent( obj.upFolder + "/" + obj.uuid + "_" + obj.fileName);
                liTag += '<img src="/resources/img/attach.png"></a><br>'+ obj.fileName + '<button type="button" class="btn btn-warning btn-circle btn-xs" data-file="' + filePath + '" data-type="file"><i class="fa fa-times"></i></button></li>';
            }
        });

        resultUL.append(liTag);
    }

    $('.uploadResult').on('click', 'button', function() {
        var x = $(this).closest('li');
        $.ajax({
            type : 'post',
            url : '/asdeleteFile',
            data : {
                fileName : $(this).data('file'),
                type : $(this).data('type')
            },
            dataType : 'text',
            beforeSend : function(xhr){
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            success : function(result, status, xhr) {
                alert(result);
                x.remove();
            },
            error : function(xhr, status, er) {
                console.log("delete error");
            }
        });
    });
</script>