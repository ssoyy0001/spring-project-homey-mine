<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 나눔 상세조회</title>

<style>

#notice {  color: red;		}

/*이미 신청했거나 모집마감된 게시글이라고 알려줄 때 */
.reqNotice{	text-align: center; 
					color: red;	}		

/* 제품나눔 게시글 제목 */
.fpTitle {	text-align: center;	}

.regiItemNm {	width: 150px;
						font-weight: bold;		}
.regiItem {		width: 200px;	
						border: none;
        				outline: none; /* 포커스 표시 없음 */	}
#fpItem {	margin-bottom: 20px; 	}

/* 띄울 사진 크기*/
#fpImg{ width:90%;	display: block;	margin:auto;	}			
.tags, p{	 color: #F44336; 	}
.reqForm{		background-color: #FFF8E1;		}

.redText {
  color: #FF6347; /* 빨간색 */
}

/* 당첨인원, 현재 참여인원 글자스타일 */
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

<!-- 제품나눔 신청완료 메시지가 있는 경우, qnaListAll.jsp로 돌아오면서 msg내용을 alert으로 띄우기 --> 
<c:if test="${!empty msg }">
	<script>
			alert('${msg}');
	</script>
</c:if>

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
					<img src="../freePdt/display?fileName=${fpvo.fpImg}" id="fpImg">
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
        <input type="hidden" name="pageNum" value="${socri.pageNum}">
      	<input type="hidden" name="amount"  value="${socri.amount}">
        <input type="hidden" name="type"  value="${socri.type}">
        <input type="hidden" name="keyword"  value="${socri.keyword}">
               	
        <!-- 시큐리티 -->
		<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
               	
         <div class="text-center" id="btn-group">
         	<a id="ListBtn" class="btn btn-secondary">목록</a>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
			<input type="submit" class="btn btn-warning" value="수정"/>
			<button id="RemoveBtn" class="btn btn-danger">삭제</button>
			<a href="/freePdtReq/list?fpNo=${fpvo.fpNo}" class="btn btn-info">당첨자 조회</a>
			</sec:authorize>
		</div>
	</form>
    <br><br><br>
    
    			
    <!-- ======= 제품 나눔 신청 폼 ======= -->
    <sec:authorize access="not hasRole('ROLE_ADMIN')"><!-- 관리자가 아닐 경우에 신청폼 표시 -->
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
                  <!-- 시큐리티 -->
		          <input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
                  
                  
                  <c:choose>
					    <c:when test="${fpvo.fpState != 0}">
					    	<hr>
					        <h3 class="reqNotice">　<span class="badge bg-danger"> 모집이 마감된 이벤트입니다. </span></h3>
					    </c:when>
					    <c:when test="${checkResult != 0}">
					        <hr>
					        <h3 class="reqNotice">　<span class="badge bg-success"> 이미 신청한 이벤트입니다. </span></h3>
					    </c:when>
					    <c:otherwise>
					    	<sec:authorize access="not hasRole('ROLE_ADMIN')"><!-- 관리자가 아닐 경우에 신청버튼 표시 -->
			                  <div class="text-center" id="btn-group">
			                  	<button type="submit"  id="reqBtn" class="btn btn-warning btn-lg">나눔 신청</button>
							  </div>
							</sec:authorize>
					    </c:otherwise>
					</c:choose>
                </form>

              </div>
            </div><!-- End blog comments -->
          </div>
        </div>
      </div>
    </section><!-- End Blog Details Section -->
	</sec:authorize>

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

//목록 버튼 클릭 이벤트 처리 ---------------------------------

document.addEventListener("DOMContentLoaded", function() {
  // "목록" 버튼 찾아서 클릭 이벤트 핸들러를 연결
  var ListBtn = document.getElementById("ListBtn");
  if (ListBtn) {
	  ListBtn.addEventListener("click", function() {
        var form = document.getElementById("actionFrm");
        form.action = "/freePdt/list"; 	// 삭제를 처리할 URL로 변경
        form.method = "get";
        form.submit();
    });
  }
});

//END 목록 버튼 클릭 이벤트 처리 ---------------------------------



//[삭제] 버튼 클릭 이벤트 처리 ---------------------------------

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

 	// 값을 비교하여 선착순 마감 여부 확인
    if (${fpvo.fpPeople} === ${fpvo.fpNowPeople}) {
        alert("선착순 마감되었습니다.");
    } else if (!privacyCheck.checked || !readCheck.checked) {
        alert("체크박스를 확인해주세요.");
    } else {
        if (confirm('신청하시겠습니까?')) {
            $('#reqFrm').submit();
        }
    }//end If문
 	
});



</script>


</body>
</html>
