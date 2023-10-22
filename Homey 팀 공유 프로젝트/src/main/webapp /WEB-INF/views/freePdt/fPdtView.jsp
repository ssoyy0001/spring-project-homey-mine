<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 나눔 상세조회</title>

<style>

#notice {  color: red;		}
#fpTitleBox {		border: 2px solid #FFA500; /* 진노랑색 테두리 */
    						padding: 10px; /* 텍스트와 테두리 사이의 간격을 10px로 지정 */		}
.fpTitle {	text-align: center;	}
.regiItemNm {	width: 150px;
						font-weight: bold;		}
.regiItem {		width: 200px;	
						border: none; /* 테두리 없음 */
        				outline: none; /* 포커스 표시 없음 */	}
.imgNotice {	font-size: 10px; color: lightcoral;   }
#fpItem {	margin-bottom: 20px; 	}
#fpvoImg{ width:40%;	display: block;	margin:auto;	}			/* 띄울 사진 크기*/
.tags, p{	 color: #F44336; 	}
.regiText{	color: #FFA000;		}
.reqForm{		background-color: #FFF8E1;		}

  .redText {
    color: #FF6347; /* 텍스트 색상을 빨간색으로 지정 */
  }

  /* boldText 클래스의 스타일 */
  .boldText {
    font-weight: bold;
    color: #FF8C00; /* 글자를 두꺼운 굵은체로 설정 */
  }
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
    <h2>HOMEY Product Trial</h2>
  </div>
</div><!-- End Breadcrumbs -->


<!-- ======= 제품 나눔 안내글 상세조회 ======= -->

    <section id="blog" class="blog">
      <div class="container" data-aos="fade-up" data-aos-delay="100">
        <div class="row g-5">
          <div class="col-lg-8 mx-auto">
            <article class="blog-details">
              
				<h2 class="title">📝제품 나눔 안내글</h2>
				<br>
				<div class="meta-top">
				  <ul>
				    <li class="d-flex align-items-center"><i class="bi bi-clock"></i> 모집마감일 | ${fpvo.fpDeadline} </li>
				  </ul>
				</div><!-- End meta top -->
				
			<!-- ======= 상세내용이 표시되기 시작함 ======= -->
              <div class="content">
                <br>

                <div class="form-group" id="fpItem">
					<label class="regiItemNm redText">당첨인원</label>
					<input type="text" name="fpPeople" class="regiItem boldText" value="${fpvo.fpPeople}" readonly>
				</div>
				
				<div class="form-group" id="fpItem">
					<label class="regiItemNm redText">현재 참여자 인원</label>
					<input type="text" name="fpNowPeople" class="regiItem boldText" value="${fpvo.fpNowPeople}" readonly>
				</div>
                				
				<div class="form-group" id="fpItem">
					<label class="regiItemNm">모집현황</label>
					<c:choose>
				        <c:when test="${fpvo.fpState eq 0}">
				            <input type="text" name="fpState" class="regiItem" value="나눔중" readonly>
				        </c:when>
				        <c:when test="${fpvo.fpState eq 1}">
				            <input type="text" name="fpState" class="regiItem" value="신청마감" readonly>
				        </c:when>
				    </c:choose>
				</div>
				
				<div class="form-group" id="fpItem">
					<label class="regiItemNm">나눔물품</label>
					<input type="text" name="freePdt" class="regiItem" value="${fpvo.freePdt}" readonly>
				</div>
				
				<div class="form-group" id="fpItem">
					<label class="regiItemNm">수령일</label>
					<input type="text" name="fpGetDate" class="regiItem" value="${fpvo.fpGetDate}" readonly>
				</div>
				
				<div class="form-group" id="fpItem">
					<label class="regiItemNm">수령장소</label>
					<input type="text" name="fpGetPlace" class="regiItem" value="${fpvo.fpGetPlace}" readonly>
				</div>
				
				<br>
				<hr>
				<br>
				
				<div class="form-group fpTitleBox" id="fpItem">
					<label class="regiItemNm fpTitle">제    목 ::</label>${fpvo.fpTitle}
				</div>
				
				<div class="form-group">
					<textarea name="fpContent" class="form-control regiItem" rows="5" readonly>${fpvo.fpContent }</textarea>
				</div>
				
				<br>
				<hr>
				<br>
				
				<div class="form-group">
					<img src="../freePdt/display?fileName=${fpvo.fpImg}" id="fpvoImg">
				</div>	

              </div><!-- End post content -->
			  <br>
              <div class="meta-bottom">
                <i class="bi bi-tags"></i>
                <ul class="tags">
                  <li> 수령일로부터 일주일 안에 수령하지 않으면 나눔당첨이 취소됩니다.</li>
                </ul>
                <br>
                <i class="bi bi-tags"></i>
                <ul class="tags">
                  <li> 수령일 및 수령장소를 확인하지 않아 물품수령에 차질이 생길 시, 그 책임은 당첨자에게 있습니다.</li>
                </ul>
              </div><!-- End meta bottom -->
            </article><!-- End blog post -->
          </div>
        </div>
      </div>
    </section><!-- End Blog Details Section -->
    
    <form action="/freePdt/modify" method="get" role="form" id="actionFrm">
		<input type="hidden" name="fpNo" value="${fpvo.fpNo}">
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
			<a href="/freePdtReq/list?fpNo=${fpvo.fpNo}&fpTitle=${fpvo.fpTitle}" class="btn btn-info">신청자 조회</a>
			</sec:authorize>
		</div>
	</form>
    				
    <!-- ======= 제품 나눔 신청 폼 ======= -->
    <section id="blog" class="blog">
      <div class="container" data-aos="fade-up" data-aos-delay="100">
        <div class="row g-5">
          <div class="col-lg-8 mx-auto">
            <div class="comments">
              <div class="reply-form reqForm">
                
                <form action="/freePdtReq/register" method="post" id="reqFrm" role="form" >
              		
              	  <p>* 수령일 기준 일주일 이내에 물품을 수령하지 않을 경우, 당첨취소 및 물품이 폐기됩니다.</p>
                  <p>* 수령일, 수령장소 확인 불찰로 인한 문제가 발생할 경우, 책임은 당첨자에게 있음을 안내합드립니다.</p>
                	
                  <hr>
                  
                  <br>
                  <div class="form-check">
					  <input type="checkbox" id="readCheck">
					  <label class="form-check-label" for="readCheck">  위의 안내사항을 확인했으며, 이에 동의합니다.</label>
				  </div>
				  
                  <div class="form-check">
					  <input type="checkbox"  id="privacyCheck">
					  <label class="form-check-label" for="privacyCheck">  HOMEY 측에서 신청자 정보 확인을 위해 회원정보를 조회하는 것에 동의합니다.</label>
				  </div>
				  
                  <br>
                  <input type="hidden" name="fpNo" value="${fpvo.fpNo}">
                  <input type="hidden" name="mid" value="<sec:authentication property="principal.Username"/>">
                  
                  <c:if test="${fpvo.fpState == 0 && checkResult == 0}"><!-- 중복신청여부(doubleCheck) : 0일 경우 -->
	                  <div class="text-center" id="btn-group">
	                  	<button type="submit"  id="reqBtn" class="btn btn-warning btn-lg">나눔 신청</button>
<!-- 	                  	<input type="submit" id="reqBtn" class="btn btn-warning" value="신청하기"> -->
					  </div>
				  </c:if>
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
        form.action = "/freePdt/remove"; 	// 삭제를 처리할 URL로 변경
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

    //체크박스
    var privacyCheck = document.getElementById("privacyCheck");
    var readCheck = document.getElementById("readCheck");

    if ( !privacyCheck.checked || !readCheck.checked) {
        alert("체크박스를 확인해주세요.");
    } else{
        if (confirm('신청하시겠습니까?')) {
            $('#reqFrm').submit();
        }
    }
});



</script>


</body>
</html>
