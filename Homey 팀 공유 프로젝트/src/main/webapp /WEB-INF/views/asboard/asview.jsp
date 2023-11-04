<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<!--======= main ======= -->
<main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <div class="breadcrumbs d-flex align-items-center" style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
        <div class="container position-relative d-flex flex-column align-items-center" data-aos="fade">
            <h2>AS 문의 등록</h2>
        </div>
    </div>
    <!-- End Breadcrumbs -->

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
                    <form action="/asboard/asmodify">
                        <div class="form-group" style="border: 1px solid #000; background-color: #f2f2f2; padding: 10px;">
                            <h2> 제목: ${asBoardVO.title}</h2>
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 10%;"><strong>작성자:</strong> ${asBoardVO.mid}</td>
                                    <td style="width: 10%;"><strong>작성일:</strong> <fmt:formatDate value="${asBoardVO.regDate}" pattern="yyyy-MM-dd (E)"/></td>
<c:if test="${asBoardVO.regDate != asBoardVO.updateDate}">
    <td style="width: 10%;"><strong>수정일:</strong> <fmt:formatDate value="${asBoardVO.updateDate}" pattern="yyyy-MM-dd (E)"/></td>
</c:if>

                                    
                                    <td style="width: 10%;"><strong>처리상황:</strong> ${asBoardVO.status}</td>
                                </tr>
                            </table>
                        </div>
                        <!-- 내용 폼 -->
                        <div class="form-group" style="border: 1px solid #000; background-color: #f2f2f2; padding: 20px; margin-bottom: 20px;">
                            <div class="row">
                                <div class="col-lg-6">
                                    <!-- 첨부 파일 -->
                                    <div class="row justify-content-center">
                                        <div class="col-lg-12">
                                            <div class="panel panel-default">
                                                <div class="panel-heading"></div>
                                                <div class="panel-body">
                                                    <!-- 업로드 결과 출력 -->
                                                    <div class="uploadResult">
                                                        <ul></ul>
                                                    </div>
                                                    <!-- END 업로드 결과 출력 -->

                                                    <!-- 썸네일 원본 이미지 표시 -->
                                                    <div class="originImgDiv">
                                                        <div class="originImg"></div>
                                                    </div>
                                                    <!-- END 썸네일 원본 이미지 표시 -->
                                                </div> <!-- /.panel-body -->
                                            </div> <!-- /.panel -->
                                        </div> <!-- /.col-lg-12 -->
                                    </div> <!-- /.row -->
                                    <!-- END 첨부 파일 -->
                                </div>
                                <div class="col-lg-6">
    <textarea id="newContent" name="content" class="form-control" rows="8" readonly>${asBoardVO.content}</textarea>
</div>

                            </div>
                        </div>

                       <c:if test="${not empty asBoardVO.replyContent}">
    <fieldset>
        <legend>답변</legend>
        <table style="width: 100%;">
            <tr>
                <td style="width: 50%;"><strong>답변 작성일:</strong> <fmt:formatDate value="${asBoardVO.replyRegDate}" pattern="yyyy-MM-dd (E)"/></td>
<c:if test="${asBoardVO.replyRegDate != asBoardVO.replyUpdateDate}">
    <td style="width: 50%;"><strong>답변 수정일:</strong> <fmt:formatDate value="${asBoardVO.replyUpdateDate}" pattern="yyyy-MM-dd (E)"/></td>
</c:if>
                
            </tr>
        </table>
        <div class="form-group">
    <div style="border: 1px solid #ccc; padding: 10px; margin-bottom: 200px;">
        <textarea name="replyContent" style="width: 100%; height: 300px;" readonly>${asBoardVO.replyContent}</textarea>
    </div>
</div>

        </div>
    </fieldset>
</c:if>
<sec:authorize access="hasRole('ROLE_ADMIN')">
    <input type="hidden" id="isAdmin" value="true">
</sec:authorize>
<sec:authorize access="!hasRole('ROLE_ADMIN')">
    <input type="hidden" id="isAdmin" value="false">
</sec:authorize>


                        <div class="text-center">
<sec:authorize access="hasRole('ROLE_MEMBER') or hasRole('ROLE_ADMIN')">
<a href="/asboard/redirect" class="btn btn-primary">목록으로</a>
                                <a href="/asboard/asmodify?bno=${asBoardVO.bno }" class="btn btn-warning">수정하기</a>
                                <button type="button" class="btn btn-danger removeBtn" >삭제하기</button>
                            </sec:authorize>
                        </div>

                        <form action="/asboard/remove" method="post" id="actionFrm">
                            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                            <input type="hidden" name="bno" value="${asBoardVO.bno }">
                        </form>

                        <sec:authorize access="isAuthenticated()">
                            <input type="hidden" id="mid" value="<sec:authentication property='principal.username' />">
                        </sec:authorize>

                        <sec:authorize access="!isAuthenticated()">
                            <input type="hidden" id="mid" value="">
                        </sec:authorize>
                    </form>
                </div> <!-- /.panel-body -->
            </div> <!-- /.panel -->
        </div> <!-- /.col-lg-6 -->
    </div> <!-- /.row -->
</main>
	
<script>
var csrfHeaderName = '${_csrf.headerName}';
var csrfTokenValue = '${_csrf.token}';
var bno = '${asBoardVO.bno}'; //bno 값을 설정해주세요.

$(document).ready(function() {
    $('.btn-warning').on('click', function(e) { // 수정 버튼에 이벤트 핸들러를 추가합니다.
        var replyContent = '${asBoardVO.replyContent}'; // 답변의 내용을 가져옵니다.
        var isAdmin = $('#isAdmin').val() === 'true'; // 사용자가 관리자인지 확인합니다.
        if (replyContent && !isAdmin) { // 답변이 존재하고 사용자가 관리자가 아니면
            e.preventDefault(); // 버튼의 기본 동작(폼 제출)을 막습니다.
            alert('관리자가 답변을 작성했습니다. 수정할 수 없습니다.'); // 알림을 띄웁니다.
        }
    });
});


$('.removeBtn').on('click', function() {
    if(confirm('삭제하시겠습니까?')) {
        $.ajax({
            url: "/asboard/asremove",
            type: "POST",
            data: {
                bno: bno
            },
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            success: function(response) {
                // 성공 시 동작을 여기에 작성해주세요.
                location.href = response; // 반환된 URL로 이동
            },
            error: function(xhr, status, error) {
                // 실패 시 동작을 여기에 작성해주세요.
                console.error(error);
            }
        });
    }
});

// 첨부 파일 목록 가져오기
var bnoVal = '${asBoardVO.bno}';

(function() {
   $.getJSON('/asboard/attachList', { bno: bnoVal }, function(result) {
      showUploadedFile(result);
   });
})();

// 업로드 결과 출력
var resultUL = $('.uploadResult ul');

function showUploadedFile(result) {
    var liTag = '';

    $(result).each(function(i, obj) {
        liTag += '<li data-uuid="' + obj.uuid + '" data-folder="' + obj.upFolder + '" data-filenm="' + obj.fileName + '" data-image="' + obj.image + '">';

        if (obj.image) {
            var thumbImg = encodeURIComponent(obj.upFolder + "/s_" + obj.uuid + "_" + obj.fileName);
            liTag += '<img src="/display?fileName=' + thumbImg + '" width="200" height="200"></a><br>' + obj.fileName + '</li>';
        } else {
            var filePath = encodeURIComponent(obj.upFolder + "/" + obj.uuid + "_" + obj.fileName);
            liTag += '<img src="/resources/img/attach.png"></a><br>' + obj.fileName + '</li>';
        }
    });

    resultUL.append(liTag);
}

</script>
