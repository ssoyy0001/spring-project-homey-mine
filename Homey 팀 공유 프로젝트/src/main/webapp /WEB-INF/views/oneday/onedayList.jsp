<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원데이클래스 목록</title>

<style>

/* 현재 클릭된 페이징 버튼 */
.custom-pagination .page-item.active .page-link {		
		border-color : 	#ffc107;
        background-color: 	#ffc107; 
        color: black; 
    }
    
/* 비활성 버튼 스타일 */
.custom-pagination .page-item .page-link { 	
		border-color : 	#ffc107;
        background-color: white; 
        color: 	#ffc107; 
    }

/*	게시글 제목(링크) 색상 */
tbody a { color : 	#333333; }

/* 게시글 제목(링크)에 마우스 올리면 진회색으로 표시 */
tbody a:hover { color : black; }			


/* 테이블의 텍스트 가운데 정렬, 제목만 왼쪽 정렬 */
table {  text-align: center; }
table td.title {    text-align: left;	}
  
  
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


<!-- ======= 원데이클래스 게시글 목록 ======= -->
 
<section id="project-details" class="project-details">
    <div class="container" data-aos="fade-up" data-aos-delay="100">
    <div class="row justify-content-between gy-4 mt-4">
    <div class="col-lg-8 mx-auto">
	    <div class="portfolio-description">
	    
	        <h2>📃 원데이클래스 안내글 목록</h2>
			<br>
			
			<div class="container">
			
			<!-- 검색 타입 및 검색 키워드 --------------------------------------->
	        <!-- 타입 : 제목T, 내용C, 제목/내용TC -->
			<div class="row">
				<div class="col-lg-12">
		        <form id="searchFrm" action="/oneday/list">
		        	<select name="type">
						<option value="T" ${pageDTO.cri.type == 'T' ? 'selected' : ''} >제목</option>
						<option value="C" ${pageDTO.cri.type == 'C' ? 'selected' : ''}>내용</option>
						<option value="TC" ${pageDTO.cri.type == 'TC' ? 'selected' : ''}>제목 or 내용</option>
					</select>
					<input type="text" name="keyword" value="${pageDTO.cri.keyword }"/>
					<button class="btn btn-success btn-sm searchBtn">검색</button>
		                	
					<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
		          	<input type="hidden" name="amount"  value="${pageDTO.cri.amount}">
		        </form>
	           	</div>
	        </div>
		    <!-- END 검색 타입 및 검색 키워드  ---------------------------------->
		
			<br>
			
			<!-- 리스트 출력 시작 구간 --------------------------------------->
			<!-- 게시물이 없는 경우 -->
			<c:if test="${empty list }">
				<div class="row">
				<div class="col" align="center"> 
					<p class="alert alert-warning p-5">
						등록된 게시글이 없습니다.
					</p>
				</div>
				</div>
			</c:if>	
			
			<!-- 게시물이 있는 경우 -->
			<c:if test="${!empty list }">
				<table class="table table-hover">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>모집현황</th>
                            <th>게시글 제목</th>
                            <th>모집인원</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                    <!------------- Model 데이터 출력 ---------------> 
                    <c:forEach items="${list }" var="odvo">
                  		<tr>
                  			<td>${odvo.odRn }</td>
                  			<td>
                  				<c:choose>
		                            <c:when test="${odvo.odState == 0}">모집중</c:when>
		                            <c:when test="${odvo.odState == 1}">모집마감</c:when>
		                        </c:choose>
                  			</td>
                  			<td class="title"><a class="move" href="${odvo.odNo }">${odvo.odTitle }</a>	</td><!-- href의 나머지 내용은 스크립트에서 처리-->
                  			<td>${odvo.odPeople }</td>
                  			<td><fmt:formatDate value="${odvo.odWDate}" pattern="yyyy-MM-dd"/></td>
                  		</tr>
                    </c:forEach>
                    <!------------- END Model 데이터 출력 ----------->
                    </tbody>
                </table> <!-- /.table-responsive -->
			</c:if>	
			<!-- END 리스트 출력 구간 --------------------------------------->
			
			<br>
			<!------ 글작성 버튼 ------>
			<div class="text-center">
				<sec:authorize access="hasRole('ROLE_ADMIN')"><!-- ROLE_ADMIN 권한을 가진 사람이 로그인했을 때만 버튼 표시 -->
			    <a href="/oneday/register" class="btn btn-warning">글작성</a>
			    </sec:authorize>
			</div>
			
			<br>
			
			<!-- paging -------------------------------->
                <div class="pull-right">
					<ul class="pagination justify-content-center custom-pagination">
						<%-- 이전 버튼 --%>
						<c:if test="${pageDTO.prev }">
						<li class="page-item">
							<a href="${pageDTO.start - 1}" 
							   class="page-link">&laquo; Previous</a></c:if>
						
						<%-- 페이지 번호 버튼 --%>
						<c:forEach begin="${pageDTO.start }" 
								   end="${pageDTO.end }" var="i">
						<%-- <c:url var="link" value=""/> --%>
						<li class="page-item ${pageDTO.cri.pageNum == i ? 'active' : '' }">
							<a href="${i }" 
							   class="page-link">${i }</a>
						</c:forEach>
						
						<%-- 다음 버튼 --%>
						<c:if test="${pageDTO.next }">
						<li class="page-item">
							<a href="${pageDTO.end + 1}" 
							   class="page-link">Next &raquo;</a></c:if>
					</ul>					
                </div>
			<!-- END paging -------------------------------->

            <!-- 현재 페이지 번호 및 출력 게시물 수 전송 폼 -->
				<form action="/oneday/list" id="actionFrm">
					<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
					<input type="hidden" name="amount"  value="${pageDTO.cri.amount}">
					<input type="hidden" name="type"  value="${pageDTO.cri.type}">
					<input type="hidden" name="keyword"  value="${pageDTO.cri.keyword}">
				</form>		

			<!-- Modal 게시물 등록 완료 시 표시 -->
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
			
		<br>

		</div><!-- End container -->
	    </div><!-- End portfolio-description -->
    </div><!-- End col-lg-8 mx-auto -->
    </div><!-- End row justify-content-between -->
    </div><!-- End container -->

</section><!-- End Project Details Section -->
 


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

// 스크립트 맨 윗부분에 $(function(){를 넣어야 할지도..? 일단 안넣고 시도

//검색 버튼 이벤트 처리 ---------------------------
var searchFrm = $('#searchFrm');

$('.searchBtn').on('click', function(e){
	
	//검색어 없이 검색버튼 클릭 시 얼럿 뜨도록 -> searchFrm.submit() 보다 위에 있어야 함
    if (searchFrm.find("input[name='keyword']").val() === "") {		//이렇게 하거나, 아님 input에 아이디 붙여서 #OOO으로 간단하게 써도 됨
        alert("검색어를 입력하세요.");
    	return false;
    }
	
    //검색버튼을 눌렀을 때, pageNum이 1페이지로 바뀌도록
    searchFrm.find("input[name='pageNum']")
					.val(1);
    searchFrm.submit();
});
	
//END 검색 버튼 이벤트 처리 ---------------------


//페이징 이벤트 처리 ------------------------------
var actionFrm = $('#actionFrm');

$('.page-item a').on('click', function(e){						//페이징 버튼을 클릭하면
	e.preventDefault();
	
	//a 태그의 href 값을 actionFrm의 pageNum에 저장
	actionFrm.find("input[name='pageNum']")
			 	   .val($(this).attr('href'));
	
	actionFrm.submit();
});
//END 페이징 이벤트 처리 ------------------------------


//게시물 제목 클릭 이벤트 처리 ------------------------------
//단계 : 제목 클릭 > actionFrm에 hidden태그 추가 > action의 속성 변경 > 컨트롤러 도착   => 컨트롤러에 amount에 pageNum받을 수 있도록 만들어주기

$('.move').on('click', function(e){
	e.preventDefault();							//<a>태그의 href로 이동하는 것을 막음
	
	//hidden태그를 생성하여 이름을 odNo로 지정하고,
	//a 태그의 href 값을 odNo에 저장 
	actionFrm.append("<input type='hidden' name='odNo' value='" + $(this).attr('href') + "'>");	 //this : <a>태그
	
	//"oneday/view"로 갈 때, mid도 보내야 함. (중복신청체크! 원데이클래스 신청하기 버튼 표시 유무 때문에)
	actionFrm.append("<input type='hidden' name='mid' value='" + '${pageContext.request.userPrincipal.name}' + "'>");
	
	//원래 form의 actionform은 "/oneday/list"였는데, 이제 게시글제목을 클릭했기 때문에 view페이지로 이동해야 함.
	//action의 속성값을 컨트롤러의 view메서드로 바꿔주기
	actionFrm.attr('action', '/oneday/view');
	
	actionFrm.submit();
});

//END 게시물 제목 클릭 이벤트 처리 ------------------------------



//게시글 등록/삭제 완료 메시지가 있는 경우, msg내용을 alert으로 띄우기 ---------------------------------------
var msg = '${msg}';
checkModal(msg);

//모달 창 재출력 방지
history.replaceState({}, null, null); //history 초기화

function checkModal(msg){
	//msg 값이 있는 경우에 모달 창 표시 (msg는 등록/삭제 시 컨트롤러에서 보냄)
	if(msg === '' || history.state) {
		return;
	}
	
	if( parseInt(msg) > 0) { 			//게시물이 등록된 경우 (msg에 게시물번호가 담김)
		$('.modal-body').html(msg + '번 게시물이 등록되었습니다.'); 
	}
	
	$('#myModal').modal('show');
}
//END 게시물 처리 결과 알림 모달창 처리 ---------------------------------------


//	여기에  });//END $ 넣어야 할지도?


</script>


</body>
</html>
