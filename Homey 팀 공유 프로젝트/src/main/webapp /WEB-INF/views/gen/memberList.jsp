<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 나눔 목록</title>

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
table {  text-align: center;
			 font-size: 14px; }
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
    <h2>Member List</h2>
  </div>
</div><!-- End Breadcrumbs -->


<!-- 문의글 등록/삭제 완료 메시지가 있는 경우, fPdtList.jsp로 돌아오면서 msg내용을 alert으로 띄우기 --> 
<c:if test="${!empty msg }">
	<script>
			alert('${msg}');
	</script>
</c:if>


<!-- ======= 원데이클래스 게시글 목록 ======= -->
 
<section id="blog" class="blog">
    <div class="container" data-aos="fade-up" data-aos-delay="100">
    <div class="row justify-content-between gy-4 mt-4">
    <div class="col-lg-9 mx-auto">
	    <div class="portfolio-description">
	    
	        <h2>회원 리스트</h2>
			<br>
			
			<div class="container">
		
			<br>
			
			<!-- 리스트 출력 시작 구간 --------------------------------------->
			<!-- 게시물이 없는 경우 -->
			<c:if test="${empty list }">
				<div class="row">
				<div class="col" align="center"> 
					<p class="alert alert-warning p-5">
						가입된 회원이 없습니다.
					</p>
				</div>
				</div>
			</c:if>	
			
			<!-- 게시물이 있는 경우 -->
			<c:if test="${!empty list }">
				<table class="table table-hover">
                    <thead>
                        <tr>
                            <th>아이디</th>
                            <th>이름</th>
                            <th>전화번호</th>
                            <th>이메일</th>
                            <th>주소</th>
                            <th>가입일</th>
                        </tr>
                    </thead>
                    <tbody>
                    <!------------- Model 데이터 출력 ---------------> 
                    <c:forEach items="${list }" var="member">
                  		<tr>
                  		
                  			<td><a href="/gen/memberView?mid=${member.mid }&pageNum=${pageDTO.cri.pageNum}&amount=${pageDTO.cri.amount}">${member.mid }</a></td>
                  			<td><a href="/gen/memberView?mid=${member.mid }&pageNum=${pageDTO.cri.pageNum}&amount=${pageDTO.cri.amount}">${member.mname }</a></td>
                  			<td class="title"><a href="/gen/memberView?mid=${member.mid }&pageNum=${pageDTO.cri.pageNum}&amount=${pageDTO.cri.amount}">${member.mphone }</a>	</td><!-- href의 나머지 내용은 스크립트에서 처리-->
                  			<td><a href="/gen/memberView?mid=${member.mid }&pageNum=${pageDTO.cri.pageNum}&amount=${pageDTO.cri.amount}">${member.memail }</a></td>
                  			<td><a href="/gen/memberView?mid=${member.mid }&pageNum=${pageDTO.cri.pageNum}&amount=${pageDTO.cri.amount}">${member.maddr}</a></td>
                  			<td><a href="/gen/memberView?mid=${member.mid }&pageNum=${pageDTO.cri.pageNum}&amount=${pageDTO.cri.amount}"><fmt:formatDate value="${member.mdate }" pattern="yyyy-MM-dd"/></a></td>
                  		</tr>
                    </c:forEach>
                    <!------------- END Model 데이터 출력 ----------->
                    </tbody>
                </table> <!-- /.table-responsive -->
			</c:if>	
			<!-- END 리스트 출력 구간 --------------------------------------->
			
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
				<form action="/gen/memberList" id="actionFrm">
					<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
					<input type="hidden" name="amount"  value="${pageDTO.cri.amount}">
				</form>		

		</div><!-- End container -->
	    </div><!-- End portfolio-description -->
    </div><!-- End col-lg-8 mx-auto -->
   <%@ include file="../includes/sideMenuAdm.jsp"%>
    </div><!-- End row justify-content-between -->
    </div><!-- End container -->

</section><!-- End Project Details Section -->
 


</main><!-- End #main -->


<%@ include file="../includes/footer.jsp"%>




<script>

//	$(function(){				//이거 붙여야 할 수도..? 게시글 등록, 삭제 후 목록으로 접속한 경우, 스크립트태그를 먼저 스캔하게 하려고


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







//		});//END 		//function~ 넣게 되면 살려야 함


</script>


</body>
</html>
