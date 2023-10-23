<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원데이클래스 상세조회</title>

<style>

#notice {  color: red;		}
.reqNotice{	text-align: center; 
					color: red;	}		/*이미 신청했거나 모집마감된 게시글이라고 알려줄 때 */
#odTitleBox {		border: 2px solid #FFA500; /* 진노랑색 테두리 */
    						padding: 10px; /* 텍스트와 테두리 사이의 간격을 10px로 지정 */		}
.odTitle {	text-align: center;	}
.regiItemNm {	width: 150px;
						font-weight: bold;		}
.regiItem {		width: 200px;	
						border: none; /* 테두리 없음 */
        				outline: none; /* 포커스 표시 없음 */	}
.imgNotice {	font-size: 10px; color: lightcoral;   }
#odItem {	margin-bottom: 20px; 	}
#pvoImg{ width:40%;	display: block;	margin:auto;	}			/* 띄울 사진 크기*/
.tags, p{	 color: #F44336; 	}
.regiText{	color: #FFA000;		}
.reqForm{		background-color: #FFF8E1;		}

</style>

</head>
<body>
<!-- ======= header ======= -->
<%@ include file="../includes/header.jsp" %>

<!--======= main ======= -->
<main id="main">

<!-- ======= Breadcrumbs ======= -->
<div class="breadcrumbs d-flex align-items-center" style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
  <div class="container position-relative d-flex flex-column align-items-center" data-aos="fade">
    <h2>Oneday Class</h2>
  </div>
</div><!-- End Breadcrumbs -->


<!-- ======= 원데이클래스 안내글 상세조회 ======= -->

    <section id="blog" class="blog">
      <div class="container" data-aos="fade-up" data-aos-delay="100">
        <div class="row g-5">
          <div class="col-lg-8 mx-auto">
            <article class="blog-details">
              
				<h2 class="title">📝원데이클래스 안내글</h2>
				<br>
				<div class="meta-top">
				  <ul>
				    <li class="d-flex align-items-center"><i class="bi bi-person"></i> 클래스 진행일시 | ${odvo.odDate }</li>
				    <li class="d-flex align-items-center"><i class="bi bi-clock"></i> 모집마감일 | ${odvo.odDeadline} </li>
				  </ul>
				</div><!-- End meta top -->
				
			<!-- ======= 상세내용이 표시되기 시작함 ======= -->
              <div class="content">
                <br>

                <!--------------------- 상품 상세조회 -------------------->				
				<div class="form-group" id="odItem">
					<label class="regiItemNm">모집현황</label>
					<c:choose>
				        <c:when test="${odvo.odState eq 0}">
				            <input type="text" name="odState" class="regiItem" value="모집중" readonly>
				        </c:when>
				        <c:when test="${odvo.odState eq 1}">
				            <input type="text" name="odState" class="regiItem" value="모집마감" readonly>
				        </c:when>
				    </c:choose>
				</div>
				
				<div class="form-group" id="odItem">
					<label class="regiItemNm">진행장소</label>
					<input type="text" name="odPlace" class="regiItem" value="${odvo.odPlace}" readonly>
				</div>
				
				<div class="form-group" id="odItem">
					<label class="regiItemNm">진행자</label>
					<input type="text" name="odMc" class="regiItem" value="${odvo.odMc}" readonly>
				</div>
				
				<div class="form-group" id="odItem">
					<label class="regiItemNm">예상소요시간</label>
					<input type="text" name="odTime" class="regiItem" value="${odvo.odTime}" readonly>
				</div>
				
				<div class="form-group" id="odItem">
					<label class="regiItemNm">모집인원</label>
					<input type="text" name="odPeople" class="regiItem" value="${odvo.odPeople}명" readonly>
				</div>
				
				<div class="form-group" id="odItem">
					<label class="regiItemNm">원데이클래스 이름</label>
					<input type="text" name="odName" class="regiItem" value="${odvo.odName}" readonly>
				</div>
				
				<br>
				<hr>
				<br>
				
				<div class="form-group odTitleBox" id="odItem">
					<label class="regiItemNm odTitle">제    목 ::</label>${odvo.odTitle}
				</div>
				
				<div class="form-group">
					<textarea name="odContent" class="form-control regiItem" rows="5" readonly>${odvo.odContent }</textarea>
				</div>
				
				<br>
				<hr>
				<br>
				
				<div class="form-group">
					<img src="../oneday/display?fileName=${odvo.odImg}" id="odImg">
				</div>	

              </div><!-- End post content -->

              <div class="meta-bottom">
                <i class="bi bi-tags"></i>
                <ul class="tags">
                  <li> 모집마감일에 유의하시어 당첨여부를 잘 확인해주세요.</li>
                </ul>
              </div><!-- End meta bottom -->
            </article><!-- End blog post -->
          </div>
        </div>
      </div>
    </section><!-- End Blog Details Section -->
    
    <form action="/oneday/modify" method="get" role="form" id="actionFrm">
		<input type="hidden" name="odNo" value="${odvo.odNo}">
        <input type="hidden" name="pageNum" value="${cri.pageNum}">
      	<input type="hidden" name="amount"  value="${cri.amount}">
        <input type="hidden" name="type"  value="${cri.type}">
        <input type="hidden" name="keyword"  value="${cri.keyword}">
               	
        <input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
               	
         <div class="text-center" id="btn-group">
         	<button type="button" class="btn btn-secondary" onclick="history.back()">목록</button>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
			<input type="submit" class="btn btn-warning" value="수정"/>
			<button id="RemoveBtn" class="btn btn-danger">삭제</button>
			<a href="/odReq/list?odNo=${odvo.odNo}&odTitle=${odvo.odTitle}" class="btn btn-info">신청자 조회</a>
			<a href="/odReq/winList?odNo=${odvo.odNo}&odTitle=${odvo.odTitle}" class="btn btn-primary">당첨자 조회</a>
			</sec:authorize>
		</div>
	</form>
    				
    <!-- ======= 원데이클래스 신청 폼 ======= -->
    <section id="blog" class="blog">
      <div class="container" data-aos="fade-up" data-aos-delay="100">
        <div class="row g-5">
          <div class="col-lg-8 mx-auto">
            <div class="comments">
              <div class="reply-form reqForm">

                <h4 class="regiText">🎨 원데이클래스 신청</h4>
                <p>* 항목은 필수 입력 항목입니다.</p>
                <br>
                
                <form action="/odReq/register" method="get" id="reqFrm" role="form" >
              
                  <input type="hidden" name="odNo" value="${odvo.odNo}">

                  <div class="row">
                    <div class="col-md-6 form-group">
                      <label class="regiItemNm">신청자 ID </label>
                      <input name="mid" type="text" class="form-control" value="<sec:authentication property="principal.Username"/>" readonly>
                    </div>
                  </div>
                  
                  <div class="row">
                    <div class="col form-group">
                      <label class="regiItemNm">* 제   목</label>
                      <br>
                      <input name="odReqTitle" type="text" class="form-control">
                    </div>
                  </div>
                  
                  <div class="row">
                    <div class="col form-group">
                      <label class="regiItemNm">* 사   연</label>
                      <br>
                      <textarea name="odReqContent" class="form-control" rows="10" placeholder="&#13;&#10;원데이클래스 주제와 관련하여 간단한 사연을 작성해보세요.&#13;&#10; &#13;&#10; -자기소개 &#13;&#10; -주제에 대한 관심도 등 무엇이든 좋습니다."></textarea>
                    </div>
                  </div>
                  
                  <hr>
                  
                  <br>
                  <div class="form-check">
					  <input type="checkbox"  id="privacyCheck">
					  <label class="form-check-label" for="privacyCheck">  HOMEY 측에서 신청자 정보 확인을 위해 회원정보를 조회하는 것에 동의합니다.</label>
				  </div>
					
				  <div class="form-check">
					  <input type="checkbox" id="deadlineCheck">
					  <label class="form-check-label" for="deadlineCheck">  모집마감일을 확인하였습니다.</label>
				  </div>
                  <br>
                  <c:choose>
					    <c:when test="${odvo.odState != 0}">
					    	<hr>
					        <h3 class="reqNotice">　<span class="badge bg-danger"> 모집이 마감된 이벤트입니다. </span></h3>
					    </c:when>
					    <c:when test="${checkResult != 0}">
					        <hr>
					        <h3 class="reqNotice">　<span class="badge bg-success"> 이미 신청한 이벤트입니다. </span></h3>
					    </c:when>
					    <c:otherwise>
					        <div class="text-center" id="btn-group">
					            <button type="submit" id="reqBtn" class="btn btn-warning">신청하기</button>
					        </div>
					    </c:otherwise>
					</c:choose>
				  
                </form>

              </div>
            </div><!-- End blog comments -->
          </div>
        </div>
      </div>
    </section><!-- End Blog Details Section -->

<!-- Modal 게시물 수정 완료 시 표시 -->
             <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                 <div class="modal-dialog">
                     <div class="modal-content">
                         <div class="modal-header">
                             <button type="button" class="close" 
                             		data-dismiss="modal" aria-hidden="true">&times;</button>
                             <h4 class="modal-title" id="myModalLabel">
                             	MESSAGE</h4>
                         </div>
                         <div class="modal-body">
                             처리가 완료되었습니다.
                         </div>
                         <div class="modal-footer">
                             <button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
                         </div>
                     </div>  <!-- /.modal-content -->
                 </div>		<!-- /.modal-dialog -->
             </div>          <!-- /.modal -->
<!-- END Modal 게시물 등록 완료 시 표시 -->

</main><!-- End #main -->

<%@ include file="../includes/footer.jsp"%>

  <a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
  <div id="preloader"></div>
  <!-- 자바스크립트 파일 -->
  <script src="../resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="../resources/assets/vendor/aos/aos.js"></script>
  <script src="../resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="../resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="../resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="../resources/assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="../resources/assets/vendor/php-email-form/validate.js"></script>
  <!-- Template Main JS File -->
  <script src="../resources/assets/js/main.js"></script>


<script>


//"게시글 수정완료" 메시지가 있는 경우, msg내용을 alert으로 띄우기 ---------------------------------------
var msg = '${msg}';
checkModal(msg);

//모달 창 재출력 방지
history.replaceState({}, null, null); //history 초기화

function checkModal(msg){
	//msg 값이 있는 경우에 모달 창 표시 (msg는 수정 시 컨트롤러에서 보냄)
	if(msg === '' || history.state) {
		return;
	}
	
	if( parseInt(msg) > 0) { 			//게시물이 등록된 경우 (msg에 게시물번호가 담김)
		$('.modal-body').html(msg + '번 게시물이 등록되었습니다.'); 
	}
	
	$('#myModal').modal('show');
}
//END 게시물 처리 결과 알림 모달창 처리 ---------------------------------------



//삭제 버튼 클릭 이벤트 처리 ---------------------------------

document.addEventListener("DOMContentLoaded", function() {
  // "삭제" 버튼 찾아서 클릭 이벤트 핸들러를 연결
  var RemoveBtn = document.getElementById("RemoveBtn");
  if (RemoveBtn) {
	  RemoveBtn.addEventListener("click", function() {
      if (confirm("게시물을 삭제하시겠습니까?")) {
        var form = document.getElementById("actionFrm");
        form.action = "/oneday/remove"; 	// 삭제를 처리할 URL로 변경
        form.method = "POST"; 					// POST 요청으로 변경
        form.submit();
      }
    });
  }
});

//END 삭제 버튼 클릭 이벤트 처리 ---------------------------------




// 원데이클래스 신청폼에서 [신청하기] 버튼 클릭 시 : 빈 항목 있는지, 체크박스 체크했는지 확인
$('#reqBtn').click(function(event) {
    event.preventDefault(); // form 제출 막기

    //필수 입력 항목
    var odReqTitle = $('input[name="odReqTitle"]').val();
    var odReqContent = $('input[name="odReqContent"]').val();

    //체크박스
    var privacyCheck = document.getElementById("privacyCheck");
    var deadlineCheck = document.getElementById("deadlineCheck");

    if (odReqTitle === "" || odReqContent === "") {
        alert("입력되지 않은 항목이 있습니다.");
    } else if( !privacyCheck.checked || !deadlineCheck.checked ){
    	alert("체크박스를 확인해주세요.");
    }else{
        if (confirm('신청하시겠습니까?')) {
            $('#reqFrm').submit();
        }
    }
});



</script>


</body>
</html>
